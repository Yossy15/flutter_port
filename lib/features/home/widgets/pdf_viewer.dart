import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:port/core/themes/app_color_extension.dart';
import 'package:port/core/extensions/theme_data.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfData;
  final double? height;
  final double? width;

  const PdfViewerPage({super.key, required this.pdfData, this.height, this.width});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  PdfControllerPinch? _controller;
  Object? _error;

  // Zoom state — เก็บแยกจาก controller เพื่อ UI only
  double _zoom = 1.0;
  static const double _minZoom = 1.0;
  static const double _maxZoom = 4.0;
  static const double _zoomStep = 0.25;

  // ป้องกัน rapid tap ทำให้ zoom เด้งหลายครั้ง
  bool _isZooming = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final String pdfData = widget.pdfData.trim();
    if (pdfData.isEmpty) {
      if (!mounted) return;
      setState(() => _error = ArgumentError.value(widget.pdfData, 'pdfData'));
      return;
    }

    try {
      // รองรับทั้ง asset path, URL, และ base64
      final PdfDocument doc;
      if (pdfData.startsWith('http://') || pdfData.startsWith('https://')) {
        final bytes = await _loadPdfFromUrl(pdfData);
        doc = await PdfDocument.openData(bytes);
      } else if (pdfData.startsWith('data:') || _isBase64(pdfData)) {
        final bytes = _decodeBase64(pdfData);
        doc = await PdfDocument.openData(bytes);
      } else {
        doc = await PdfDocument.openAsset(pdfData);
      }

      if (!mounted) return;
      setState(() {
        _controller = PdfControllerPinch(document: Future.value(doc));
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  bool _isBase64(String s) {
    // heuristic: ถ้า string ยาวและไม่มี path separator
    return s.length > 100 && !s.contains('/') && !s.contains('\\');
  }

  Uint8List _decodeBase64(String s) {
    // ตัด data URI prefix ถ้ามี: "data:application/pdf;base64,..."
    final payload = s.contains(',') ? s.split(',').last : s;
    return base64Decode(payload);
  }

  Future<Uint8List> _loadPdfFromUrl(String url) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException('Failed to load PDF ($url): ${response.statusCode}');
      }
      final bytes = await consolidateHttpClientResponseBytes(response);
      return bytes;
    } finally {
      client.close(force: true);
    }
  }

  // ใช้ animateToPage แทนการแตะ Matrix4 โดยตรง
  // zoom จริงๆ ของ PdfViewPinch ถูกควบคุมผ่าน TransformationController
  // แต่ pdfx ไม่ expose ตรงๆ — วิธีที่ถูกต้องคือ override ผ่าน
  // PdfControllerPinch.value ซึ่งเป็น TransformationController
  Future<void> _applyZoom(double nextZoom) async {
    if (_isZooming) return;
    final controller = _controller;
    if (controller == null) return;

    final clamped = nextZoom.clamp(_minZoom, _maxZoom);

    // อัพเดท UI ก่อน เพื่อ disable ปุ่มทันที (ป้องกัน double-tap)
    setState(() {
      _zoom = clamped;
      _isZooming = true;
    });

    try {
      // Animate zoom แทนการ set ทันที — ลื่นกว่ามาก
      await _animateZoom(controller, clamped);
    } finally {
      if (mounted) setState(() => _isZooming = false);
    }
  }

  Future<void> _animateZoom(
    PdfControllerPinch controller,
    double targetZoom,
  ) async {
    const duration = Duration(milliseconds: 250);
    const curve = Curves.easeOutCubic;
    const steps = 16; // ~60fps ใน 250ms

    final Matrix4 start = Matrix4.copy(controller.value);
    final Matrix4 end = Matrix4.identity()..scale(targetZoom, targetZoom, 1.0);

    // ดึง focal point จาก matrix ปัจจุบันเพื่อ zoom เข้ากลางหน้า
    for (int i = 1; i <= steps; i++) {
      final t = curve.transform(i / steps);
      final interpolated = _lerpMatrix4(start, end, t);
      controller.value = interpolated;

      // yield ให้ frame render ก่อนไปต่อ
      await Future.delayed(duration ~/ steps);
      if (!mounted) return;
    }

    controller.value = end;
  }

  Matrix4 _lerpMatrix4(Matrix4 a, Matrix4 b, double t) {
    final result = Matrix4.zero();
    for (int i = 0; i < 16; i++) {
      result[i] = a[i] + (b[i] - a[i]) * t;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.appColors;
    final double defaultHeight = MediaQuery.sizeOf(context).height * 0.6;
    final double viewerHeight = widget.height ?? defaultHeight;
    final double viewerWidth = widget.width ?? double.infinity;

    return SizedBox(
      width: viewerWidth,
      height: viewerHeight,
      child: ColoredBox(
        // ColoredBox เร็วกว่า DecoratedBox เมื่อแค่ระบุสี
        color: color.neutral.shade40,
        child: _buildContent(color),
      ),
    );
  }

  Widget _buildContent(AppColorsExtension appColors) {
    if (_error != null) {
      return const Center(child: Text('ไม่สามารถโหลด PDF ได้'));
    }
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        PdfViewPinch(
          controller: _controller!,
          backgroundDecoration: BoxDecoration(
            color: appColors.neutral.shade40,
          ),
          // ลด rebuild เมื่อ scroll โดยปิด scroll physics เฉพาะแกนที่ไม่ใช้
          scrollDirection: Axis.vertical,
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: _ZoomControls(
            zoom: _zoom,
            minZoom: _minZoom,
            maxZoom: _maxZoom,
            isZooming: _isZooming,
            onZoomIn: () => _applyZoom(_zoom + _zoomStep),
            onZoomOut: () => _applyZoom(_zoom - _zoomStep),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

// แยก widget ออกมาเพื่อให้ rebuild เฉพาะส่วน zoom controls
// ไม่กระทบ PdfViewPinch ด้านหลัง
class _ZoomControls extends StatelessWidget {
  final double zoom;
  final double minZoom;
  final double maxZoom;
  final bool isZooming;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const _ZoomControls({
    required this.zoom,
    required this.minZoom,
    required this.maxZoom,
    required this.isZooming,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'ขยาย',
            // disable ถ้า zoom ถึงขีดสุด หรือกำลัง animate อยู่
            onPressed: (isZooming || zoom >= maxZoom) ? null : onZoomIn,
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 2),
          IconButton(
            tooltip: 'ย่อ',
            onPressed: (isZooming || zoom <= minZoom) ? null : onZoomOut,
            icon: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}