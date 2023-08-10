// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/myicon.dart';

class ProjectCard extends ConsumerWidget {
  final String projectTitle;
  const ProjectCard({
    super.key,
    required this.projectTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 380,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: const Color(0xFFF2F4F7),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFF6F4DCD),
                child: projectTitle.substring(0, 1).txt(
                      size: 22,
                      color: Pallete.whiteColor,
                    ),
              ),
              12.wSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '$projectTitle v1.0'.toTitleCase().txt16(
                        isheader: true,
                        fontWeight: FontWeight.w600,
                      ),
                  'Release Date: 2023 - 08 - 08'.txt14(
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              const Spacer(),
              const MyIcon(icon: 'arrowright'),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              //! open bugs
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEF2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: 'Open Bugs'.txt(
                  size: 10,
                  color: const Color(0xFFEF4444),
                ),
              ),
              8.wSpace,

              //! resolved bugs
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF0FDF4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: 'Resolved Bugs'.txt(
                  size: 10,
                  color: const Color(0xFF22C55E),
                ),
              ),
              8.wSpace,

              //! closed bugs
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF9FCFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: 'Closed Bugs'.txt(
                  size: 10,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
