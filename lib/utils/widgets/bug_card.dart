// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:traq/features/reports/controllers/reports_controller.dart';
import 'package:traq/features/reports/widgets/bug_details_bottom_sheet.dart';
import 'package:traq/models/bug_model.dart';

import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/myicon.dart';

class BugCard extends ConsumerWidget {
  const BugCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFF2F4F7),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //! priority tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEF2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: 'High Priority'.txt(
                  size: 10,
                  color: const Color(0xFFEF4444),
                ),
              ),

              // date
              'Mon, August 7'.txt12(
                color: const Color(0xFF9CA3AF),
              ),
            ],
          ),
          8.hSpace,

          //! title
          'Android app crashing on home screen Android app crashing on home screen Android app crashing on home screen'
              .txt14(
            fontWeight: FontWeight.w600,
            isheader: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          4.hSpace,

          //! description
          'Android app crashing on home screen Android app crashing on home screen Android app crashing on home screen'
              .txt14(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          16.hSpace,
          //! images row

          Row(
            children: [
              //! images
              SizedBox(
                height: 24,
                width: 40,
                child: Stack(
                  children: List.generate(
                    2,
                    (index) => Positioned(
                      left: switch (index) {
                        0 => 0,
                        _ => (15 * index).toDouble(),
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Pallete.whiteColor,
                        child: CircleAvatar(
                          radius: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),

              //! comment
              const MyIcon(icon: 'comment', height: 16),
              4.wSpace,
              '3'.txt12(),
              12.wSpace,

              //! attachment
              const MyIcon(icon: 'attachment', height: 16),
              4.wSpace,
              '3'.txt12(),
            ],
          ),
        ],
      ),
    );
  }
}

class BugCardMobile extends ConsumerWidget {
  final String projectName;
  final String versionId;
  final String bugId;
  final int index;
  const BugCardMobile({
    super.key,
    required this.projectName,
    required this.versionId,
    required this.index,
    required this.bugId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<BugModel> bugStream = ref.watch(getBugByIdProvider(bugId));
    return bugStream.when(
      data: (BugModel bug) {
        return Container(
          width: 335.h,
          margin: EdgeInsets.only(
              bottom: 16.h,
              top: switch (index) {
                0 => 16.h,
                _ => 0,
              }),
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFF2F4F7),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! priority tag
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: ShapeDecoration(
                      color: switch (bug.priority) {
                        'Critical' => Pallete.critical,
                        'High' => Pallete.high,
                        'Medium' => Pallete.medium,
                        _ => Pallete.low,
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: bug.priority.txt(
                      size: 12.sp,
                      color: switch (bug.priority) {
                        'Critical' => Pallete.criticalDarker,
                        'High' => Pallete.highDarker,
                        'Medium' => Pallete.mediumDarker,
                        _ => Pallete.lowDarker,
                      },
                    ),
                  ),

                  // date
                  DateFormat.MMMEd().format(bug.createdAt!).txt(
                        size: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                ],
              ),
              8.sbH,

              //! title
              bug.bugName
                  .txt(
                    textAlign: TextAlign.start,
                    size: 14.sp,
                    fontWeight: FontWeight.w600,
                    isheader: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                  .alignCenterLeft(),
              8.sbH,

              //! description
              bug.description
                  .txt(
                    size: 14.sp,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                  .alignCenterLeft(),

              16.sbH,
              //! images row

              Row(
                children: [
                  //! images
                  SizedBox(
                    height: 24.h,
                    width: 70.w,
                    child: Stack(
                      children: List.generate(
                        2,
                        (index) => Positioned(
                          left: switch (index) {
                            0 => 0,
                            _ => (19.w * index).toDouble(),
                          },
                          child: CircleAvatar(
                            radius: 12.w,
                            backgroundColor: Pallete.whiteColor,
                            child: CircleAvatar(
                              radius: 11.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),

                  //! comment
                  MyIcon(icon: 'comment', height: 16.h),
                  4.wSpace,
                  bug.comments.length.toString().txt(size: 12.sp),
                  12.wSpace,

                  //! attachment
                  MyIcon(icon: 'attachment', height: 16.h),
                  4.wSpace,
                  (switch (bug.imageUrl.isEmpty) { true => '0', false => '1' })
                      .txt(size: 12.sp),
                ],
              ),
            ],
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
                  BugDetailsBottomSheet(
                    bugg: bug,
                  ),
                ],
              ),
            );
          },
          feedbackType: AppHapticFeedbackType.lightImpact,
        );
      },
      error: (error, stackTrace) {
        error.toString().log();
        return const SizedBox.shrink();
      },
      loading: () {
        return const SizedBox.shrink();
      },
    );
  }
}
