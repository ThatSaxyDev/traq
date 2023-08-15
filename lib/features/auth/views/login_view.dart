// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/responsize/screen_type_layout.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/button.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: ScreenTypeLayoutWrapper(
        mobile: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: isLoading
                ? const Loadinggg(
                    height: 40,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      'traq'.txt(
                        size: 40,
                        fontWeight: FontWeight.w600,
                        color: Pallete.blueColor,
                      ),
                      70.hSpace,
                      const GButton(),

                      //! apple
                      // if (Platform.isIOS) const AppleButton()
                    ],
                  ),
          ),
        ),

        //! desktop
        desktop: Center(
          child: Container(
            height: 450,
            width: 400,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 10,
                  offset: Offset(1, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: isLoading
                  ? const Loadinggg(
                      height: 40,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        'traq'.txt(
                          size: 40,
                          fontWeight: FontWeight.w600,
                          color: Pallete.blueColor,
                        ),
                        70.hSpace,
                        const GButton(),

                        //! apple
                        // if (Platform.isIOS) const AppleButton()
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
