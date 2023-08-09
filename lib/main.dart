import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:routemaster/routemaster.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/firebase_options.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/router.dart';
import 'package:traq/shared/app_texts.dart';
import 'package:traq/utils/error_text.dart';
import 'package:traq/utils/loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: Traq()));
}

class Traq extends ConsumerStatefulWidget {
  const Traq({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TraqState();
}

class _TraqState extends ConsumerState<Traq> {
  UserModel? userModel;

  void getData({required WidgetRef ref, required User data}) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(uid: data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (User? userData) => ResponsiveApp(builder: (context) {
            return MaterialApp.router(
              title: AppTexts.appName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: AppTexts.appFont,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) {
                  if (userData != null) {
                    getData(ref: ref, data: userData);
                    if (userModel != null) {
                      return loggedInRoute;
                    }
                  }
                  return loggedInRoute;
                },
              ),
              routeInformationParser: const RoutemasterParser(),
            );
          }),
          // ScreenUtilInit(
          //   designSize: const Size(375, 812),
          //   minTextAdapt: true,
          //   splitScreenMode: false,
          //   builder: (context, child) {
          //     return Builder(
          //       builder: (context) {
          //         return MaterialApp.router(
          //           title: AppTexts.appName,
          //           debugShowCheckedModeBanner: false,
          //           theme: Pallete.darkModeAppTheme,
          //           routerDelegate: RoutemasterDelegate(
          //             routesBuilder: (context) {
          //               if (userData != null) {
          //                 getData(ref: ref, data: userData);
          //                 if (userModel != null) {
          //                   return loggedInRoute;
          //                 }
          //               }
          //               return loggedOutRoute;
          //             },
          //           ),
          //           routeInformationParser: const RoutemasterParser(),
          //         );
          //       },
          //     );
          //   },
          // ),
          error: (error, stactrace) => MaterialApp(
              home: Scaffold(body: ErrorText(error: error.toString()))),
          loading: () => const MaterialApp(
            home: Scaffold(
              body: Loadinggg(
                height: 30,
              ),
            ),
          ),
        );
  }
}
