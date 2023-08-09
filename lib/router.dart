import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:traq/features/auth/views/login_view.dart';
import 'package:traq/features/base_nav/views/base_nav_view.dart';
import 'package:traq/shared/app_routes.dart';

//!logged out routes
RouteMap loggedOutRoute = RouteMap(routes: {
  AppRoutes.base: (_) => const MaterialPage(child: LoginView()),
});


//!logged in routes
RouteMap loggedInRoute = RouteMap(
  routes: {
    AppRoutes.base: (_) => const MaterialPage(
          child: BaseNavWrapper(),
        ),
    // AppRoutes.settings: (_) => const MaterialPage(
    //       child: SettingsView(),
    //     ),
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
