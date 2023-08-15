// ignore_for_file: public_member_api_docs, sort_constructors_first
//! the state notifier provider for controlling the state of the base nav wrapper
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/models/project_model.dart';
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
  final ProjectModel title;
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

//! the provider for choosing the project color
final projectColorControllerProvider =
    StateNotifierProvider<ProjectColorController, ProjectColor?>((ref) {
  return ProjectColorController();
});

//! the state notitfier class for choosing the car color
class ProjectColorController extends StateNotifier<ProjectColor?> {
  ProjectColorController() : super(null);

  //! SELECT CAR COLOR
  void selectProjectColor({required ProjectColor projectColor}) {
    state = projectColor;
  }

  //! remove color
  void removeProjectColor() {
    state = null;
  }
}

//! () => select car color
void selectProjectColor({
  required BuildContext context,
  required ProjectColor projectColor,
  required WidgetRef ref,
}) {
  ref
      .read(projectColorControllerProvider.notifier)
      .selectProjectColor(projectColor: projectColor);
}

//! () => remove color
void removeProjectColor({
  required BuildContext context,
  required WidgetRef ref,
}) {
  ref.read(projectColorControllerProvider.notifier).removeProjectColor();
}

//! car color enum
enum ProjectColor {
  red('red', Color(0xFFEF4444)),
  orange('orange', Color(0xFFEFAA44)),
  green('green', Color(0xFF22C55E)),
  lightGreen('lightGreen', Color(0xFF22C580)),
  teal('teal', Color(0xFF22A7C5)),
  lightBlue('lightBlue', Color(0xFF2280C5)),
  blue('lightBlue', Color(0xFF294EAB)),
  purple('purple', Color(0xFFAE22C5)),
  violet('violet', Color(0xFFC522A1));

  const ProjectColor(
    this.colorName,
    this.colorMaterial,
  );
  final String colorName;
  final Color colorMaterial;
}

List<ProjectColor> projectColors = [
  ProjectColor.red,
  ProjectColor.orange,
  ProjectColor.green,
  ProjectColor.lightGreen,
  ProjectColor.teal,
  ProjectColor.lightBlue,
  ProjectColor.blue,
  ProjectColor.purple,
  ProjectColor.violet,
];

final toggleOverlayControllerProvider =
    StateNotifierProvider<ToggleOverlayController, bool>((ref) {
  return ToggleOverlayController();
});

//! the state notitfier class for toggling the overlay
class ToggleOverlayController extends StateNotifier<bool> {
  ToggleOverlayController() : super(false);

  //! toggleOverlay
  void toggleOverlay() {
    state = !state;
  }
}

//! () => toggleOverlay
void toggleOverlay({
  required BuildContext context,
  required WidgetRef ref,
}) {
  ref.read(toggleOverlayControllerProvider.notifier).toggleOverlay();
}
