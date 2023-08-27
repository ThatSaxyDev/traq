import 'package:flextras/flextras.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/nav.dart';
import 'package:traq/utils/widgets/myicon.dart';

class ProjectMobileView extends ConsumerWidget {
  const ProjectMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? user = ref.watch(userProvider);
    OrganisationModel? orgFromProvider =
        ref.watch(orgModelStateControllerProvider);

    return ref
        .watch(getProjectsForAnOrganisationProvider(orgFromProvider!.name))
        .when(
      data: (List<ProjectModel> projects) {
        if (projects.isEmpty) {
          return SizedBox(
            height: height(context),
            width: width(context),
            child: Column(
              children: [
                Container(
                  height: 112.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(width: 0.50, color: Color(0xFFE5E7EB)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w)
                      .copyWith(bottom: 16.h),
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
                          'Projects (${projects.length})'.txt(
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
                          CircleAvatar(
                            radius: 20.h,
                            backgroundImage: NetworkImage(user!.profilePic!),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //! projects list
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      24.sbH,
                      ...List.generate(
                        projects.length,
                        (index) => Container(
                          width: 335.w,
                          height: 84.h,
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 16.h),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFF2F4F7)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24.w,
                                backgroundColor: const Color(0xFF6F4DCD),
                                child: projects[index].name.substring(0, 1).txt(
                                      size: 24.sp,
                                      color: Pallete.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              16.sbW,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  projects[index].name.txt(
                                        size: 16.sp,
                                        isheader: true,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  SizedBox(
                                    height: 24,
                                    width: 70,
                                    child: Stack(
                                      children: List.generate(
                                        2,
                                        (index) => Positioned(
                                          left: switch (index) {
                                            0 => 0,
                                            _ => (19 * index).toDouble(),
                                          },
                                          child: const CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Pallete.whiteColor,
                                            child: CircleAvatar(
                                              radius: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              MyIcon(
                                height: 24.h,
                                icon: 'arrowright',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ).tap(onTap: () {
                          goTo(
                              context: context,
                              route: '/project/${projects[index].name}');
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
      loading: () {
        return const Loadinggg(height: 40);
      },
    );
  }
}
