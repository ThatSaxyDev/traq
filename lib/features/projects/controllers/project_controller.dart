import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/core/providers/storage_repository_provider.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/projects/repositories/project_repository.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/snack_bar.dart';
import 'package:uuid/uuid.dart';

part '../controllers/project_controller.providers.dart';

class ProjectController extends StateNotifier<bool> {
  final StorageRepository _storageRepository;
  final ProjectRepository _projectRepository;
  final Ref _ref;
  ProjectController({
    required StorageRepository storageRepository,
    required ProjectRepository projectRepository,
    required Ref ref,
  })  : _projectRepository = projectRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  // create project
  void createProject({
    required OrganisationModel organisation,
    required String name,
    required BuildContext context,
  }) async {
    state = true;
    // String uid = _ref.read(userProvider)?.uid ?? '';
    String projectId = const Uuid().v1();
    ProjectModel project = ProjectModel(
      id: projectId,
      orgName: organisation.name,
      name: name,
      assignedTo: [],
      assignedBy: '',
      versions: [],
    );

    final res = await _projectRepository.createProject(
        organisationId: organisation.id, project: project);
    state = false;
    res.fold(
      (failure) => showSnackBar(context: context, text: failure.message),
      (success) {
        project.name.log();
        _ref.read(toggleOverlayControllerProvider.notifier).toggleOverlay();
      },
    );
  }

  //! get created organisations (stream)
  Stream<List<ProjectModel>> getProjectsForAnOrganisation(
      {required String orgName}) {
    return _projectRepository.getProjectsForAnOrganisation(orgName: orgName);
  }
}
