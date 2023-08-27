// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/features/projects/widgets/project_card.dart';
import 'package:traq/features/reports/controllers/reports_controller.dart';
import 'package:traq/models/bug_model.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/theme/palette.dart';

import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/myicon.dart';

import '../../../utils/widgets/bug_card.dart';

class ProjectDesktopView extends ConsumerStatefulWidget {
  final ProjectModel projectModel;
  const ProjectDesktopView({
    super.key,
    required this.projectModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjectDesktopViewState();
}

class _ProjectDesktopViewState extends ConsumerState<ProjectDesktopView> {
  @override
  Widget build(BuildContext context) {
    PageController controllerFromProvider =
        ref.watch(versionNavControllerProvider);
    AsyncValue<ProjectModel> projectt =
        ref.watch(getProjectByNameProvider(widget.projectModel.name));
    OrganisationModel? orgFromProvider =
        ref.watch(orgModelStateControllerProvider);
    AsyncValue<List<BugModel>> bugsStream =
        ref.watch(getAllBugsForAVersionProvider);
    return projectt.when(
      data: (ProjectModel project) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ).copyWith(top: 40),
          child: SizedBox(
            width: double.infinity,
            child: PageView(
              pageSnapping: true,
              physics: const NeverScrollableScrollPhysics(),
              controller: controllerFromProvider,
              children: [
                //! project over view
                SingleChildScrollView(
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
                              child: project.name
                                  .substring(0, 1)
                                  .txt24(color: Pallete.whiteColor),
                            ),
                            30.wSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                project.name.toTitleCase().txt(
                                      isheader: true,
                                      size: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                'Creeated on ${DateFormat.yMMMMd().format(project.createdAt!)}'
                                    .txt14(
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
                                      fontWeight: FontWeight.w500,
                                      isheader: true),
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
                          project.versions.length,
                          (index) => ProjectVersionCard(
                            index: index,
                            versionId: project.versions[index],
                          ).tap(onTap: () {
                            setState(() {});
                          }),
                        ),
                      ),
                      32.hSpace,

                      //! add new version
                      TransparentButton(
                        height: 52,
                        width: 168,
                        onTap: () {
                          ref
                              .read(projectControllerProvider.notifier)
                              .createVersion(
                                  organisation: orgFromProvider!,
                                  project: project,
                                  name:
                                      '${project.name} -v${(project.versions.length + 10) / 10}',
                                  context: context);
                        },
                        isText: false,
                        item: 'Add New Version'
                            .txt14(fontWeight: FontWeight.w500, isheader: true),
                      ).alignCenter(),
                      70.hSpace,
                    ],
                  ),
                ),

                //! VERSION DETAILS // VERSION DETAILS
                //! VERSION DETAILS // VERSION DETAILS
                //! VERSION DETAILS // VERSION DETAILS
                //! VERSION DETAILS // VERSION DETAILS
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Pallete.blackColor,
                              ),
                            ).tap(onTap: () {
                              ref
                                  .read(versionNavControllerProvider.notifier)
                                  .jumpToPage(page: 0);
                            }),
                            30.wSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                '${project.name} v1.0'.toTitleCase().txt(
                                      isheader: true,
                                      size: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                'Release Date: 2023 - 08 - 08'.txt14(
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            const Spacer(),
                            // SizedBox(
                            //   height: 40,
                            //   width: 70,
                            //   child: Stack(
                            //     children: List.generate(
                            //       2,
                            //       (index) => Positioned(
                            //         left: switch (index) {
                            //           0 => 0,
                            //           _ => (29 * index).toDouble(),
                            //         },
                            //         child: const CircleAvatar(
                            //           radius: 20,
                            //           backgroundColor: Pallete.whiteColor,
                            //           child: CircleAvatar(
                            //             radius: 18,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            24.wSpace,

                            //! ADD NEW VERSION TO PROJECT
                            TransparentButton(
                              height: 40,
                              width: 178,
                              onTap: () {
                                toggleOverlayBug(context: context, ref: ref);
                              },
                              isText: false,
                              item: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  'Report bug'.txt14(
                                      fontWeight: FontWeight.w500,
                                      isheader: true),
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

                      //! bugs assigned
                      'BUGS ASSIGNED'
                          .txt14(fontWeight: FontWeight.w500)
                          .alignCenterLeft(),
                      16.hSpace,

                      bugsStream.when(
                        data: (List<BugModel> bugs) {
                          return SingleChildScrollView(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            'UNSOLVED (2)'.txt14(
                                                fontWeight: FontWeight.w600),
                                            const MyIcon(icon: 'morehoriz'),
                                          ],
                                        ),
                                      ),

                                      16.hSpace,
                                      SizedBox(
                                        height: 700,
                                        child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            'IN PROGRESS (2)'.txt14(
                                                fontWeight: FontWeight.w600),
                                            const MyIcon(icon: 'morehoriz'),
                                          ],
                                        ),
                                      ),

                                      16.hSpace,
                                      SizedBox(
                                        height: 700,
                                        child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            'IN REVIEW (2)'.txt14(
                                                fontWeight: FontWeight.w600),
                                            const MyIcon(icon: 'morehoriz'),
                                          ],
                                        ),
                                      ),

                                      16.hSpace,
                                      SizedBox(
                                        height: 700,
                                        child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            'RESOLVED (2)'.txt14(
                                                fontWeight: FontWeight.w600),
                                            const MyIcon(icon: 'morehoriz'),
                                          ],
                                        ),
                                      ),

                                      16.hSpace,
                                      SizedBox(
                                        height: 700,
                                        child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
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
                          );
                        },
                        error: (error, stackTrace) {
                          error.toString().log();
                          return const SizedBox.shrink();
                        },
                        loading: () {
                          return const Loadinggg(height: 40);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        stackTrace.log();
        return const SizedBox.shrink();
      },
      loading: () {
        return const Loadinggg(
          height: 40,
        );
      },
    );
  }
}
