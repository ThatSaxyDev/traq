// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // if (nav.index > 2) {
    //   indexFromController = indexFromController + 1;
    // }
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          //! ICON
          Icon(
            switch (indexFromController == nav.index) {
              true => nav.selectedIcon,
              false => nav.icon,
            },
            color: switch (indexFromController == nav.index) {
              true => Pallete.blackColor,
              false =>
                Pallete.greyColor,
            },
          ),

          // //! SPACER
          // 8.4.sbH,
        ],
      ),
    ).tap(
      onTap: () {
        // if (nav.index < 2) {
        //   moveToPage(
        //     context: context,
        //     ref: ref,
        //     index: nav.index,
        //   );
        // }
        // if (nav.index == 2) {
        //   showModalBottomSheet(
        //     isScrollControlled: true,
        //     enableDrag: true,
        //     backgroundColor: Colors.transparent,
        //     context: context,
        //     builder: (context) => const Wrap(
        //       children: [
        //         CreatePostBottomSheet(),
        //       ],
        //     ),
        //   );
        // }
        // if (nav.index > 2) {
        //   moveToPage(
        //     context: context,
        //     ref: ref,
        //     index: nav.index - 1,
        //   );
        // }
        moveToPage(
          context: context,
          ref: ref,
          index: nav.index,
        );
      },
    );
  }
}
