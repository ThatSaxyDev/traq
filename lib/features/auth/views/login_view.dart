// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/button.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: isLoading
            ? const Loadinggg(
                height: 40,
              )
            : Column(
                children: [
                  150.hSpace,

                  170.hSpace,
                  const GButton(),
                  20.hSpace,

                  //! apple
                  // if (Platform.isIOS) const AppleButton()
                ],
              ),
      ),
    );
  }
}
