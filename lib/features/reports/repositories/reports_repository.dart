import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:traq/core/constants/firebase_constants.dart';
import 'package:traq/core/providers/firebase_provider.dart';
import 'package:traq/core/type_defs.dart';
import 'package:traq/models/bug_model.dart';
import 'package:traq/models/comment_model.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/models/version_model.dart';
import 'package:traq/utils/failure.dart';

part '../repositories/reports_repository.providers.dart';

class ReportsRepository {
  final FirebaseFirestore _firestore;
  ReportsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _bugs =>
      _firestore.collection(FirebaseConstants.bugsCollection);

  CollectionReference get _versions =>
      _firestore.collection(FirebaseConstants.versionsCollection);

  CollectionReference get _comments =>
      _firestore.collection(FirebaseConstants.commentsCollection);

  //! report a bug
  FutureVoid reportBug({
    required VersionModel version,
    required BugModel bug,
  }) async {
    try {
      // var versionDoc = await _projects.doc(version.id).get();
      // if (versionDoc.exists) {
      //   throw 'Version with the same name exists';
      // }
      _versions.doc(version.name).update({
        'unsolvedBugs': FieldValue.arrayUnion([bug.id]),
      });
      return right(_bugs.doc(bug.id).set(bug.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get all bugs for a version
  Stream<List<BugModel>> getAllBugsForAVersion({required String versionName}) {
    return _bugs
        .orderBy('updatedAt', descending: true)
        .where('version', isEqualTo: versionName)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => BugModel.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  //! get all bugs for a organisation
  Stream<List<BugModel>> getAllBugsForAOrganisation({required String orgName}) {
    return _bugs
        .orderBy('updatedAt', descending: true)
        .where('orgName', isEqualTo: orgName)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => BugModel.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  Stream<List<BugModel>> getAllBugsForAVersionB({
    required String orgName,
    String? status,
    required bool isSolved,
  }) {
    Query query = _bugs.where('orgName', isEqualTo: orgName);

    if (status != null) {
      if (isSolved == true) {
        query = query.where('status', isEqualTo: status);
      } else {
        query = query
            .where('status', whereIn: ['unsolved', 'in progress', 'in review']);
      }
    }

    query = query.orderBy('updatedAt', descending: true);

    return query.snapshots().map((event) => event.docs
        .map(
          (e) => BugModel.fromMap(e.data() as Map<String, dynamic>),
        )
        .toList());
  }

  //! edit bug
  FutureVoid editBug({required BugModel bug}) async {
    try {
      return right(_bugs.doc(bug.id).update(bug.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get all comments for a bug
  Stream<List<Comment>> getAllCommentsForaBug({required String bugId}) {
    return _comments
        .orderBy('createdAt', descending: true)
        .where('bugId', isEqualTo: bugId)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => Comment.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  //! comment
  FutureVoid comment({
    required BugModel bug,
    required Comment comment,
  }) async {
    try {
      // var versionDoc = await _projects.doc(version.id).get();
      // if (versionDoc.exists) {
      //   throw 'Version with the same name exists';
      // }
      _bugs.doc(bug.id).update({
        'comments': FieldValue.arrayUnion([comment.id]),
      });
      return right(_comments.doc(comment.id).set(comment.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteComment({
    required BugModel bug,
    required Comment comment,
  }) async {
    try {
      // var versionDoc = await _projects.doc(version.id).get();
      // if (versionDoc.exists) {
      //   throw 'Version with the same name exists';
      // }
      _bugs.doc(bug.id).update({
        'comments': FieldValue.arrayRemove([comment.id]),
      });
      return right(_comments.doc(comment.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! update bug unsolved
  FutureVoid updateBugStatusUbsolved({required BugModel bug}) async {
    try {
      _versions.doc(bug.version).update({
        'unsolvedBugs': FieldValue.arrayUnion([bug.id]),
        'inProgressBugs': FieldValue.arrayRemove([bug.id]),
        'inReviewBugs': FieldValue.arrayRemove([bug.id]),
        'resolvedBugs': FieldValue.arrayRemove([bug.id]),
      });
      return right(_bugs.doc(bug.id).update(bug.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! update bug in review
  FutureVoid updateBugStatusInReview({required BugModel bug}) async {
    try {
      _versions.doc(bug.version).update({
        'unsolvedBugs': FieldValue.arrayRemove([bug.id]),
        'inProgressBugs': FieldValue.arrayRemove([bug.id]),
        'inReviewBugs': FieldValue.arrayUnion([bug.id]),
        'resolvedBugs': FieldValue.arrayRemove([bug.id]),
      });
      return right(_bugs.doc(bug.id).update(bug.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! update bug in progress
  FutureVoid updateBugStatusInProgress({required BugModel bug}) async {
    try {
      _versions.doc(bug.version).update({
        'unsolvedBugs': FieldValue.arrayRemove([bug.id]),
        'inProgressBugs': FieldValue.arrayUnion([bug.id]),
        'inReviewBugs': FieldValue.arrayRemove([bug.id]),
        'resolvedBugs': FieldValue.arrayRemove([bug.id]),
      });
      return right(_bugs.doc(bug.id).update(bug.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! update bug solved
  FutureVoid updateBugStatusSolved({required BugModel bug}) async {
    try {
      _versions.doc(bug.version).update({
        'unsolvedBugs': FieldValue.arrayRemove([bug.id]),
        'inProgressBugs': FieldValue.arrayRemove([bug.id]),
        'inReviewBugs': FieldValue.arrayRemove([bug.id]),
        'resolvedBugs': FieldValue.arrayUnion([bug.id]),
      });
      return right(_bugs.doc(bug.id).update(bug.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get a bug by id
  Stream<BugModel> getBugById({required String bugId}) {
    return _bugs
        .doc(bugId)
        .snapshots()
        .map((event) => BugModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
