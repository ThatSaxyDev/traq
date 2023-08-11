import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/profile/controllers/profile_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/responsize/screen_type_layout.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/nav.dart';
import 'package:traq/utils/snack_bar.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/text_input.dart';

class CreateOrganisationView extends ConsumerStatefulWidget {
  const CreateOrganisationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateOrganisationViewState();
}

class _CreateOrganisationViewState
    extends ConsumerState<CreateOrganisationView> {
  final TextEditingController _orgNameController = TextEditingController();

  @override
  void dispose() {
    _orgNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isProfileLoading = ref.watch(userProfileControllerProvider);
    bool isOrgLoading = ref.watch(organisationControllerProvider);
    UserModel user = ref.watch(userProvider)!;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      extendBodyBehindAppBar: true,
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
              child: isProfileLoading || isOrgLoading
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
                                text: '${user.nickName}, ',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: user.createdAtLeastOneOrg == true
                                    ? 'create your new organisation'
                                    : 'create your first organisation',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
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
                          hintText: 'e.g New Tech',
                          inputTitle: 'Give it a name at least',
                          controller: _orgNameController,
                        ),
                        40.hSpace,
                        BButton(
                          width: 200,
                          height: 50,
                          onTap: () {
                            if (_orgNameController.text.length > 5) {
                              List<dynamic> updatedOrganisations =
                                  List.from(user.organisationsCreated!);
                              updatedOrganisations
                                  .add(_orgNameController.text.trim());
                              ref
                                  .read(userProfileControllerProvider.notifier)
                                  .editUserProfile(
                                    context: context,
                                    user: user.copyWith(
                                      createdAtLeastOneOrg: true,
                                      organisationsCreated:
                                          updatedOrganisations,
                                    ),
                                  );
                              ref
                                  .read(organisationControllerProvider.notifier)
                                  .createOrganisation(
                                    name: _orgNameController.text.trim(),
                                    context: context,
                                  );

                              if (user.createdAtLeastOneOrg == true) {
                                ref
                                    .refresh(getUserCreatedOrgsProviderFuture)
                                    .whenData((value) {
                                  Timer(const Duration(milliseconds: 1000), () {
                                    goBack(context);
                                  });
                                });
                              }
                            } else {
                              showSnackBar(
                                  context: context,
                                  text:
                                      'Your organisation name should be between 5-10 letters, with no numbers or symbols');
                            }
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
