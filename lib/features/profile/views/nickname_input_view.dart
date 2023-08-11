// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/profile/controllers/profile_controller.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/responsize/screen_type_layout.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/nav.dart';
import 'package:traq/utils/snack_bar.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/text_input.dart';

class NickNameInputView extends ConsumerStatefulWidget {
  const NickNameInputView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NickNameInputViewState();
}

class _NickNameInputViewState extends ConsumerState<NickNameInputView> {
  final TextEditingController _nickNameController = TextEditingController();

  @override
  void dispose() {
    _nickNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isProfileLoading = ref.watch(userProfileControllerProvider);
    UserModel user = ref.watch(userProvider)!;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: ScreenTypeLayoutWrapper(
        mobile: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: isProfileLoading
                ? const Loadinggg(
                    height: 40,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      'Welcome ${user.name}'.txt(
                        size: 40,
                        fontWeight: FontWeight.w600,
                        color: Pallete.blueColor,
                      ),
                      70.hSpace,

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
            width: 500,
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
              child: isProfileLoading
                  ? const Loadinggg(
                      height: 40,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Welcome, ',
                                style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: user.name,
                                style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        70.hSpace,
                        TextInputWidget(
                          autofocus: true,
                          width: 400,
                          hintText: 'e.g AgbaDev',
                          inputTitle:
                              'What should we call you? A nickname perhaps',
                          controller: _nickNameController,
                        ),
                        40.hSpace,
                        BButton(
                          width: 200,
                          height: 50,
                          onTap: () =>
                              switch (_nickNameController.text.length > 5) {
                            true => ref
                                .read(userProfileControllerProvider.notifier)
                                .editUserProfile(
                                  context: context,
                                  user: user.copyWith(
                                    nickName: _nickNameController.text.trim(),
                                  ),
                                  // sideEffect: () {
                                  //   goTo(context: context, route: route);
                                  // },
                                ),
                            false => showSnackBar(
                                context: context,
                                text:
                                    'Your nickname should be between 5-10 letters, with no numbers or symbols'),
                          },
                          text: 'Continue',
                        )

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
