import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_notifier/simple_notifier.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/features/reports/controllers/reports_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/models/version_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/myicon.dart';
import 'package:traq/utils/widgets/text_input.dart';

class BugReportDrawer extends ConsumerStatefulWidget {
  const BugReportDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BugReportDrawerState();
}

class _BugReportDrawerState extends ConsumerState<BugReportDrawer> {
  final TextEditingController _bugTitleController = TextEditingController();
  final TextEditingController _devicePlatformController =
      TextEditingController();
  final TextEditingController _bugDescriptionController =
      TextEditingController();
  final TextEditingController _bugStepsController = TextEditingController();
  ValueNotifier<String> bugPriorityValue = ''.notifier;
  // List<ProjectModel> choices = [];
  List<String> bugPriorities = ['Critical', 'High', 'Medium', 'Low'];

  @override
  void dispose() {
    _bugDescriptionController.dispose();
    _bugTitleController.dispose();
    _devicePlatformController.dispose();
    _bugStepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isReportsLoading = ref.watch(reportsControllerProvider);
    VersionModel? versionFromState =
        ref.watch(versionModelStateControllerProvider);
    // OrganisationModel? orgFromProvider =
    //     ref.watch(orgModelStateControllerProvider);
    // ref.watch(getProjectsForAnOrganisationProvider(orgFromProvider!.name)).when(
    //       data: (data) {
    //         Future(() {
    //           choices = data;
    //         });
    //       },
    //       error: (error, stackTrace) {
    //         error.toString().log();
    //       },
    //       loading: () {},
    //     );
    return Material(
      elevation: 0,
      color: Colors.black.withOpacity(0.3),
      child: SizedBox(
        height: height(context),
        width: width(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: height(context),
              padding: const EdgeInsets.all(40),
              color: Pallete.whiteColor,
              width: 720,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      //! header
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Report a bug'.txt(
                          isheader: true,
                          size: 32,
                          fontWeight: FontWeight.w600,
                        ),
                        MyIcon(
                          icon: 'x',
                          height: 24,
                          onTap: () {
                            toggleOverlayBug(context: context, ref: ref);
                          },
                        ),
                      ],
                    ),
                    32.hSpace,
                    'Bug Details'
                        .txt(
                          isheader: true,
                          size: 18,
                          fontWeight: FontWeight.w600,
                        )
                        .alignCenterLeft(),
                    24.hSpace,

                    //! bug title, select project
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextInputWidget(
                          width: 308,
                          autofocus: true,
                          hintText: '',
                          inputTitle: 'Bug title',
                          controller: _bugTitleController,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                            height: 68,
                            width: 308,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Bug priority',
                                    style: GoogleFonts.manrope(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                        height: 1.43,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    surfaceTintColor: Colors.white,
                                    color: Colors.white,
                                    tooltip: '',
                                    position: PopupMenuPosition.under,
                                    padding: EdgeInsets.zero,
                                    onSelected: (value) {
                                      bugPriorityValue.value = value;
                                    },
                                    icon: Container(
                                      height: 44,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Color(0xFFD1D5DB)),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              bugPriorityValue.listen(
                                                builder:
                                                    (context, value, child) =>
                                                        switch (bugPriorityValue
                                                            .value) {
                                                  '' => Text(
                                                      'Select bug priority',
                                                      style:
                                                          GoogleFonts.manrope(
                                                        textStyle:
                                                            const TextStyle(
                                                          color:
                                                              Color(0xFF9CA3AF),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.43,
                                                        ),
                                                      ),
                                                    ),
                                                  _ => Text(
                                                      bugPriorityValue.value,
                                                      style:
                                                          GoogleFonts.manrope(
                                                        textStyle:
                                                            const TextStyle(
                                                          color:
                                                              Color(0xFF111827),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.43,
                                                        ),
                                                      ),
                                                    ),
                                                },
                                              ),
                                              const Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: Colors.black,
                                                size: 17,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return bugPriorities.map((choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          // 'Critical', 'High', 'Medium', 'Low'
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: switch (choice) {
                                                  'Critical' =>
                                                    Pallete.critical,
                                                  'High' => Pallete.high,
                                                  'Medium' => Pallete.medium,
                                                  _ => Pallete.low,
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              choice,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ]))
                      ],
                    ),
                    16.hSpace,

                    //! bug decription, steps to reproduce
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextInputWidget(
                          width: 308,
                          height: 112,
                          fieldHeight: 90,
                          maxLines: 5,
                          hintText: 'Enter bug Description',
                          inputTitle: 'Bug Description',
                          keyboardType: TextInputType.multiline,
                          controller: _bugDescriptionController,
                          onChanged: (value) {},
                        ),
                        TextInputWidget(
                          width: 308,
                          height: 112,
                          fieldHeight: 90,
                          maxLines: 5,
                          hintText: 'Detailed steps to reproduce bug',
                          inputTitle: 'Steps to reproduce bug',
                          keyboardType: TextInputType.multiline,
                          controller: _bugStepsController,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                    16.hSpace,

                    //! UPLOAD
                    SizedBox(
                        height: 92,
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Attachments',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 14,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              Container(
                                height: 68,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xFFD1D5DB)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Click here to upload attachments',
                                    style: GoogleFonts.manrope(
                                      decoration: TextDecoration.underline,
                                      textStyle: const TextStyle(
                                        color: Color(0xFF4A21C1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.43,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ])),
                    20.hSpace,
                    const Divider(
                      color: Color(0xFFF2F4F7),
                    ),
                    20.hSpace,

                    //! Bug environment
                    'Bug environment'
                        .txt(
                          isheader: true,
                          size: 18,
                          fontWeight: FontWeight.w600,
                        )
                        .alignCenterLeft(),
                    Text(
                      'Environment information about where the bug was encountered',
                      style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          height: 1.43,
                        ),
                      ),
                    ).alignCenterLeft(),
                    24.hSpace,

                    //! platform./device, version
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextInputWidget(
                          width: 308,
                          autofocus: true,
                          hintText: '',
                          inputTitle: 'Platform/Device',
                          controller: _devicePlatformController,
                          onChanged: (value) {},
                        ),
                        // projectModel.listen(
                        //   builder: (context, value, child) {
                        //     if (projectModel.value.id == '1') {
                        //       return SizedBox(
                        //         height: 68,
                        //         width: 308,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'Version',
                        //               style: GoogleFonts.manrope(
                        //                 textStyle: const TextStyle(
                        //                   color: Color(0xFF6B7280),
                        //                   fontSize: 14,
                        //                   height: 1.43,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               height: 44,
                        //               decoration: ShapeDecoration(
                        //                 color: Colors.white,
                        //                 shape: RoundedRectangleBorder(
                        //                   side: const BorderSide(
                        //                       color: Color(0xFFD1D5DB)),
                        //                   borderRadius:
                        //                       BorderRadius.circular(4),
                        //                 ),
                        //               ),
                        //               child: Center(
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 16),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Text(
                        //                         'Select version',
                        //                         style: GoogleFonts.manrope(
                        //                           textStyle: const TextStyle(
                        //                             color: Color(0xFF9CA3AF),
                        //                             fontSize: 14,
                        //                             fontWeight: FontWeight.w500,
                        //                             height: 1.43,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       const Icon(
                        //                         Icons
                        //                             .keyboard_arrow_down_outlined,
                        //                         size: 17,
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     } else {
                        //       return SizedBox(
                        //         height: 68,
                        //         width: 308,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'Version',
                        //               style: GoogleFonts.manrope(
                        //                 textStyle: const TextStyle(
                        //                   color: Color(0xFF6B7280),
                        //                   fontSize: 14,
                        //                   height: 1.43,
                        //                 ),
                        //               ),
                        //             ),
                        //             PopupMenuButton<String>(
                        //               tooltip: '',
                        //               position: PopupMenuPosition.under,
                        //               padding: EdgeInsets.zero,
                        //               onSelected: (value) {
                        //                 version.value = value;
                        //               },
                        //               icon: Container(
                        //                 height: 44,
                        //                 decoration: ShapeDecoration(
                        //                   color: Colors.white,
                        //                   shape: RoundedRectangleBorder(
                        //                     side: const BorderSide(
                        //                         color: Color(0xFFD1D5DB)),
                        //                     borderRadius:
                        //                         BorderRadius.circular(4),
                        //                   ),
                        //                 ),
                        //                 child: Center(
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.symmetric(
                        //                         horizontal: 16),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         version.listen(
                        //                           builder: (context, value,
                        //                                   child) =>
                        //                               switch (version.value) {
                        //                             '' => Text(
                        //                                 'Select version',
                        //                                 style:
                        //                                     GoogleFonts.manrope(
                        //                                   textStyle:
                        //                                       const TextStyle(
                        //                                     color: Color(
                        //                                         0xFF9CA3AF),
                        //                                     fontSize: 14,
                        //                                     fontWeight:
                        //                                         FontWeight.w500,
                        //                                     height: 1.43,
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             _ => Text(
                        //                                 version.value,
                        //                                 style:
                        //                                     GoogleFonts.manrope(
                        //                                   textStyle:
                        //                                       const TextStyle(
                        //                                     color: Color(
                        //                                         0xFF111827),
                        //                                     fontSize: 14,
                        //                                     fontWeight:
                        //                                         FontWeight.w500,
                        //                                     height: 1.43,
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                           },
                        //                         ),
                        //                         const Icon(
                        //                           Icons
                        //                               .keyboard_arrow_down_outlined,
                        //                           size: 17,
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               itemBuilder: (BuildContext context) {
                        //                 return projectVersions.value
                        //                     .map((choice) {
                        //                   return PopupMenuItem<String>(
                        //                     value: choice,
                        //                     child: Text(choice),
                        //                   );
                        //                 }).toList();
                        //               },
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                    120.hSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TransparentButton(
                          width: 110,
                          text: 'Cancel',
                          onTap: () {
                            toggleOverlayBug(context: context, ref: ref);
                          },
                        ),
                        16.wSpace,
                        isReportsLoading == true
                            ? const Loadinggg(height: 40)
                            : BButton(
                                width: 183,
                                color: const Color(0xFFD3C4FF),
                                text: 'Submit bug report',
                                onTap: () {
                                  ref
                                      .read(reportsControllerProvider.notifier)
                                      .reportBug(
                                        context: context,
                                        version: versionFromState!,
                                        bugName: _bugTitleController.text,
                                        priority: bugPriorityValue.value,
                                        platformDevice:
                                            _devicePlatformController.text,
                                        steps: _bugStepsController.text,
                                        description:
                                            _bugDescriptionController.text,
                                        image: null,
                                        sideEffect: () {
                                          toggleOverlayBug(
                                              context: context, ref: ref);
                                        },
                                      );
                                },
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




//  SizedBox(
//                             height: 68,
//                             width: 308,
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Associated Project',
//                                     style: GoogleFonts.manrope(
//                                       textStyle: const TextStyle(
//                                         color: Color(0xFF6B7280),
//                                         fontSize: 14,
//                                         height: 1.43,
//                                       ),
//                                     ),
//                                   ),
//                                   PopupMenuButton<ProjectModel>(
//                                     tooltip: '',
//                                     position: PopupMenuPosition.under,
//                                     padding: EdgeInsets.zero,
//                                     onSelected: (value) {
//                                       setState(() {
//                                         project.value = value.name;
//                                         projectModel.value = value;
//                                         projectVersions.value = value.versions;
//                                       });
//                                     },
//                                     icon: Container(
//                                       height: 44,
//                                       decoration: ShapeDecoration(
//                                         color: Colors.white,
//                                         shape: RoundedRectangleBorder(
//                                           side: const BorderSide(
//                                               color: Color(0xFFD1D5DB)),
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               project.listen(
//                                                 builder:
//                                                     (context, value, child) =>
//                                                         switch (project.value) {
//                                                   '' => Text(
//                                                       'Select project',
//                                                       style:
//                                                           GoogleFonts.manrope(
//                                                         textStyle:
//                                                             const TextStyle(
//                                                           color:
//                                                               Color(0xFF9CA3AF),
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           height: 1.43,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   _ => Text(
//                                                       project.value,
//                                                       style:
//                                                           GoogleFonts.manrope(
//                                                         textStyle:
//                                                             const TextStyle(
//                                                           color:
//                                                               Color(0xFF111827),
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           height: 1.43,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                 },
//                                               ),
//                                               const Icon(
//                                                 Icons
//                                                     .keyboard_arrow_down_outlined,
//                                                 size: 17,
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     itemBuilder: (BuildContext context) {
//                                       return choices.map((choice) {
//                                         return PopupMenuItem<ProjectModel>(
//                                           value: choice,
//                                           child: Text(choice.name),
//                                         );
//                                       }).toList();
//                                     },
//                                   ),
//                                 ]))