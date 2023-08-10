// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/features/projects/widgets/project_card.dart';
import 'package:traq/theme/palette.dart';

import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/myicon.dart';

class ProjectDesktopView extends ConsumerStatefulWidget {
  final String projectTitle;
  const ProjectDesktopView({
    super.key,
    required this.projectTitle,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjectDesktopViewState();
}

class _ProjectDesktopViewState extends ConsumerState<ProjectDesktopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ).copyWith(top: 40),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! dashboard
              Container(
                padding: const EdgeInsets.only(bottom: 40),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.50,
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF6F4DCD),
                      child: widget.projectTitle
                          .substring(0, 1)
                          .txt24(color: Pallete.whiteColor),
                    ),
                    30.wSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.projectTitle.toTitleCase().txt(
                              isheader: true,
                              size: 32,
                              fontWeight: FontWeight.w600,
                            ),
                        'Created on August 7, 2023'.txt14(
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      width: 70,
                      child: Stack(
                        children: List.generate(
                          2,
                          (index) => Positioned(
                            left: switch (index) {
                              0 => 0,
                              _ => (29 * index).toDouble(),
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Pallete.whiteColor,
                              child: CircleAvatar(
                                radius: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    24.wSpace,
                    TransparentButton(
                      height: 40,
                      width: 178,
                      onTap: () {},
                      isText: false,
                      item: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          'Add Member'.txt14(
                              fontWeight: FontWeight.w500, isheader: true),
                          8.wSpace,
                          const MyIcon(
                            icon: 'pluss',
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              40.hSpace,

              //! VERSIONS LIST
              'VERSIONS LIST'
                  .txt14(fontWeight: FontWeight.w500)
                  .alignCenterLeft(),
              24.hSpace,

              //! project version cards
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: List.generate(
                  20,
                  (index) => ProjectCard(
                    projectTitle: widget.projectTitle,
                  ),
                ),
              ),
              32.hSpace,

              //! add new version
              TransparentButton(
                height: 52,
                width: 168,
                onTap: () {},
                isText: false,
                item: 'Add New Version'
                    .txt14(fontWeight: FontWeight.w500, isheader: true),
              ).alignCenter(),
              70.hSpace,
            ],
          ),
        ),
      ),
    );
  }
}
