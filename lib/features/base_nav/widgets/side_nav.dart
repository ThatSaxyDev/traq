// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_notifier/simple_notifier.dart';

import 'package:traq/features/base_nav/views/base_nav_view.dart';
import 'package:traq/features/base_nav/widgets/base_nav_view.desktopcontroller.dart';
import 'package:traq/features/dashboard/views/dashboard_desktop_view.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/features/projects/views/project_dektop_view.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/features/reports/views/reports_desktop_view.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/shared/app_routes.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/nav.dart';
import 'package:traq/utils/utils.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/myicon.dart';

class SideNav extends ConsumerStatefulWidget {
  const SideNav({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideNavState();
}

class _SideNavState extends ConsumerState<SideNav> {
  ValueNotifier<bool> openProjects = false.notifier;
  ValueNotifier<bool> openOrganisations = false.notifier;

  @override
  Widget build(BuildContext context) {
    OrganisationModel? orgFromProvider =
        ref.watch(orgModelStateControllerProvider);
    int indexFromDesktopController =
        ref.watch(baseNavDesktopControllerProvider);
    ProjectStuff? projectPageFromController =
        ref.watch(projectNavControllerProvider);

    AsyncValue<List<OrganisationModel>> asyncListofCreatedOrganisations =
        ref.watch(getUserCreatedOrgsProvider);

    return orgFromProvider == null
        ? const SizedBox.shrink()
        : Expanded(
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
                    asyncListofCreatedOrganisations.when(
                      data: (data) {
                        return Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  orgFromProvider.name.txt(
                                    size: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Pallete.blueColor,
                                  ),
                                  10.wSpace,
                                  TransparentButton(
                                    height: 40,
                                    width: 40,
                                    onTap: () {
                                      openOrganisations.value =
                                          !openOrganisations.value;
                                    },
                                    isText: false,
                                    item: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                  ),
                                ],
                              ),
                            ),

                            //! list of orgs
                            openOrganisations.listen(
                              builder: (context, value, child) =>
                                  AnimatedContainer(
                                duration: 200.ms,
                                height: switch (value) {
                                  true => ((50 * data.length) + 65).toDouble(),
                                  _ => 0,
                                },
                                width: double.maxFinite,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    15.hSpace,
                                    ...List.generate(
                                      data.length,
                                      (index) => SizedBox(
                                        height: 36,
                                        child: Row(
                                          children: [
                                            36.wSpace,
                                            const MyIcon(
                                              height: 20,
                                              icon: 'dashboard',
                                              color: Pallete.blueColor,
                                            ),
                                            12.wSpace,
                                            data[index].name.txt14(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            12.wSpace,
                                            isLessThanThreeDaysAgo(
                                                    data[index].createdAt!)
                                                ? Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 3,
                                                        horizontal: 7),
                                                    decoration: BoxDecoration(
                                                      color: Pallete.blueColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: 'new'.txt(
                                                        size: 10,
                                                        color: Colors.white),
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ).tap(onTap: () {
                                        openOrganisations.value = false;
                                        ref
                                            .read(
                                                orgModelStateControllerProvider
                                                    .notifier)
                                            .fixAnOrgInState(
                                                organisation: data[index]);
                                      }),
                                    ),
                                    15.hSpace,

                                    //! create org
                                    TransparentButton(
                                      height: 40,
                                      width: 100,
                                      onTap: () {
                                        goTo(
                                            context: context,
                                            route: AppRoutes.createOrg);
                                      },
                                      isText: false,
                                      item: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          'Create'.txt14(
                                            fontWeight: FontWeight.w500,
                                            color: Pallete.blueColor,
                                          ),
                                          8.wSpace,
                                          const MyIcon(
                                            icon: 'plus',
                                            height: 16,
                                            color: Pallete.blueColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      error: (error, stackTrace) {
                        error.toString().log();
                        return const SizedBox.shrink();
                      },
                      loading: () {
                        return const SizedBox.shrink();
                      },
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
                      openOrganisations.value = false;
                      remooveProjectPage(context: context, ref: ref);
                      moveToPage(context: context, ref: ref, index: 0);
                      ref
                          .read(versionNavControllerProvider.notifier)
                          .resetVersionPage();
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
                      openOrganisations.value = false;
                      openProjects.value = !openProjects.value;
                    }),

                    //! list of project folders
                    openProjects.listen(
                      builder: (context, value, child) => ref
                          .watch(getProjectsForAnOrganisationProvider(
                              orgFromProvider.name))
                          .when(
                        data: (projects) {
                          return AnimatedContainer(
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
                                      color: switch (
                                          projectPageFromController != null &&
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
                                              projectPageFromController !=
                                                      null &&
                                                  projectPageFromController
                                                          .title ==
                                                      projects[index]) {
                                            true => Pallete.whiteColor,
                                            false => null,
                                          },
                                        ),
                                        12.wSpace,
                                        projects[index].name.txt14(
                                              fontWeight: FontWeight.w500,
                                              color: switch (
                                                  projectPageFromController !=
                                                          null &&
                                                      projectPageFromController
                                                              .title ==
                                                          projects[index]) {
                                                true => Pallete.whiteColor,
                                                false => null,
                                              },
                                            ),
                                      ],
                                    ),
                                  ).tap(onTap: () {
                                    openOrganisations.value = false;
                                    moveToProjectPage(
                                        context: context,
                                        ref: ref,
                                        view: ProjectStuff(
                                          view: ProjectDesktopView(
                                            project: projects[index],
                                          ),
                                          title: projects[index],
                                        ));

                                    //! move index of base nav away
                                    moveToPage(
                                        context: context, ref: ref, index: 1);

                                    //! reset version page
                                    ref
                                        .read(versionNavControllerProvider
                                            .notifier)
                                        .resetVersionPage();
                                  }),
                                ),
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          error.toString().log();
                          return const SizedBox.shrink();
                        },
                        loading: () {
                          return const SizedBox.shrink();
                        },
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
                      openOrganisations.value = false;
                      remooveProjectPage(context: context, ref: ref);
                      moveToPage(context: context, ref: ref, index: 2);
                      ref
                          .read(versionNavControllerProvider.notifier)
                          .resetVersionPage();
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
                      openOrganisations.value = false;
                      remooveProjectPage(context: context, ref: ref);
                      moveToPage(context: context, ref: ref, index: 3);
                      ref
                          .read(versionNavControllerProvider.notifier)
                          .jumpToPage(page: 0);
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
