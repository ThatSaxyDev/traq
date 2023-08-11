// ignore_for_file: deprecated_member_use

import 'package:animate_to/animate_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass/glass.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:routemaster/routemaster.dart';
import 'package:simple_notifier/simple_notifier.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/base_nav/widgets/base_nav_view.desktopcontroller.dart';
import 'package:traq/features/base_nav/widgets/nav_bar_widget.dart';
import 'package:traq/features/base_nav/widgets/search_bar.dart';
import 'package:traq/features/base_nav/widgets/side_nav.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/responsize/screen_type_layout.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/nav.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/myicon.dart';
import 'package:traq/utils/widgets/text_input.dart';

part '../views/base_nav_view.controller.dart';

class BaseNavWrapper extends ConsumerStatefulWidget {
  const BaseNavWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseNavWrapperState();
}

class _BaseNavWrapperState extends ConsumerState<BaseNavWrapper> {
  final TextEditingController _projectNameController = TextEditingController();
  List<OrganisationModel> organisations = [];
  final _animateToController = AnimateToController();
  ValueNotifier colorError = false.notifier;
  Color? targetColor;

  List<String> choices = <String>[
    'Log Out',
  ];

  @override
  void dispose() {
    _projectNameController.dispose();
    _animateToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);
    UserModel? user = ref.watch(userProvider);
    int indexFromController = ref.watch(baseNavControllerProvider);
    ProjectStuff? projectPageFromController =
        ref.watch(projectNavControllerProvider);
    int indexFromDesktopController =
        ref.watch(baseNavDesktopControllerProvider);
    bool createProjectOpen = ref.watch(toggleOverlayControllerProvider);
    AsyncValue<List<OrganisationModel>> asyncListofCreatedOrganisations =
        ref.watch(getUserCreatedOrgsProviderFuture);
    ProjectColor? projectColor = ref.watch(projectColorControllerProvider);

    asyncListofCreatedOrganisations.when(
      data: (data) {
        organisations = data;
        Future(
          () {
            ref
                .read(orgModelStateControllerProvider.notifier)
                .fixAnOrgInState(organisation: data[0]);
          },
        );
      },
      error: (error, stackTrace) {
        error.toString().log();
      },
      loading: () {},
    );

    // String? imageOverlay = ref.watch(imageOverlayControllerProvider);
    return Stack(
      children: [
        ScreenTypeLayoutWrapper(
          //! mobile layout
          mobile: Scaffold(
            backgroundColor: Pallete.whiteColor,
            // pages
            body: user == null
                ? const Loadinggg(height: 40)
                : pages[indexFromController],

            // nav bar
            bottomNavigationBar: Material(
              elevation: 5,
              child: Container(
                color: Pallete.whiteColor,
                padding: const EdgeInsets.only(top: 17, left: 17, right: 17),
                height: 80,
                width: width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    nav.length,
                    (index) => NavBarWidget(nav: nav[index]),
                  ),
                ),
              ),
            ),
          ),

          //! dsektop view
          desktop: Scaffold(
            backgroundColor: Pallete.whiteColor,
            body: user == null
                ? const Loadinggg(height: 40)
                : SizedBox(
                    height: height(context),
                    width: width(context),
                    child: organisations.isEmpty
                        ? const Loadinggg(
                            height: 40,
                          )
                        : Row(
                            children: [
                              //! side nav
                              const SideNav(),

                              //! body
                              Expanded(
                                flex: 6,
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 0.50,
                                                color: Color(0xFFE5E7EB),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              40.wSpace,
                                              //! search
                                              const SearchBarr(),
                                              const Spacer(),

                                              //! notifications
                                              const MyIcon(icon: 'notif'),
                                              32.wSpace,

                                              //! profile image
                                              CircleAvatar(
                                                radius: 24,
                                                backgroundImage: NetworkImage(
                                                    user.profilePic!),
                                              ),
                                              8.wSpace,

                                              //! user name
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  user.name!.txt16(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  user.nickName!.txt12(
                                                    fontWeight: FontWeight.w700,
                                                    isheader: true,
                                                  ),
                                                ],
                                              ),
                                              10.wSpace,
                                              PopupMenuButton<String>(
                                                onSelected: (value) =>
                                                    switch (value) {
                                                  'Log Out' => ref
                                                      .read(
                                                          authControllerProvider
                                                              .notifier)
                                                      .logOut(),
                                                  _ => null,
                                                },
                                                tooltip: 'Menu',
                                                icon: const MyIcon(
                                                    icon: 'arrowdown'),
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return choices
                                                      .map((String choice) {
                                                    return PopupMenuItem<
                                                        String>(
                                                      value: choice,
                                                      child: Text(choice),
                                                    );
                                                  }).toList();
                                                },
                                              ),
                                              32.wSpace,

                                              //! create button
                                              BButton(
                                                width: 135,
                                                onTap: () {
                                                  toggleOverlay(
                                                      context: context,
                                                      ref: ref);
                                                },
                                                isText: false,
                                                item: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    'Create'.txt14(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Pallete.whiteColor,
                                                    ),
                                                    8.wSpace,
                                                    const MyIcon(
                                                      icon: 'plus',
                                                      height: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              40.wSpace,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 8,
                                          child: switch (
                                              projectPageFromController ==
                                                  null) {
                                            true => deskTopPages[
                                                indexFromDesktopController],
                                            false =>
                                              projectPageFromController!.view
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
          ),
        ),

        //!
        //! drop down overlay
        if (createProjectOpen == true)
          Material(
            elevation: 0,
            color: Colors.transparent,
            child: SizedBox(
              height: height(context),
              width: width(context),
              child: Center(
                child: Container(
                  height: height(context) * 0.45,
                  width: width(context) * 0.39,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Pallete.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            'Create new project'.txt(
                              isheader: true,
                              size: 32,
                              fontWeight: FontWeight.w600,
                            ),

                            //! close
                            MyIcon(
                              icon: 'x',
                              height: 24,
                              onTap: () {
                                _projectNameController.clear();
                                toggleOverlay(context: context, ref: ref);
                                removeProjectColor(context: context, ref: ref);
                              },
                            ),
                          ],
                        ),
                        24.hSpace,

                        //! project input
                        TextInputWidget(
                          autofocus: true,
                          hintText: 'e.g Bugzy',
                          inputTitle: 'Enter project name',
                          controller: _projectNameController,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              colorError.value = false;
                            }
                          },
                        ),
                        16.hSpace,

                        //! pick color
                        Row(
                          children: [
                            'Project color'.txt14(),
                            10.wSpace,
                            colorError.listen(
                              builder: (context, value, child) =>
                                  switch (value) {
                                true =>
                                  'Please type the project name and pick a color'
                                      .txt12(color: Pallete.thickRed),
                                false => ''.txt(),
                                _ => ''.txt(),
                              },
                            )
                          ],
                        ),
                        8.hSpace,

                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: List.generate(
                            projectColors.length,
                            (index) => Container(
                              width: 40,
                              height: 40,
                              decoration: ShapeDecoration(
                                color: projectColors[index].colorMaterial,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ).tap(
                              onTap: () {
                                selectProjectColor(
                                  context: context,
                                  projectColor: projectColors[index],
                                  ref: ref,
                                );
                                colorError.value = false;
                              },
                            ),
                          ),
                        ).alignCenterLeft(),
                        30.hSpace,

                        //! buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //! cancel
                            TransparentButton(
                              width: 255,
                              onTap: () {},
                              text: 'Cancel',
                            ),

                            //! create
                            BButton(
                              width: 255,
                              color: switch (projectColor == null) {
                                true => null,
                                false => projectColor!.colorMaterial
                              },
                              onTap: () {
                                if (projectColor == null ||
                                    _projectNameController.text.isEmpty) {
                                  colorError.value = true;
                                }
                              },
                              text: 'Create Project',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ).fadeInFromBottom(
                  delay: 100.ms,
                  animatiomDuration: 100.ms,
                ),
              ),
            )
                .asGlass(
                  tintColor: Pallete.blackTint.withOpacity(0.2),
                  blurX: 5,
                  blurY: 5,
                )
                .fadeIn(delay: 0.ms, animatiomDuration: 100.ms),
          ),
      ],
    );
  }
}
