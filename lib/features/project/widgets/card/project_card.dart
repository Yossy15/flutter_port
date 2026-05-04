import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:port/core/extensions/theme_data.dart';
import 'package:port/features/project/models/project_model.dart';
import 'package:port/features/_share_feature/widgets/action_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});

  final ProjectModel project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final color = Theme.of(context).appColors;

    return AnimatedScale(
      scale: pressed ? 0.97 : 1,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,

      child: GestureDetector(
        onTapDown: (_) => setState(() => pressed = true),
        onTapUp: (_) => setState(() => pressed = false),
        onTapCancel: () => setState(() => pressed = false),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            /// 💎 glass + depth
            color: Colors.white.withOpacity(0.85),
            border: Border.all(color: Colors.white.withOpacity(0.4)),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 30,
                offset: const Offset(0, 18),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🖼 HERO IMAGE (Dribbble style blend)
                Stack(
                  children: [
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Image.network(p.imageUrl, fit: BoxFit.cover),
                    ),

                    /// gradient overlay (premium blend)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.55),
                              Colors.transparent,
                              Colors.black.withOpacity(0.2),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),

                    /// title
                    Positioned(
                      left: 16,
                      bottom: 16,
                      right: 16,
                      child: Text(
                        p.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                /// 📄 CONTENT
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// description
                      Text(
                        p.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// 🏷 tech chips (premium pill)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: p.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: color.primaryPressed,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: color.primarySurface),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                fontSize: 12,
                                color: color.neutral.shade40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 18),

                      /// 🔗 ACTIONS (floating minimal style)
                      Row(
                        children: [
                          if (p.githubUrl != null)
                            ActionButton(
                              icon: PhosphorIcons.githubLogo(),
                              label: "GitHub",
                              onTap: () {
                                debugPrint("GitHub: ${p.githubUrl}");
                                if (p.githubUrl != null) return;
                                launchUrl(Uri.parse(p.githubUrl!));
                              },
                            ),

                          const SizedBox(width: 10),

                          if (p.liveUrl != null)
                            ActionButton(
                              icon: PhosphorIcons.globe(),
                              label: "Live",
                              onTap: () {
                                debugPrint("Live: ${p.liveUrl}");
                                if (p.liveUrl != null) return;
                                launchUrl(Uri.parse(p.liveUrl!));
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
