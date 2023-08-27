part of 'reports_controller.dart';

final reportsControllerProvider =
    StateNotifierProvider<ReportsController, bool>((ref) {
  final reportsRepository = ref.watch(reportsRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ReportsController(
    storageRepository: storageRepository,
    ref: ref,
    reportsRepository: reportsRepository,
  );
});

// final versionModelStateProvider = StateProvider<VersionModel?>((ref) => null);

final versionModelStateControllerProvider =
    StateNotifierProvider<VersionModelStateController, VersionModel>((ref) {
  return VersionModelStateController();
});

//! get all bugs for a version provider
final getAllBugsForAVersionProvider = StreamProvider.autoDispose((ref) {
  final reportsController = ref.watch(reportsControllerProvider.notifier);
  return reportsController.getAllBugsForAVersion();
});

//! get all bugs for a version provider
final getAllBugsForAnOrganisationProvider =
    StreamProvider.autoDispose.family((ref, String status) {
  final reportsController = ref.watch(reportsControllerProvider.notifier);
  return reportsController.getAllBugsForAnOrganisation(status: status);
});

final getAllUnsolvedBugsForAnOrganisationProvider =
    StreamProvider.autoDispose.family((ref, String status) {
  final reportsController = ref.watch(reportsControllerProvider.notifier);
  return reportsController.getAllUnsolvedBugsForAnOrganisation(status: status);
});

//! get all comments for a bug
final getAllCommentsForaBugProvider =
    StreamProvider.autoDispose.family((ref, String bugId) {
  final reportsController = ref.watch(reportsControllerProvider.notifier);
  return reportsController.getAllCommentsForaBug(bugId: bugId);
});

//! GET bug BY ID
final getBugByIdProvider = StreamProvider.family((ref, String bugId) {
  final reportsController = ref.watch(reportsControllerProvider.notifier);

  return reportsController.getBugById(bugId: bugId);
});
