//! THIS FILE CONTAINS HOPEFULLY, ALL EXTENSIONS USED IN THE APP.
import "dart:developer" as dev_tools show log;
import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:responsive_builder/responsive_builder.dart";
// import 'package:url_launcher/url_launcher.dart' show launchUrl;

//! LOG EXTENSION - THIS HELPS TO CALL A .log() ON ANY OBJECT
extension Log on Object {
  void log() => dev_tools.log(toString());
}

//! HELPS TO CALL A .dismissKeyboard ON A WIDGET
extension DismissKeyboard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}

extension AppHapticFeedback on Widget {
  Widget withHapticFeedback({
    required VoidCallback? onTap,
    required AppHapticFeedbackType feedbackType,
  }) =>
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async => {
          onTap?.call(),
          switch (feedbackType) {
            AppHapticFeedbackType.lightImpact =>
              await HapticFeedback.lightImpact(),
            AppHapticFeedbackType.mediumImpact =>
              await HapticFeedback.mediumImpact(),
            AppHapticFeedbackType.heavyImpact =>
              await HapticFeedback.heavyImpact(),
            AppHapticFeedbackType.selectionClick =>
              await HapticFeedback.selectionClick(),
            AppHapticFeedbackType.vibrate => await HapticFeedback.vibrate(),
          }
        },
        child: this,
      );
}

//! FOR HAPTIC FEEDBACK
enum AppHapticFeedbackType {
  lightImpact,
  mediumImpact,
  heavyImpact,
  selectionClick,
  vibrate,
}

const ext = 0;
final formatCurrency =
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

//Formats the amount and returns a formatted amount
String formatPrice(String amount) {
  return formatCurrency.format(num.parse(amount)).toString();
}

extension StringCasingExtension on String {
  String? camelCase() => toBeginningOfSentenceCase(this);
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  String? trimToken() => contains(":") ? split(":")[1].trim() : this;
  String? trimSpaces() => replaceAll(" ", "");
  String removeSpacesAndLower() => replaceAll(' ', '').toLowerCase();
}

extension WidgetExtensionss on num {
  Widget get sbH => SizedBox(
        height: h,
      );

  Widget get sbW => SizedBox(
        width: w,
      );

  EdgeInsetsGeometry get padV => EdgeInsets.symmetric(vertical: h);

  EdgeInsetsGeometry get padH => EdgeInsets.symmetric(horizontal: w);
}

extension WidgetExtensions on double {
  Widget get sbH => SizedBox(
        height: h,
      );

  Widget get sbW => SizedBox(
        width: w,
      );

  EdgeInsetsGeometry get padA => EdgeInsets.all(this);

  EdgeInsetsGeometry get padV => EdgeInsets.symmetric(vertical: h);

  EdgeInsetsGeometry get padH => EdgeInsets.symmetric(horizontal: w);
}

extension SpacingExtension on double {
  SizedBox get hSpace {
    return SizedBox(height: this);
  }

  SizedBox get wSpace {
    return SizedBox(width: this);
  }

  SizedBox hSpaceW(double vertical) {
    return SizedBox(height: screenHeight, width: vertical.screenWidth);
  }
}

extension SpacingNumExtension on num {
  SizedBox get hSpace {
    return SizedBox(height: toDouble());
  }

  SizedBox get wSpace {
    return SizedBox(width: toDouble());
  }

  SizedBox hSpaceW(double vertical) {
    return SizedBox(height: toDouble(), width: vertical.toDouble());
  }
}

extension PercentageExtension on double {
  double asPercentageOf(double divisor) {
    if (divisor == 0) {
      throw ArgumentError('Divisor cannot be zero');
    }
    return (this * 100) / divisor;
  }
}

extension StyledTextExtension on String {
  Text txt({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    bool? isheader,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
  }) {
    return Text(this,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(
            height: height,
            fontSize: size ?? 14,
            color: switch (isheader) {
              true => color ?? const Color(0xFF111827),
              _ => color ?? const Color(0xFF6B7280),
            },
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            fontStyle: fontStyle,
            decoration: decoration,
          ),
        ));
  }
}

extension StyledTextExtension14 on String {
  Text txt14({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    bool? isheader,
    int? maxLines,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontSize: 14,
          color: switch (isheader) {
            true => color ?? const Color(0xFF111827),
            _ => color ?? const Color(0xFF6B7280),
          },
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: fontStyle,
          decoration: decoration,
        ),
      ),
    );
  }
}

extension StyledTextExtension12 on String {
  Text txt12({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    bool? isheader,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontSize: 12,
          color: switch (isheader) {
            true => color ?? const Color(0xFF111827),
            _ => color ?? const Color(0xFF6B7280),
          },
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: fontStyle,
          decoration: decoration,
        ),
      ),
    );
  }
}

extension StyledTextExtension16 on String {
  Text txt16({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    bool? isheader,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontSize: 16,
          color: switch (isheader) {
            true => color ?? const Color(0xFF111827),
            _ => color ?? const Color(0xFF6B7280),
          },
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: fontStyle,
          decoration: decoration,
        ),
      ),
    );
  }
}

extension StyledTextExtension24 on String {
  Text txt24({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    bool? isheader,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.manrope(
        textStyle: TextStyle(
          fontSize: 24,
          color: switch (isheader) {
            true => color ?? const Color(0xFF111827),
            _ => color ?? const Color(0xFF6B7280),
          },
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: fontStyle,
          decoration: decoration,
        ),
      ),
    );
  }
}

extension ImagePath on String {
  String get png => 'lib/assets/images/$this.png';
  String get jpg => 'lib/assets/images/$this.jpg';
  String get gif => 'lib/assets/images/$this.gif';
}

extension IconPath on String {
  String get iconPng => 'lib/assets/icons/$this.png';
  String get iconSvg => 'lib/assets/icons/$this.svg';
}

extension NumExtensions on int {
  num addPercentage(num v) => this + ((v / 100) * this);
  num getPercentage(num v) => ((v / 100) * this);
}

extension NumExtensionss on num {
  num addPercentage(num v) => this + ((v / 100) * this);
  num getPercentage(num v) => ((v / 100) * this);
}

// void openUrl({String? url}) {
//   launchUrl(Uri.parse("http://$url"));
// }

// void openMailApp({String? receiver, String? title, String? body}) {
//   launchUrl(Uri.parse("mailto:$receiver?subject=$title&body=$body"));
// }

// extension WidgetExtensionss on num {
//   Widget get sbH => SizedBox(
//         height: h,
//       );

//   Widget get sbW => SizedBox(
//         width: w,
//       );

//   EdgeInsetsGeometry get padV => EdgeInsets.symmetric(vertical: h);

//   EdgeInsetsGeometry get padH => EdgeInsets.symmetric(horizontal: w);
// }

// extension WidgetExtensions on double {
//   Widget get sbH => SizedBox(
//         height: h,
//       );

//   Widget get sbW => SizedBox(
//         width: w,
//       );

//   EdgeInsetsGeometry get padA => EdgeInsets.all(this);

//   EdgeInsetsGeometry get padV => EdgeInsets.symmetric(vertical: h);

//   EdgeInsetsGeometry get padH => EdgeInsets.symmetric(horizontal: w);
// }

extension ImageExtension on String {
  Image mage({
    Color? color,
    required double? h,
    BoxFit? fit,
  }) {
    return Image.asset(
      this,
      height: h,
      fit: fit,
      color: color,
    );
  }
}

extension DurationExtension on int {
  Duration duration({
    int days = 0,
    int hrs = 0,
    int mins = 0,
    int secs = 0,
    int ms = 0,
    int microsecs = 0,
  }) {
    return Duration(
      days: days,
      hours: hrs,
      minutes: mins,
      seconds: secs,
      milliseconds: ms,
      microseconds: microsecs,
    );
  }
}

extension InkWellExtension on Widget {
  InkWell tap({
    required GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    BorderRadius? borderRadius,
    Color? splashColor = Colors.transparent,
    Color? highlightColor = Colors.transparent,
  }) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: this,
    );
  }
}

extension AlignExtension on Widget {
  Align align(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Align alignCenter() {
    return Align(
      alignment: Alignment.center,
      child: this,
    );
  }

  Align alignCenterLeft() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Align alignCenterRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Align alignTopCenter() {
    return Align(
      alignment: Alignment.topCenter,
      child: this,
    );
  }

  Align alignBottomCenter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }

  // Add more alignment methods as needed

  // Example: alignTopCenter, alignBottomRight, etc.
}

extension WidgetAnimation on Widget {
  Animate fadeInFromTop({
    Duration? delay,
    Duration? animatiomDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animatiomDuration ?? 500.ms,
            begin: offset ?? const Offset(0, -1),
          )
          .fade(duration: animatiomDuration ?? 500.ms);

  Animate fadeInFromBottom({
    Duration? delay,
    Duration? animatiomDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 500.ms)
          .move(
            duration: animatiomDuration ?? 500.ms,
            begin: offset ?? const Offset(0, 10),
          )
          .fade(duration: animatiomDuration ?? 500.ms);

  Animate fadeIn({
    Duration? delay,
    Duration? animatiomDuration,
    Curve? curve,
  }) =>
      animate(delay: delay ?? 500.ms).fade(
        duration: animatiomDuration ?? 500.ms,
        curve: curve ?? Curves.decelerate,
      );
}
