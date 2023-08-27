// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traq/features/base_nav/views/base_nav_view.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';

class NavBarWidget extends ConsumerWidget {
  final Nav nav;
  const NavBarWidget({
    Key? key,
    required this.nav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    return Container(
      color: Colors.transparent,
      width: 80.w,
      child: Column(
        children: [
          //! ICON
          SvgPicture.asset(
            indexFromController == nav.index
                ? nav.icon.iconSvg
                : nav.unselectedicon.iconSvg,
            height: 24.h,
            width: 24.w,
          ),

          //! SPACER
          4.sbH,

          //! LABEL
          Text(
            nav.label,
            style: TextStyle(
              color: indexFromController == nav.index
                  ? const Color(0xFF111827)
                  : const Color(0xFF9CA3AF),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    ).withHapticFeedback(
      onTap: () {
        moveToPage(
          context: context,
          ref: ref,
          index: nav.index,
        );
      },
      feedbackType: AppHapticFeedbackType.lightImpact,
    );
  }
}
