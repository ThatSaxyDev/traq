part of 'project_repository.dart';

final projectRepositoryProvider = Provider((ref) {
  return ProjectRepository(firestore: ref.watch(firestoreProvider));
});