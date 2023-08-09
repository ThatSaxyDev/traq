part of 'base_nav_view.dart';

//! the state notifier provider for controlling the state of the base nav wrapper
final baseNavControllerProvider =
    StateNotifierProvider<BaseNavController, int>((ref) {
  return BaseNavController();
});

//! the state notifier class for controlling the state of the base nav wrapper
class BaseNavController extends StateNotifier<int> {
  BaseNavController() : super(0);

  //! move to page
  void moveToPage({required int index}) {
    state = index;
  }
}

//! () => move to page
void moveToPage({
  required BuildContext context,
  required WidgetRef ref,
  required int index,
}) {
  ref.read(baseNavControllerProvider.notifier).moveToPage(index: index);
  ref.read(baseNavDesktopControllerProvider.notifier).moveToPage(index: index);
}

//! List of pages
List<Widget> pages = [
  Center(
    child: 'home'.txt(size: 12),
  ),
  Center(
    child: 'zz'.txt(size: 12),
  ),
  Center(
    child: 'wfwe'.txt(size: 12),
  ),
  Center(
    child: 'hq3f2ftgme'.txt(size: 12),
  ),
];

//! nav widget enums
enum Nav {
  home(PhosphorIcons.houseSimple, PhosphorIcons.houseSimpleFill),
  search(PhosphorIcons.magnifyingGlass, PhosphorIcons.magnifyingGlass),
  // stream(PhosphorIcons.pen, PhosphorIcons.pen),
  notification(PhosphorIcons.notification, PhosphorIcons.notificationFill),
  profile(PhosphorIcons.user, PhosphorIcons.userFill);

  const Nav(
    this.icon,
    this.selectedIcon,
  );
  final IconData icon;
  final IconData selectedIcon;
}

List<Nav> nav = [
  Nav.home,
  Nav.search,
  // Nav.stream,
  Nav.notification,
  Nav.profile,
];
