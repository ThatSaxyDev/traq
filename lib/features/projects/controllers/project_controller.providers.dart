part of 'project_controller.dart';

final projectControllerProvider =
    StateNotifierProvider<ProjectController, bool>((ref) {
  final projectRepository = ref.watch(projectRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ProjectController(
    storageRepository: storageRepository,
    ref: ref,
    projectRepository: projectRepository,
  );
});

//! get Projects For An Organisation Provider
final getProjectsForAnOrganisationProvider =
    StreamProvider.family((ref, String orgName) {
  final projectController = ref.watch(projectControllerProvider.notifier);

  return projectController.getProjectsForAnOrganisation(orgName: orgName);
});
