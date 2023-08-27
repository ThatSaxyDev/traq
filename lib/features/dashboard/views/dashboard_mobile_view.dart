import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/dashboard/widgets/overview_scroll.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/image_loader.dart';
import 'package:traq/utils/widgets/myicon.dart';

class DashboardMobileView extends ConsumerStatefulWidget {
  const DashboardMobileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardMobileViewState();
}

class _DashboardMobileViewState extends ConsumerState<DashboardMobileView> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(userProvider);
    OrganisationModel? orgFromProvider =
        ref.watch(orgModelStateControllerProvider);
    AsyncValue<List<ProjectModel>> projectsStream =
        ref.watch(getProjectsForAnOrganisationProvider(orgFromProvider!.name));
    return SizedBox(
      height: height(context),
      width: width(context),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 120.h,
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 16.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 0.50, color: Color(0xFFE5E7EB)),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //! header
                  Row(
                    children: [
                      'Hi, ${user!.nickName}'.txt(
                        isheader: true,
                        size: 24.sp,
                      ),
                      const Spacer(),
                      //! notifications
                      MyIcon(
                        icon: 'notif',
                        height: 24.h,
                      ),
                      16.sbW,

                      //! profile image
                      CircularImageLoader(
                        imageUrl: user.profilePic!,
                        dimension: 40.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //! overview
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  24.sbH,
                  //! overview
                  Row(
                    children: [
                      20.sbW,
                      'Overview'
                          .toUpperCase()
                          .txt(
                            size: 12.sp,
                            fontWeight: FontWeight.w500,
                          )
                          .alignCenterLeft(),
                    ],
                  ),
                  12.sbH,

                  //! active projects
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: projectsStream.when(
                      data: (List<ProjectModel> projects) => OverViewScroll(
                        orgFromProvider: orgFromProvider,
                        projects: projects,
                      ),
                      error: (error, stackTrace) =>
                          OverViewScroll(orgFromProvider: orgFromProvider),
                      loading: () =>
                          OverViewScroll(orgFromProvider: orgFromProvider),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
