// import 'package:file_picker/file_picker.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:traq/core/type_defs.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';

void showSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: text.txt16(
          fontWeight: FontWeight.w500,
          color: Pallete.whiteColor,
        ),
      ),
    );
}

// Future<FilePickerResult?> pickImage() async {
//   final image = await FilePicker.platform.pickFiles(type: FileType.image);

//   return image;
// }

//! SHOW BANNER
showBanner({
  required BuildContext context,
  required String theMessage,
  required NotificationType theType,
  Duration? dismissIn,
}) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      elevation: 4,
      padding: EdgeInsets.symmetric(
        vertical: 20.0.sh,
        horizontal: 25.0.sw,
      ),
      forceActionsBelow: true,
      backgroundColor: theType == NotificationType.failure
          ? Colors.red.shade400
          : theType == NotificationType.success
              ? Colors.green.shade400
              : Pallete.orange,

      //! THE CONTENT
      content: Text(
        theMessage,
        style: TextStyle(
          fontSize: 14.sw,
          fontWeight: FontWeight.w500,
          color: Pallete.whiteColor,
        ),
      ),

      //! ACTIONS - DISMISS BUTTON
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              padding: const EdgeInsets.all(12.0),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white24,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.0.sw),
              ),
            ),
            child: Text(
              "Dismiss",
              style: TextStyle(
                  fontSize: 12.sw,
                  fontWeight: FontWeight.w500,
                  color: Pallete.whiteColor),
            ),
          ),
        ),
      ],
    ),
  );

  //! DISMISS AFTER 2 SECONDS
  Timer(
    dismissIn ?? const Duration(milliseconds: 2500),
    () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
  );
}
