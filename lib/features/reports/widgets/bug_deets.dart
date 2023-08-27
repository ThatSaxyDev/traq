// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/myicon.dart';

class BugDeets extends StatelessWidget {
  final String icon;
  final String title;
  final Widget content;
  final double? height;
  const BugDeets({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 24.h,
      child: Row(
        children: [
           Expanded(
            flex: 1,
            child: CenterLeft(
              child: MyIcon(icon: icon),
            ),
          ),
          Expanded(
            flex: 3,
            child: CenterLeft(
              child: title.txt(
                size: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: CenterLeft(
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}

String getVersion(String input) {
  List<String> parts = input.split(' -v');
  if (parts.length > 1) {
    return parts[1];
  } else {
    return 'Version not found';
  }
}
