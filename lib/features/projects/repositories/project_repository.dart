import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:traq/core/constants/firebase_constants.dart';
import 'package:traq/core/providers/firebase_provider.dart';
import 'package:traq/core/type_defs.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/utils/failure.dart';

part '../repositories/project_repository.providers.dart';

class ProjectRepository {
  final FirebaseFirestore _firestore;
  ProjectRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! getters
  CollectionReference get _organisations =>
      _firestore.collection(FirebaseConstants.organisationsCollection);

  CollectionReference get _projects =>
      _firestore.collection(FirebaseConstants.projectsCollection);

  //! create project
  FutureVoid createProject({
    required String organisationId,
    required ProjectModel project,
  }) async {
    try {
      var projectDoc = await _projects.doc(project.name).get();
      if (projectDoc.exists) {
        throw 'Project with the same name exists';
      }
      _organisations.doc(organisationId).update({
        'projects': FieldValue.arrayUnion([project.id]),
      });
      return right(
        _projects.doc(project.name).set(project.toMap()),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get projects for an organisation
  Stream<List<ProjectModel>> getProjectsForAnOrganisation(
      {required String orgName}) {
    return _projects.where('orgName', isEqualTo: orgName).snapshots().map(
      (event) {
        List<ProjectModel> orgs = [];
        for (var doc in event.docs) {
          orgs.add(ProjectModel.fromMap(doc.data() as Map<String, dynamic>));
        }
        return orgs;
      },
    );
  }

  //! get created organisations (future)
  Future<List<ProjectModel>> getUserCreatedProjectF(
      {required String uid}) async {
    QuerySnapshot snapshot =
        await _organisations.where('teamLead', arrayContains: uid).get();

    List<ProjectModel> orgs = [];
    for (var doc in snapshot.docs) {
      orgs.add(ProjectModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return orgs;
  }
}
