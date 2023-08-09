import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/features/base_nav/views/base_nav_view.dart';

//! the state notifier provider for controlling the state of the base nav wrapper
final baseNavDesktopControllerProvider =
    StateNotifierProvider<BaseNavDesktopController, int>((ref) {
  return BaseNavDesktopController();
});

//! the state notifier class for controlling the state of the base nav wrapper
class BaseNavDesktopController extends StateNotifier<int> {
  BaseNavDesktopController() : super(0);

  //! move to page
  void moveToPage({required int index}) {
    state = index;
  }
}

//! () => move to page
// void moveToPage({
//   required BuildContext context,
//   required WidgetRef ref,
//   required int index,
// }) {
//   ref.read(baseNavControllerProvider.notifier).moveToPage(index: index);
//   ref.read(baseNavDesktopControllerProvider.notifier).moveToPage(index: index);
// }
