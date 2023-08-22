import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_notifier/simple_notifier.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
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
  ValueNotifier<String> project = ''.notifier;
  List<String> choices = <String>['TestProject', 'New Project'];

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(40),
              color: Pallete.whiteColor,
              width: 720,
              child: Column(
                children: [
                  Row(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Associated projects',
                                  style: GoogleFonts.manrope(
                                    textStyle: const TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 14,
                                      height: 1.43,
                                    ),
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  position: PopupMenuPosition.under,
                                  padding: EdgeInsets.zero,
                                  onSelected: (value) {
                                    project.value = value;
                                  },
                                  icon: Container(
                                    height: 44,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Color(0xFFD1D5DB)),
                                        borderRadius: BorderRadius.circular(4),
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
                                            project.listen(
                                              builder:
                                                  (context, value, child) =>
                                                      switch (project.value) {
                                                '' => Text(
                                                    'Select project',
                                                    style: GoogleFonts.manrope(
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
                                                    project.value,
                                                    style: GoogleFonts.manrope(
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
                                              },
                                            ),
                                            const Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              size: 17,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return choices.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ]))
                    ],
                  ),

                  16.hSpace,
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
