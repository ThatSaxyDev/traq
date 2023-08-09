import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:traq/features/base_nav/views/base_nav_view.dart';
import 'package:traq/features/base_nav/widgets/base_nav_view.desktopcontroller.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/myicon.dart';

class SideNav extends ConsumerWidget {
  const SideNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromDesktopController =
        ref.watch(baseNavDesktopControllerProvider);
    return Expanded(
      flex: 1,
      child: Container(
        height: height(context),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(width: 0.50, color: Color(0xFFE5E7EB)),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              16.hSpace,
              'Traq'.txt(size: 32),
              60.hSpace,
              //! dashboard
              Container(
                height: 64,
                width: 207,
                color: switch (indexFromDesktopController) {
                  0 => Pallete.blueColor,
                  _ => Colors.transparent,
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              ).tap(onTap: () {
                moveToPage(context: context, ref: ref, index: 0);
              }),

              //! projects
              Container(
                height: 64,
                width: 207,
                color: switch (indexFromDesktopController) {
                  1 => Pallete.blueColor,
                  _ => Colors.transparent,
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyIcon(
                        icon: 'projects',
                        color: switch (indexFromDesktopController) {
                          1 => Pallete.whiteColor,
                          _ => null,
                        },
                      ),
                      12.wSpace,
                      'Projects'.txt(
                        size: 16,
                        color: switch (indexFromDesktopController) {
                          1 => Pallete.whiteColor,
                          _ => null,
                        },
                      ),
                    ],
                  ),
                ),
              ).tap(onTap: () {
                moveToPage(context: context, ref: ref, index: 1);
              }),

              //! reports
              Container(
                height: 64,
                width: 207,
                color: switch (indexFromDesktopController) {
                  2 => Pallete.blueColor,
                  _ => Colors.transparent,
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              ).tap(onTap: () {
                moveToPage(context: context, ref: ref, index: 2);
              }),

              //! settings
              Container(
                height: 64,
                width: 207,
                color: switch (indexFromDesktopController) {
                  3 => Pallete.blueColor,
                  _ => Colors.transparent,
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              ).tap(onTap: () {
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
