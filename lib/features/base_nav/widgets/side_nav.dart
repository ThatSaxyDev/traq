import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:simple_notifier/simple_notifier.dart';
import 'package:traq/features/base_nav/views/base_nav_view.dart';
import 'package:traq/features/base_nav/widgets/base_nav_view.desktopcontroller.dart';
import 'package:traq/features/dashboard/views/dashboard_desktop_view.dart';
import 'package:traq/features/projects/views/project_dektop_view.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/features/reports/views/reports_desktop_view.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/myicon.dart';

class SideNav extends ConsumerStatefulWidget {
  const SideNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideNavState();
}

class _SideNavState extends ConsumerState<SideNav> {
  ValueNotifier<bool> openProjects = false.notifier;

  @override
  Widget build(BuildContext context) {
    int indexFromDesktopController =
        ref.watch(baseNavDesktopControllerProvider);
    ProjectStuff? projectPageFromController =
        ref.watch(projectNavControllerProvider);

    return Expanded(
      flex: 1,
      child: Container(
        height: height(context),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(
                width: 0.50,
                color: Color(0xFFE5E7EB),
              ),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              16.hSpace,
              'Traq'.txt(
                size: 32,
                fontWeight: FontWeight.w700,
                color: Pallete.blueColor,
              ),
              60.hSpace,
              //! dashboard
              Container(
                height: 64,
                width: double.maxFinite,
                color: switch (indexFromDesktopController) {
                  0 => Pallete.blueColor,
                  _ => Colors.transparent,
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      children: [
                        40.wSpace,
                        MyIcon(
                          icon: 'undashboard',
                          color: switch (indexFromDesktopController) {
                            0 => Pallete.whiteColor,
                            _ => null,
                          },
                        ),
                        12.wSpace,
                        'Dashboard'.txt(
                          size: 16,
                          color: switch (indexFromDesktopController) {
                            0 => Pallete.whiteColor,
                            _ => null,
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ).tap(onTap: () {
                remooveProjectPage(context: context, ref: ref);
                moveToPage(context: context, ref: ref, index: 0);
              }),

              //! projects
              Container(
                height: 64,
                width: double.maxFinite,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      children: [
                        40.wSpace,
                        const MyIcon(
                          icon: 'projects',
                          // color: switch (indexFromDesktopController) {
                          //   1 => Pallete.whiteColor,
                          //   _ => null,
                          // },
                        ),
                        12.wSpace,
                        'Projects'.txt(
                          size: 16,
                          // color: switch (indexFromDesktopController) {
                          //   1 => Pallete.whiteColor,
                          //   _ => null,
                          // },
                        ),
                      ],
                    ),
                  ),
                ),
              ).tap(onTap: () {
                openProjects.value = !openProjects.value;
              }),

              //! list of project folders
              openProjects.listen(
                builder: (context, value, child) => AnimatedContainer(
                  duration: 200.ms,
                  height: switch (value) {
                    true => (40 * projects.length).toDouble(),
                    _ => 0,
                  },
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        projects.length,
                        (index) => Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 40),
                          decoration: BoxDecoration(
                            color: switch (projectPageFromController != null &&
                                projectPageFromController.title ==
                                    projects[index]) {
                              true => Pallete.blueColor,
                              false => null,
                            },
                            border: const Border(
                              left: BorderSide(
                                width: 0.50,
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              36.wSpace,
                              MyIcon(
                                height: 20,
                                icon: 'folder',
                                color: switch (
                                    projectPageFromController != null &&
                                        projectPageFromController.title ==
                                            projects[index]) {
                                  true => Pallete.whiteColor,
                                  false => null,
                                },
                              ),
                              12.wSpace,
                              projects[index].txt14(
                                fontWeight: FontWeight.w500,
                                color: switch (
                                    projectPageFromController != null &&
                                        projectPageFromController.title ==
                                            projects[index]) {
                                  true => Pallete.whiteColor,
                                  false => null,
                                },
                              ),
                            ],
                          ),
                        ).tap(onTap: () {
                          moveToProjectPage(
                              context: context,
                              ref: ref,
                              view: ProjectStuff(
                                view: ProjectDesktopView(
                                  projectTitle: projects[index],
                                ),
                                title: projects[index],
                              ));

                          //! move index of base nav away
                          moveToPage(context: context, ref: ref, index: 1);
                        }),
                      ),
                    ),
                  ),
                ),
              ),

              //! reports
              Container(
                height: 64,
                width: double.maxFinite,
                color: switch (indexFromDesktopController) {
                  2 => Pallete.blueColor,
                  _ => Colors.transparent,
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      children: [
                        40.wSpace,
                        MyIcon(
                          icon: 'reports',
                          color: switch (indexFromDesktopController) {
                            2 => Pallete.whiteColor,
                            _ => null,
                          },
                        ),
                        12.wSpace,
                        'Reports'.txt(
                          size: 16,
                          color: switch (indexFromDesktopController) {
                            2 => Pallete.whiteColor,
                            _ => null,
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ).tap(onTap: () {
                remooveProjectPage(context: context, ref: ref);
                moveToPage(context: context, ref: ref, index: 2);
              }),

              //! settings
              Container(
                height: 64,
                width: double.maxFinite,
                color: switch (indexFromDesktopController) {
                  3 => Pallete.blueColor,
                  _ => Colors.transparent,
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      children: [
                        40.wSpace,
                        MyIcon(
                          icon: 'settings',
                          color: switch (indexFromDesktopController) {
                            3 => Pallete.whiteColor,
                            _ => null,
                          },
                        ),
                        12.wSpace,
                        'Settings'.txt(
                          size: 16,
                          color: switch (indexFromDesktopController) {
                            3 => Pallete.whiteColor,
                            _ => null,
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ).tap(onTap: () {
                remooveProjectPage(context: context, ref: ref);
                moveToPage(context: context, ref: ref, index: 3);
              }),
              40.hSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final String icon;

  DashboardItem(this.title, this.icon);
}

List<DashboardItem> dashBoardItems = [
  DashboardItem('Dashboard', 'dashboard'),
  DashboardItem('Projects', 'projects'),
  DashboardItem('Reports', 'reports'),
  DashboardItem('settings', 'dashboard'),
];

//! List of pages
List<Widget> deskTopPages = [
  const DashBoardDesktopView(),
  Center(
    child: 'zz'.txt(size: 12),
  ),
  const ReportsDesktopView(),
  Center(
    child: 'hq3f2ftgme'.txt(size: 12),
  ),
  Center(
    child: 'test'.txt(size: 12),
  ),
];

List<String> projects = [
  'Traq',
  'Quizly',
  'Retro',
  'Pop up',
  'Antena',
];
