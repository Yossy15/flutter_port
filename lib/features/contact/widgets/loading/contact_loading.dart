import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:port/core/widgets/shimmer/shimmer.dart';
import 'package:port/features/_share_feature/widgets/expandable_card.dart';
import 'package:port/features/home/enum/social.dart';

class ContactLoading extends StatelessWidget {
  const ContactLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppShimmer.circle(diameter: 100),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmer(width: 150, height: 24),
                    const Gap(4),
                    AppShimmer(width: 200, height: 18),
                    const Gap(12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Social.values.map((social) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: AppShimmer(width: 80, height: 36, borderRadius: 8),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(width: 200, height: 200, borderRadius: 8),
                  const Gap(12),
                  Expanded(
                    child: AppShimmer(width: double.infinity, height: 200),
                  ),
                ],
              ),
              const Gap(12),
              AppShimmer(width: double.infinity, height: MediaQuery.of(context).size.height),
            ],
          ),
          
        ],
      ),
    );
  }
}