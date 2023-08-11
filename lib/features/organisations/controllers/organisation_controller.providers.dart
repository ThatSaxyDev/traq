part of 'organisation_controller.dart';

final organisationControllerProvider =
    StateNotifierProvider<OrganisationController, bool>((ref) {
  final organisationRepository = ref.watch(organisationRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return OrganisationController(
    storageRepository: storageRepository,
    ref: ref,
    organisationRepository: organisationRepository,
  );
});

//! provider for getting user created orgs (stream)
AutoDisposeStreamProvider<List<OrganisationModel>> getUserCreatedOrgsProvider =
    StreamProvider.autoDispose((ref) {
  final organisationController =
      ref.watch(organisationControllerProvider.notifier);
  return organisationController.getUserCreatedOrganisations();
});

//! provider for getting user created orgs (future)
FutureProvider<List<OrganisationModel>> getUserCreatedOrgsProviderFuture =
    FutureProvider((ref) {
  final organisationController =
      ref.watch(organisationControllerProvider.notifier);
  return organisationController.getUserCreatedOrganisationsF();
});

final orgModelStateControllerProvider =
    StateNotifierProvider<OrgModelStateController, OrganisationModel?>((ref) {
  final organisationRepository = ref.watch(organisationRepositoryProvider);
  return OrgModelStateController(
    organisationRepository: organisationRepository,
    ref: ref,
  );
});

final orgModelStateProvider = StateProvider<OrganisationModel?>((ref) => null);
