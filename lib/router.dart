import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/auth/views/login_view.dart';
import 'package:traq/features/base_nav/views/base_nav_view.dart';
import 'package:traq/features/organisations/views/create_organisation_view.dart';
import 'package:traq/features/profile/views/choose_user_type.dart';
import 'package:traq/features/profile/views/nickname_input_view.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/shared/app_routes.dart';

//!logged out routes
RouteMap loggedOutRoute = RouteMap(routes: {
  AppRoutes.base: (_) => const MaterialPage(child: LoginView()),
});

//!logged in routes
RouteMap loggedInRoute = RouteMap(
  routes: {
    AppRoutes.base: (_) => MaterialPage(
          child: Consumer(
            builder: (context, ref, child) {
              UserModel user = ref.watch(userProvider)!;

              if (user.nickName!.isEmpty) {
                return const NickNameInputView();
              } else if (user.isUserTypePicked == false) {
                return const ChooseUserType();
              } else if (user.organisationsCreated!.isEmpty &&
                  user.isTeamLead == true) {
                return const CreateOrganisationView();
              } else {
                return const BaseNavWrapper();
              }
            },
          ),
        ),
    AppRoutes.createOrg: (_) => const MaterialPage(
          child: CreateOrganisationView(),
        ),
    AppRoutes.baseNav: (_) => const MaterialPage(
          child: BaseNavWrapper(),
        ),
    // '/profile/:userId': (routeData) => MaterialPage(
    //       child: OtherUserProfileView(
    //         userId: routeData.pathParameters['userId']!,
    //       ),
    //     ),
    // '/post/:postId': (routeData) => MaterialPage(
    //       child: PostView(
    //         postId: routeData.pathParameters['postId']!,
    //       ),
    //     ),
    // '/approval-status': (_) => const MaterialPage(
    //       child: AppprovalStatusView(),
    //     ),
    // '/add-post/:from': (routeData) => MaterialPage(
    //       child: AddPostView(
    //         isFromCommunity: routeData.pathParameters['from']!,
    //       ),
    //     ),
    // '/bookmarks': (routeData) => const MaterialPage(
    //       child: BookmarksView(),
    //     ),
    // // '/create-community': (_) => const MaterialPage(
    // //       child: CreateCommunityScreen(),
    // //     ),
    // '/com/:name': (route) => MaterialPage(
    //       child: CommnunityProfileView(
    //         name: route.pathParameters['name']!,
    //       ),
    //     ),
    // '/com/:name/community-settings/:name': (routeDate) => MaterialPage(
    //       child: CommunitySettingsView(
    //         name: routeDate.pathParameters['name']!,
    //       ),
    //     ),
    // '/com/:name/community-settings/:name/edit-community/:name': (routeData) =>
    //     MaterialPage(
    //       child: EditCommunityView(
    //         name: routeData.pathParameters['name']!,
    //       ),
    //     ),
    // '/com/:name/community-settings/:name/add-mods/:name': (routeData) =>
    //     MaterialPage(
    //       child: AddModsView(
    //         name: routeData.pathParameters['name']!,
    //       ),
    //     ),
    // '/image/:url': (routeData) => MaterialPage(
    //       child: ImageView(
    //         imageUrl: routeData.pathParameters['url']!,
    //       ),
    //     ),
    // '/edit-profile': (routeData) => const MaterialPage(
    //       child: EditProfileView(),
    //     ),
  },
);
