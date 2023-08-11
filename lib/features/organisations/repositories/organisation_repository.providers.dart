part of 'organisation_repository.dart';

final organisationRepositoryProvider = Provider((ref) {
  return OrganisationRepository(firestore: ref.watch(firestoreProvider));
});