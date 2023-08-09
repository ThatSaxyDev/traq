// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/bug_card.dart';
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
              widget.projectTitle.toTitleCase().txt(
                isheader: true,
                size: 32,
                fontWeight: FontWeight.w600,
              ),
              4.hSpace,

              //! overview
              'Created on August 7, 2023'.toUpperCase().txt14(
                    fontWeight: FontWeight.w500,
                  ),

              40.hSpace,

              //! bugs assigned
              'BUGS ASSIGNED'
                  .txt14(fontWeight: FontWeight.w500)
                  .alignCenterLeft(),
              16.hSpace,

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //! unsolved bugs
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFF4A21C1),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! unsolved
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'UNSOLVED (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.wSpace,

                    //! in progress
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFFF59E0B),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! in progress
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'IN PROGRESS (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.wSpace,

                    //! in review
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFFEF4444),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! in progress
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'IN REVIEW (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    32.wSpace,

                    //! resolved
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! resolved
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'RESOLVED (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
