import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port/features/contact/widgets/loading/contact_loading.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContactLoading();
  }
}
