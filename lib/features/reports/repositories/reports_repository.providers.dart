part of 'reports_repository.dart';

final reportsRepositoryProvider = Provider((ref) {
  return ReportsRepository(firestore: ref.watch(firestoreProvider));
});