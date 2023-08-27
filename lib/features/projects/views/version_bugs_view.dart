// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/features/reports/controllers/reports_controller.dart';
import 'package:traq/features/reports/widgets/bug_report_bottom_sheet.dart';
import 'package:traq/models/version_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/bug_card.dart';

class VersionBugsView extends ConsumerWidget {
  final String projectName;
  final String versionName;
  const VersionBugsView({
    super.key,
    required this.projectName,
    required this.versionName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<VersionModel> versionStream =
        ref.watch(getVersionByIdProvider(Uri.decodeComponent(versionName)));
    return versionStream.when(
      data: (VersionModel version) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Pallete.whiteColor,

            //! report bug buttton
            floatingActionButton: Container(
              width: 110.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F4FF),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(width: 0.50, color: const Color(0xFFB59BFF)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x28000000),
                    blurRadius: 24,
                    offset: Offset(0, 6),
                    spreadRadius: 6,
                  )
                ],
              ),
              child: Center(
                child: 'Report bug'.txt(
                  size: 14.sp,
                  color: const Color(0xFF4A21C1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).withHapticFeedback(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => Wrap(
                    children: [
                      ReportBugBottomSheet(
                        version: version,
                      ),
                    ],
                  ),
                );
              },
              feedbackType: AppHapticFeedbackType.mediumImpact,
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child: AppBar(
                elevation: 0,
                backgroundColor: Pallete.whiteColor,
                centerTitle: false,
                title: Uri.decodeComponent(versionName).txt(
                  isheader: true,
                  size: 24.sp,
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(90.h),
                  child: Container(
                    width: double.infinity,
                    height: 90.h,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CenterLeft(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: 'BUGS ASSIGNED'.txt(
                              size: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        10.sbH,
                        Container(
                          height: 35.h,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                          ),
                          child: TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                width: 1.5,
                                color: Color(0xFF4A21C1),
                              )),
                            ),
                            labelColor: Pallete.blackColor,
                            unselectedLabelColor: Pallete.blackColor,
                            labelStyle: TextStyle(
                              color: const Color(0xFF111827),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: TextStyle(
                              color: const Color(0xFF111827),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            tabs: [
                              Tab(
                                text:
                                    'UNSOLVED BUGS (${version.unsolvedBugs.length})',
                              ),
                              Tab(
                                text:
                                    'IN PROGRESS (${version.inProgressBugs.length})',
                              ),
                              Tab(
                                text:
                                    'IN REVIEW (${version.inReviewBugs.length})',
                              ),
                              Tab(
                                text:
                                    'RESOLVED (${version.resolvedBugs.length})',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SizedBox(
              height: height(context),
              width: width(context),
              child: TabBarView(
                children: [
                  //! UNSOLVED
                  SingleChildScrollView(
                    child: Column(
                        children: switch (version.unsolvedBugs.length) {
                      0 => [200.sbH, 'No bugs found'.txt(size: 18.sp)],
                      _ => List.generate(
                          version.unsolvedBugs.length,
                          (index) {
                            List<dynamic> bugsRev =
                                version.unsolvedBugs.reversed.toList();
                            return BugCardMobile(
                              projectName: projectName,
                              versionId: versionName,
                              index: index,
                              bugId: bugsRev[index],
                            );
                          },
                        ),
                    }),
                  ),

                  //! IN PROGRESS

                  SingleChildScrollView(
                    child: Column(
                      children: switch (version.inProgressBugs.length) {
                        0 => [
                            200.sbH,
                            'No bugs being solved right now'.txt(size: 18.sp)
                          ],
                        _ => List.generate(
                            version.inProgressBugs.length,
                            (index) {
                              List<dynamic> bugsRev =
                                  version.inProgressBugs.reversed.toList();
                              return BugCardMobile(
                                projectName: projectName,
                                versionId: versionName,
                                index: index,
                                bugId: bugsRev[index],
                              );
                            },
                          ),
                      },
                    ),
                  ),

                  //! IN REVIEW
                  SingleChildScrollView(
                    child: Column(
                      children: switch (version.inReviewBugs.length) {
                        0 => [
                            200.sbH,
                            'No bug solution being reviewd right now'
                                .txt(size: 18.sp)
                          ],
                        _ => List.generate(
                            version.inReviewBugs.length,
                            (index) {
                              List<dynamic> bugsRev =
                                  version.inReviewBugs.reversed.toList();
                              return BugCardMobile(
                                projectName: projectName,
                                versionId: versionName,
                                index: index,
                                bugId: bugsRev[index],
                              );
                            },
                          ),
                      },
                    ),
                  ),

                  //! RESOLVED
                  SingleChildScrollView(
                    child: Column(
                      children: switch (version.resolvedBugs.length) {
                        0 => [
                            200.sbH,
                            'You have not resolved any bugs'.txt(size: 18.sp)
                          ],
                        _ => List.generate(
                            version.resolvedBugs.length,
                            (index) {
                              List<dynamic> bugsRev =
                                  version.resolvedBugs.reversed.toList();
                              return BugCardMobile(
                                projectName: projectName,
                                versionId: versionName,
                                index: index,
                                bugId: bugsRev[index],
                              );
                            },
                          ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        error.log();
        return Scaffold(
          body: Center(
            child: 'An error occured'.txt(size: 20.sp),
          ),
        );
      },
      loading: () {
        return Loadinggg(height: 40.h);
      },
    );
  }
}
