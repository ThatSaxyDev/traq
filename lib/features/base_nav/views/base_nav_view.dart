// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:traq/features/base_nav/widgets/base_nav_view.desktopcontroller.dart';
import 'package:traq/features/base_nav/widgets/nav_bar_widget.dart';
import 'package:traq/features/base_nav/widgets/search_bar.dart';
import 'package:traq/features/base_nav/widgets/side_nav.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/responsize/screen_type_layout.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/button.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/myicon.dart';

part '../views/base_nav_view.controller.dart';

class BaseNavWrapper extends ConsumerStatefulWidget {
  const BaseNavWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseNavWrapperState();
}

class _BaseNavWrapperState extends ConsumerState<BaseNavWrapper> {
  List<OrganisationModel> organisations = [];

  @override
  Widget build(BuildContext context) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    ProjectStuff? projectPageFromController =
        ref.watch(projectNavControllerProvider);
    int indexFromDesktopController =
        ref.watch(baseNavDesktopControllerProvider);
    // OrganisationModel? orgFromProvider = ref.watch(orgModelStateProvider);
    AsyncValue<List<OrganisationModel>> asyncListofCreatedOrganisations =
        ref.watch(getUserCreatedOrgsProviderFuture);

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
            body: pages[indexFromController],

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
            body: SizedBox(
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
                                        const CircleAvatar(
                                          radius: 24,
                                        ),
                                        8.wSpace,

                                        //! user name
                                        'User Name'
                                            .txt16(fontWeight: FontWeight.w500),
                                        const MyIcon(icon: 'arrowdown'),
                                        32.wSpace,

                                        //! create button
                                        BButton(
                                          width: 135,
                                          onTap: () {},
                                          isText: false,
                                          item: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              'Create'.txt14(
                                                fontWeight: FontWeight.w500,
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
                                        projectPageFromController == null) {
                                      true => deskTopPages[
                                          indexFromDesktopController],
                                      false => projectPageFromController!.view
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
        // if (imageOverlay != null) ImageOverLay(imageUrl: imageOverlay),
      ],
    );
  }
}
