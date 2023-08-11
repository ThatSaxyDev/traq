import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:traq/core/constants/firebase_constants.dart';
import 'package:traq/core/providers/firebase_provider.dart';
import 'package:traq/core/type_defs.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/utils/failure.dart';
import 'package:traq/core/providers/firebase_provider.dart';

part '../repositories/organisation_repository.providers.dart';

class OrganisationRepository {
  final FirebaseFirestore _firestore;
  OrganisationRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //! getters
  CollectionReference get _organisations =>
      _firestore.collection(FirebaseConstants.organisationsCollection);

  //! create organisation
  FutureVoid createOrganisation(
      {required OrganisationModel organisation}) async {
    try {
      var communityDoc = await _organisations.doc(organisation.name).get();
      if (communityDoc.exists) {
        throw 'Organidation with the same name exists';
      }

      return right(
        _organisations.doc(organisation.name).set(organisation.toMap()),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get created organisations (stream)
  Stream<List<OrganisationModel>> getUserCreatedOrganisations(
      {required String uid}) {
    return _organisations.where('teamLead', arrayContains: uid).snapshots().map(
      (event) {
        List<OrganisationModel> orgs = [];
        for (var doc in event.docs) {
          orgs.add(
              OrganisationModel.fromMap(doc.data() as Map<String, dynamic>));
        }
        return orgs;
      },
    );
  }

  //! get created organisations (future)
  Future<List<OrganisationModel>> getUserCreatedOrganisationsF(
      {required String uid}) async {
    QuerySnapshot snapshot =
        await _organisations.where('teamLead', arrayContains: uid).get();

    List<OrganisationModel> orgs = [];
    for (var doc in snapshot.docs) {
      orgs.add(OrganisationModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return orgs;
  }
}
