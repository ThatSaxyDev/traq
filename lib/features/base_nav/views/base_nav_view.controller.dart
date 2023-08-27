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
  const DashboardMobileView(),
  const ProjectMobileView(),
  Center(
    child: 'wfwe'.txt(size: 12),
  ),
  Center(
    child: 'hq3f2ftgme'.txt(size: 12),
  ),
];

//! nav widget enums
enum Nav {
  dashboard('Dashboard', 'dashboardselmob', 'dashunmob'),
  projects('Projects', 'projselmob', 'projunmob'),
  reports('Reports', 'repselmob', 'repunmob'),
  settings('Settings', 'setunmob', 'setunmob');

  const Nav(
    this.label,
    this.icon,
    this.unselectedicon,
  );
  final String label;
  final String icon;
  final String unselectedicon;
}

List<Nav> nav = [
  Nav.dashboard,
  Nav.projects,
  Nav.reports,
  Nav.settings,
];
