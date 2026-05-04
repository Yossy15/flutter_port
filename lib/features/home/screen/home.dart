import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:port/core/extensions/theme_data.dart';
import 'package:port/core/responsive/screen_size_state.dart';
import 'package:port/core/widgets/dialog/dialog.dart';
import 'package:port/core/widgets/refresher/refresher.dart';
import 'package:port/features/_share_feature/widgets/action_button.dart';
import 'package:port/features/_share_feature/widgets/expandable_card.dart';
import 'package:port/features/home/enum/social.dart';
import 'package:port/features/home/state/user_provider.dart';
import 'package:port/features/home/widgets/loading/home_loading.dart';
import 'package:port/features/home/widgets/pdf_viewer.dart';
import 'package:port/gen/assets.gen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> openEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'ติดต่อสมัครงาน'},
    );

    if (kIsWeb) {
      final Uri gmail = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1&to=$email&su=ติดต่อสมัครงาน',
      );

      await launchUrl(gmail, mode: LaunchMode.externalApplication);
      return;
    }
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('No email app found');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = RefreshController(initialRefresh: false);
    final screenSize = ref.watch(screenSizeStateProvider);
    final userAsync = ref.watch(userProjectProvider);
    final theme = Theme.of(context);
    final color = theme.appColors;
    final text = theme.appTexts;

    return AppRefresher(
      controller: controller,
      onRefresh: () {
        ref.invalidate(userProjectProvider);
        controller.refreshCompleted();
      },
      child: userAsync.when(
        data: (user) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      // user.profileImageUrl.toString(),
                      MyAssets.images.profile.keyName,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  const Gap(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: text.headingLargeBold),
                        const Gap(4),
                        Text(
                          user.title,
                          style: text.bodyMediumRegular.copyWith(
                            color: color.neutral.shade50,
                          ),
                        ),
                        const Gap(12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Social.values.map((social) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ActionButton(
                                  icon: getSocialIcon(social),
                                  label: social.name,
                                  onTap: () {
                                    if (social.name == 'email') {
                                      openEmail(
                                        user.socialLinks[social.name]!
                                            .toString(),
                                      );
                                    } else if (social.name == 'telephone') {
                                      context.showCustomDialog(
                                        title: 'โทรศัพท์',
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              user.socialLinks[social.name]!,
                                              style: text.bodyMediumRegular,
                                            ),
                                            TextButton.icon(
                                              onPressed: () async {
                                                await Clipboard.setData(
                                                  ClipboardData(
                                                    text:
                                                        user.socialLinks[social
                                                            .name]!,
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'คัดลอกเบอร์เรียบร้อยแล้ว',
                                                    ),
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                  ),
                                                );
                                              },
                                              label: const Text('คัดลอก'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      launchUrl(
                                        Uri.parse(
                                          user.socialLinks[social.name]!,
                                        ),
                                      );
                                    }
                                    debugPrint(
                                      "${social.name}: ${user.socialLinks[social.name]}",
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(20),
              const Divider(),
              const Gap(20),
              ExpandableCard(
                title: 'Project นี้พัฒนาด้วย Flutter web',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textDetail(
                      title: 'ภาพรวม',
                      description:
                          'แอป Flutter โครงสร้างแยกตามฟีเจอร์ และการจัดการโฟลเดอร์ที่ชัดเจน',
                    ),
                    textDetail(
                      title: 'โครงสร้างหลัก',
                      description:
                          'โค้ดอยู่ใน lib โดยมีโฟลเดอร์สำคัญคือ core/ และ features/',
                    ),
                    textDetail(
                      title: 'การจัดการสถานะ',
                      description:
                          'ใช้ flutter_riverpod ร่วมกับ codegen (riverpod_annotation)',
                    ),
                    textDetail(
                      title: 'การนำทาง',
                      description:
                          'ใช้ go_router สำหรับ routing แบบ declarative',
                    ),
                    textDetail(
                      title: 'Responsive',
                      description:
                          'มีโมดูล layout/responsive ปรับการแสดงผลตามขนาดหน้าจอ (มือถือ/แท็บเล็ต/เดสก์ท็อป) ที่ต่างกัน',
                    ),
                    textDetail(
                      title: 'Asset & PDF',
                      description:
                          'ใช้ flutter_gen (gen ใน gen) และ viewer เช่น syncfusion_flutter_pdfviewer, pdfx',
                    ),
                  ],
                ),
              ),
              const Gap(20),
              const Divider(),
              const Gap(20),
              ExpandableCard(
                title: 'About Me',
                initialExpanded: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textDetail(
                      title: 'ข้อมูลแนะนำตัว',
                      description:
                          'สวัสดีครับ ข้าพเจ้าชื่อ "นายสุวิจักณ์ ใจสุข" ชื่อเล่น "พัดยศ" หรือ "Yossy" สำเร็จการศึกษาระดับปริญญาตรีจากมหาวิทยาลัยมหาสารคาม คณะวิทยาการสารสนเทศ สาขาวิชาวิทยาการคอมพิวเตอร์ ด้วยเกรดเฉลี่ย 3.11',
                    ),

                    textDetail(title: 'ประสบการณ์การทำงาน', description: 'เข้ารับการฝึกงานสหกิจศึกษาเป็นระยะเวลา 4 เดือน กับบริษัท "Night Bears Technology Co., Ltd." ในตำแหน่ง Mobile Developer (Flutter) โดยได้พัฒนาทักษะด้านการจัดการสถานะด้วย Riverpod 2.0 การพัฒนาฟีเจอร์ Pull-to-Refresh รวมถึงการออกแบบระบบงานล่วงหน้าผ่านการจัดทำ Blueprint บน Miro เพื่อใช้เป็นแนวทางในการพัฒนา Activity, API และ UI อย่างเป็นระบบและมีประสิทธิภาพ'),

                    textDetail(title: 'โครงการที่พัฒนา: Arpels Book', description: 'เป็นโครงการที่พัฒนาร่วมกับบริษัท Night Bears Technology Co., Ltd. ในช่วงการฝึกงานสหกิจศึกษา โดยพัฒนาเป็นเว็บแอปพลิเคชันด้วย Flutter Web'),

                    textDetail(title: 'ผลงานที่ภาคภูมิใจ', description: 'ได้รับทุนผ่านเข้ารอบการนำเสนอระดับภาค ในโครงการ NSC 2025 เป็นจำนวนทั้งหมด 10,000 บาท จากผลงานวิจัยเรื่อง "Mitigating Keylogger Threats by Secure On-Screen Keyboard"'),
                    
                    
                  ],
                ),
              ),
              const Gap(12),
              ExpandableCard(
                title: 'Documents (PDF)',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: user.documentsLinks.entries.map((document) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ActionButton(
                          icon: PhosphorIcons.filePdf(),
                          label: document.key,
                          onTap: () {
                            context.showCustomDialog(
                              child: PdfViewerPage(
                                pdfData: _documentPdfPath(document.key),
                              ),
                              title: document.key,
                              scrollable: false,
                              maxWidth: 1100,
                              maxHeightFactor: 0.94,
                            );
                            debugPrint("${document.key}: ${document.value}");
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Gap(12),
              ExpandableCard(
                title: 'Skills',
                child: Expanded(
                  child: Image.network(MyAssets.images.skill.keyName),
                ),
              ),
              const Gap(80),
              // ExpandableCard(
              //   title: 'Projects',
              //   initialExpanded: true,
              //   child: ActionButton(
              //     icon: PhosphorIcons.filePdf(),
              //     label: 'Open project PDF',
              //     onTap: () {
              //       context.showCustomDialog(
              //         child: PdfViewerPage(pdfData: MyAssets.pdf.resumeNew),
              //         title: 'Projects',
              //         scrollable: false,
              //         maxWidth: 1100,
              //         maxHeightFactor: 0.94,
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        loading: () => const HomeLoadingWidget(),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }

  String _documentPdfPath(String label) {
    switch (label.toLowerCase()) {
      case 'resume':
        return MyAssets.pdf.resumeNew;
      case 'transcript':
        return MyAssets.pdf.a65011212240D05Thai;
      default:
        return MyAssets.pdf.certSecondRound;
    }
  }
}

class textDetail extends StatelessWidget {
  final String title;
  final String description;

  const textDetail({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.appTexts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: theme.appColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(8),
            Text(title, style: text.bodyMediumBold),
          ],
        ),
        Text(
          description,
          style: text.bodyMediumRegular,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(8),
      ],
    );
  }
}
