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

//! GET PROJECT BY NAME
final getProjectByNameProvider =
    StreamProvider.family((ref, String projectName) {
  final projectController = ref.watch(projectControllerProvider.notifier);

  return projectController.getProjectByName(projectName: projectName);
});

//! get VERSIONS FOR A PROJECT Provider
final getVersionsForAProjectProvider =
    StreamProvider.family((ref, String projectId) {
  final projectController = ref.watch(projectControllerProvider.notifier);

  return projectController.getVersionsForAProject(projectId: projectId);
});

//! GET VERSION BY ID
final getVersionByIdProvider = StreamProvider.family((ref, String versionId) {
  final projectController = ref.watch(projectControllerProvider.notifier);

  return projectController.getVersionById(versionId: versionId);
});

final projectModelStateProvider = StateProvider<ProjectModel?>((ref) => null);
