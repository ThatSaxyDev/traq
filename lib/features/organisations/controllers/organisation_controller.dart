import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/core/providers/storage_repository_provider.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/organisations/repositories/organisation_repository.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/snack_bar.dart';

part '../controllers/organisation_controller.providers.dart';

class OrganisationController extends StateNotifier<bool> {
  final StorageRepository _storageRepository;
  final OrganisationRepository _organisationRepository;
  final Ref _ref;
  OrganisationController({
    required StorageRepository storageRepository,
    required OrganisationRepository organisationRepository,
    required Ref ref,
  })  : _organisationRepository = organisationRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  // create community
  void createOrganisation({
    required String name,
    required BuildContext context,
  }) async {
    state = true;
    String uid = _ref.read(userProvider)?.uid ?? '';
    OrganisationModel org = OrganisationModel(
      id: name,
      name: name,
      orgImage: '',
      projects: [],
      teamMembers: [],
      teamLead: [uid],
      createdAt: DateTime.now(),
    );

    final res =
        await _organisationRepository.createOrganisation(organisation: org);
    state = false;
    res.fold(
      (failure) => showSnackBar(context: context, text: failure.message),
      (success) {
        org.name.log();
      },
    );
  }

  //! get created organisations (stream)
  Stream<List<OrganisationModel>> getUserCreatedOrganisations() {
    String uid = _ref.read(userProvider)!.uid!;
    return _organisationRepository.getUserCreatedOrganisations(uid: uid);
  }

  //! get created organisations (future)
  Future<List<OrganisationModel>> getUserCreatedOrganisationsF() {
    String uid = _ref.read(userProvider)!.uid!;
    return _organisationRepository.getUserCreatedOrganisationsF(uid: uid);
  }
}

//! organisation model state
class OrgModelStateController extends StateNotifier<OrganisationModel?> {
  final OrganisationRepository _organisationRepository;
  final Ref _ref;
  OrgModelStateController({
    required OrganisationRepository organisationRepository,
    required Ref ref,
  })  : _organisationRepository = organisationRepository,
        _ref = ref,
        super(null);

  //! fix an organisation in state
  void fixAnOrgInState({required OrganisationModel organisation}) async {
    state = organisation;
  }
}
