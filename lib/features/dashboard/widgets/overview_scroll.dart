// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traq/features/reports/controllers/reports_controller.dart';
import 'package:traq/models/bug_model.dart';

import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/myicon.dart';

class OverViewScroll extends ConsumerWidget {
  const OverViewScroll({
    Key? key,
    required this.orgFromProvider,
    this.projects,
  }) : super(key: key);

  final OrganisationModel? orgFromProvider;
  final List<ProjectModel>? projects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        20.sbW,
        //! active projects card
        Container(
          width: 138.w,
          height: 150.h,
          padding: EdgeInsets.all(16.w),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFF2F4F7),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.w,
                backgroundColor: const Color(0xFFFFFBEB),
                child: const MyIcon(icon: 'active'),
              ),
              16.sbH,
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'Active Projects'.txt(size: 14.sp),
                  4.sbH,
                  (switch (projects == null) {
                    true => orgFromProvider!.projects.length.toString(),
                    false => projects!.length.toString(),
                  })
                      .txt(
                    size: 24.sp,
                    isheader: true,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
        32.wSpace,

        //! active bugs card
        Container(
          width: 138.w,
          height: 150.h,
          padding: EdgeInsets.all(16.w),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFF2F4F7),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.w,
                backgroundColor: const Color(0xFFF7F4FF),
                child: const MyIcon(icon: 'hourglass'),
              ),
              16.sbH,
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'Open Bugs'.txt(size: 14.sp),
                  4.sbH,
                  ref
                      .watch(
                          getAllUnsolvedBugsForAnOrganisationProvider('solved'))
                      .when(
                        data: (List<BugModel> bugs) {
                          return bugs.length.toString().txt(
                                size: 24.sp,
                                isheader: true,
                                fontWeight: FontWeight.w600,
                              );
                        },
                        error: (error, stackTrace) {
                          error.toString().log();
                          return '0'.txt(
                            size: 24.sp,
                            isheader: true,
                            fontWeight: FontWeight.w600,
                          );
                        },
                        loading: () => '0'.txt(
                          size: 24.sp,
                          isheader: true,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
        32.wSpace,

        //! resolved bugs card
        Container(
          width: 138.w,
          height: 150.h,
          padding: EdgeInsets.all(16.w),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFF2F4F7),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.w,
                backgroundColor: const Color(0xFFF0FDF4),
                child: const MyIcon(icon: 'resolved'),
              ),
              16.sbH,
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'Resolved Bugs'.txt(size: 14.sp),
                  4.sbH,
                  ref.watch(getAllBugsForAnOrganisationProvider('solved')).when(
                        data: (List<BugModel> bugs) {
                          return bugs.length.toString().txt(
                                size: 24.sp,
                                isheader: true,
                                fontWeight: FontWeight.w600,
                              );
                        },
                        error: (error, stackTrace) {
                          error.toString().log();
                          return '0'.txt(
                            size: 24.sp,
                            isheader: true,
                            fontWeight: FontWeight.w600,
                          );
                        },
                        loading: () => '0'.txt(
                          size: 24.sp,
                          isheader: true,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
        32.wSpace,
      ],
    );
  }
}
