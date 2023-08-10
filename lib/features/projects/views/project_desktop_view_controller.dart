// ignore_for_file: public_member_api_docs, sort_constructors_first
//! the state notifier provider for controlling the state of the base nav wrapper
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/utils/app_extensions.dart';

final projectNavControllerProvider =
    StateNotifierProvider<ProjectNavController, ProjectStuff?>((ref) {
  return ProjectNavController();
});

//! the state notifier class for controlling the state of the base nav wrapper
class ProjectNavController extends StateNotifier<ProjectStuff?> {
  ProjectNavController() : super(null);

  //! move to page
  void moveToPage({required ProjectStuff view}) {
    state = view;
  }

  void removePage() {
    state = null;
  }
}

//! () => move to page
void moveToProjectPage({
  required BuildContext context,
  required WidgetRef ref,
  required ProjectStuff view,
}) {
  ref.read(projectNavControllerProvider.notifier).moveToPage(view: view);
}

void remooveProjectPage({
  required BuildContext context,
  required WidgetRef ref,
}) {
  ref.read(projectNavControllerProvider.notifier).removePage();
}

class ProjectStuff {
  final Widget view;
  final String title;
  const ProjectStuff({
    required this.view,
    required this.title,
  });
}

//!!!
final versionNavControllerProvider =
    StateNotifierProvider<VersionNavController, PageController>((ref) {
  return VersionNavController();
});

//! the state notifier class for controlling the state of the base nav wrapper
class VersionNavController extends StateNotifier<PageController> {
  VersionNavController() : super(PageController());

  //! move to page
  void jumpToPage({required int page}) {
    state.page!.log();
    state.jumpToPage(page);
  }

  void resetVersionPage() {
    state.jumpToPage(0);
  }

  // void removePage() {
  //   state = null;
  // }
}
