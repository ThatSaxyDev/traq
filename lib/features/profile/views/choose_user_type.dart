import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/profile/controllers/profile_controller.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/responsize/screen_type_layout.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/button.dart';

class ChooseUserType extends ConsumerWidget {
  const ChooseUserType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isProfileLoading = ref.watch(userProfileControllerProvider);
    UserModel user = ref.watch(userProvider)!;
    return Scaffold(
      body: Center(
        child: isProfileLoading
            ? const Loadinggg(
                height: 40,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hey, ',
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: user.nickName,
                          style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.hSpace,
                  'Who are you?'.txt16(),
                  60.hSpace,

                  ScreenTypeLayoutWrapper(
                    mobile: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //! team lead
                        TransparentButton(
                          onTap: () {
                            ref
                                .read(userProfileControllerProvider.notifier)
                                .editUserProfile(
                                    context: context,
                                    user: user.copyWith(
                                      isTeamLead: true,
                                      isUserTypePicked: true,
                                    ));
                          },
                          height: 150,
                          width: 150,
                          isText: false,
                          item: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                PhosphorIcons.userGear,
                                color: Pallete.blueColor,
                              ),
                              15.hSpace,
                              'Lead'.txt16(isheader: true),
                            ],
                          ),
                        ),
                        30.hSpace,

                        //! team member
                        TransparentButton(
                          onTap: () {
                            ref
                                .read(userProfileControllerProvider.notifier)
                                .editUserProfile(
                                    context: context,
                                    user: user.copyWith(
                                      isUserTypePicked: true,
                                    ));
                          },
                          height: 150,
                          width: 150,
                          isText: false,
                          item: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                PhosphorIcons.users,
                                color: Pallete.blueColor,
                              ),
                              15.hSpace,
                              'Member'.txt16(isheader: true),
                            ],
                          ),
                        )
                      ],
                    ),
                    desktop: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //! team lead
                        TransparentButton(
                          onTap: () {
                            ref
                                .read(userProfileControllerProvider.notifier)
                                .editUserProfile(
                                    context: context,
                                    user: user.copyWith(
                                      isTeamLead: true,
                                      isUserTypePicked: true,
                                    ));
                          },
                          height: 200,
                          width: 200,
                          isText: false,
                          item: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                PhosphorIcons.userGear,
                                color: Pallete.blueColor,
                              ),
                              15.hSpace,
                              'Lead'.txt16(isheader: true),
                            ],
                          ),
                        ),
                        30.wSpace,

                        //! team member
                        TransparentButton(
                          onTap: () {
                            ref
                                .read(userProfileControllerProvider.notifier)
                                .editUserProfile(
                                    context: context,
                                    user: user.copyWith(
                                      isUserTypePicked: true,
                                    ));
                          },
                          height: 200,
                          width: 200,
                          isText: false,
                          item: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                PhosphorIcons.users,
                                color: Pallete.blueColor,
                              ),
                              15.hSpace,
                              'Member'.txt16(isheader: true),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  //! choose route
                ],
              ),
      ),
    );
  }
}
