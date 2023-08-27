// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_notifier/simple_notifier.dart';

import 'package:traq/features/reports/controllers/reports_controller.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/models/version_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/snack_bar.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/text_input.dart';

class ReportBugBottomSheet extends ConsumerStatefulWidget {
  final VersionModel version;
  const ReportBugBottomSheet({
    super.key,
    required this.version,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReportBugBottomSheetState();
}

class _ReportBugBottomSheetState extends ConsumerState<ReportBugBottomSheet> {
  final TextEditingController _bugTitleController = TextEditingController();
  final TextEditingController _devicePlatformController =
      TextEditingController();
  final TextEditingController _bugDescriptionController =
      TextEditingController();
  final TextEditingController _bugStepsController = TextEditingController();
  ValueNotifier<String> bugPriorityValue = ''.notifier;
  List<String> bugPriorities = ['Critical', 'High', 'Medium', 'Low'];
  ValueNotifier<String> platformValue = ''.notifier;
  List<String> platforms = ['Android', 'iOS', 'Web', 'Windows', 'MacOS'];
  File? image;

  void takePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);

      // updateUserInfoPROFILEPHOTO(profilePhoto: imageTemp);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      e.log();
      showSnackBar(
          context: context, text: 'An error occurred while opening the camera');
    }
  }

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
    return Container(
      height: 700.h,
      width: width(context),
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Padding(
        padding: 24.padH,
        child: Column(
          children: [
            40.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Report a bug'.txt(
                  size: 24.sp,
                  fontWeight: FontWeight.w600,
                  isheader: true,
                ),
                Icon(
                  PhosphorIcons.xBold,
                  size: 23.sp,
                  color: Colors.black,
                ).tap(onTap: () {
                  Navigator.of(context).pop();
                }),
              ],
            ),
            20.sbH,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    12.sbH,
                    //! Bug Details
                    'Bug Details'
                        .txt(
                          size: 16.sp,
                          fontWeight: FontWeight.w600,
                          isheader: true,
                        )
                        .alignCenterLeft(),
                    24.sbH,

                    //! bug title
                    TextInputWidget(
                      autofocus: true,
                      hintText: '',
                      inputTitle: 'Bug title',
                      controller: _bugTitleController,
                      onChanged: (value) {},
                    ),
                    16.sbH,

                    //! Bug Description
                    TextInputWidget(
                      height: 112.h,
                      fieldHeight: 90.h,
                      maxLines: 5,
                      hintText: 'Enter bug Description',
                      inputTitle: 'Bug Description',
                      keyboardType: TextInputType.multiline,
                      controller: _bugDescriptionController,
                      onChanged: (value) {},
                    ),

                    16.sbH,
                    SizedBox(
                        height: 68.h,
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bug priority',
                                style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 14.sp,
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
                                  height: 44.h,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Color(0xFFD1D5DB)),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          bugPriorityValue.listen(
                                            builder: (context, value, child) =>
                                                switch (
                                                    bugPriorityValue.value) {
                                              '' => Text(
                                                  'Select bug priority',
                                                  style: GoogleFonts.manrope(
                                                    textStyle: TextStyle(
                                                      color: const Color(
                                                          0xFF9CA3AF),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.43,
                                                    ),
                                                  ),
                                                ),
                                              _ => Text(
                                                  bugPriorityValue.value,
                                                  style: GoogleFonts.manrope(
                                                    textStyle: TextStyle(
                                                      color: const Color(
                                                          0xFF111827),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.43,
                                                    ),
                                                  ),
                                                ),
                                            },
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.black,
                                            size: 17.sp,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                            color: switch (choice) {
                                              'Critical' => Pallete.critical,
                                              'High' => Pallete.high,
                                              'Medium' => Pallete.medium,
                                              _ => Pallete.low,
                                            },
                                            borderRadius:
                                                BorderRadius.circular(5.r)),
                                        child: Text(
                                          choice,
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ])),
                    16.sbH,

                    //! attchments
                    SizedBox(
                        height: 92.h,
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Attachments',
                                style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 14.sp,
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              Container(
                                height: 68.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xFFD1D5DB)),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                child: Center(
                                  child: image == null
                                      ? Text(
                                          'Click here to upload attachments',
                                          style: GoogleFonts.manrope(
                                            decoration:
                                                TextDecoration.underline,
                                            textStyle: TextStyle(
                                              color: const Color(0xFF4A21C1),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              height: 1.43,
                                            ),
                                          ),
                                        ).tap(
                                          onTap: () =>
                                              takePhoto(ImageSource.gallery),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50.h,
                                              width: 50.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                    image!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ), 
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    image = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                    PhosphorIcons.xBold))
                                          ],
                                        ),
                                ),
                              ).tap(
                                onTap: () => takePhoto(ImageSource.gallery),
                              ),
                            ])),
                    20.sbH,
                    const Divider(
                      color: Color(0xFFF2F4F7),
                    ),
                    20.sbH,
                    //! Bug environment
                    'Bug environment'
                        .txt(
                          isheader: true,
                          size: 18.sp,
                          fontWeight: FontWeight.w600,
                        )
                        .alignCenterLeft(),
                    Text(
                      'Environment information about where the bug was encountered',
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                          color: const Color(0xFF6B7280),
                          fontSize: 14.sp,
                          height: 1.43,
                        ),
                      ),
                    ).alignCenterLeft(),
                    24.sbH,

                    //! platform./device, version
                    TextInputWidget(
                      hintText: '',
                      inputTitle: 'Platform/Device',
                      controller: _devicePlatformController,
                      onChanged: (value) {},
                    ),

                    32.sbH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TransparentButton(
                          width: 110,
                          text: 'Cancel',
                          onTap: () {
                            Navigator.of(context).pop();
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
                                        version: widget.version,
                                        bugName: _bugTitleController.text,
                                        priority: bugPriorityValue.value,
                                        platformDevice:
                                            _devicePlatformController.text,
                                        steps: _bugStepsController.text,
                                        description:
                                            _bugDescriptionController.text,
                                        image: image,
                                        sideEffect: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                },
                              ),
                      ],
                    ),
                    400.sbH,
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
