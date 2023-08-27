import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:traq/core/providers/storage_repository_provider.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/features/reports/repositories/reports_repository.dart';
import 'package:traq/models/bug_model.dart';
import 'package:traq/models/comment_model.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/models/version_model.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/failure.dart';
import 'package:traq/utils/snack_bar.dart';
import 'package:uuid/uuid.dart';

part '../controllers/reports_controller.providers.dart';

class ReportsController extends StateNotifier<bool> {
  final StorageRepository _storageRepository;
  final ReportsRepository _reportsRepository;
  final Ref _ref;
  ReportsController({
    required StorageRepository storageRepository,
    required ReportsRepository reportsRepository,
    required Ref ref,
  })  : _reportsRepository = reportsRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  //! report a bug
  void reportBug({
    required BuildContext context,
    required VersionModel version,
    required String bugName,
    required String priority,
    required String platformDevice,
    required String description,
    required String steps,
    required File? image,
    Uint8List? file,
    required void Function()? sideEffect,
  }) async {
    state = true;
    String uud = const Uuid().v4();
    UserModel user = _ref.read(userProvider)!;
    String bugId = 'Bug -${version.name} -$uud';
    String photo = '';
    if (image != null) {
      Either<Failure, String> res = await _storageRepository.storeFile(
        path: 'bugs/${version.orgName}',
        id: bugId,
        file: image,
        webFile: file,
      );
      res.fold(
        (l) => showSnackBar(context: context, text: l.message),
        (r) => photo = r,
      );
    }

    final BugModel bug = BugModel(
      id: bugId,
      bugName: bugName,
      imageUrl: photo,
      projectName: version.projectName,
      orgName: version.orgName,
      status: 'unsolved',
      priority: priority,
      assignedBy: user.nickName!,
      updatedBy: '',
      platformDevice: platformDevice,
      version: version.name,
      assignedTo: [],
      description: description,
      steps: steps,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      comments: [],
    );

    Either<Failure, void> res =
        await _reportsRepository.reportBug(version: version, bug: bug);

    state = false;
    res.fold(
      (l) => showSnackBar(context: context, text: l.message),
      (r) {
        sideEffect!.call();
      },
    );
  }

  //! get all comments for a bug
  Stream<List<Comment>> getAllCommentsForaBug({required String bugId}) {
    return _reportsRepository.getAllCommentsForaBug(bugId: bugId);
  }

  //! comment on a bug
  void comment({
    required BuildContext context,
    required BugModel bug,
    required String content,
    required void Function()? sideEffect,
  }) async {
    state = true;
    String commentId = const Uuid().v4();
    UserModel? user = _ref.read(userProvider);
    final Comment comment = Comment(
      id: commentId,
      content: content,
      createdAt: DateTime.now(),
      bugId: bug.id,
      userId: user!.uid!,
      userName: user.name!,
      mentionUserIds: [],
      userImage: user.profilePic!,
    );

    Either<Failure, void> res =
        await _reportsRepository.comment(bug: bug, comment: comment);

    state = false;
    res.fold(
      (l) => showSnackBar(context: context, text: l.message),
      (r) {
        sideEffect!.call();
      },
    );
  }

  void deleteComment({
    required BuildContext context,
    required Comment comment,
    required BugModel bug,
  }) async {
    Either<Failure, void> res =
        await _reportsRepository.deleteComment(bug: bug, comment: comment);

    res.fold(
        (l) => showSnackBar(context: context, text: l.message), (r) => null);
  }

  //! edit bug
  void editBug({
    required BuildContext context,
    required BugModel bug,
    required void Function()? sideEffect,
  }) async {
    state = true;

    final res = await _reportsRepository.editBug(bug: bug);
    state = false;
    res.fold(
      (l) => showSnackBar(text: l.message, context: context),
      (r) {
        sideEffect!.call();
      },
    );
  }

  void updateBugStatusInProgress({
    required BuildContext context,
    required BugModel bug,
    required void Function()? sideEffect,
  }) async {
    state = true;

    final res = await _reportsRepository.updateBugStatusInProgress(bug: bug);
    state = false;
    res.fold(
      (l) => showSnackBar(text: l.message, context: context),
      (r) {
        sideEffect!.call();
      },
    );
  }

  void updateBugStatusSolved({
    required BuildContext context,
    required BugModel bug,
    required void Function()? sideEffect,
  }) async {
    state = true;

    final res = await _reportsRepository.updateBugStatusSolved(bug: bug);
    state = false;
    res.fold(
      (l) => showSnackBar(text: l.message, context: context),
      (r) {
        sideEffect!.call();
      },
    );
  }

  void updateBugStatusInReview({
    required BuildContext context,
    required BugModel bug,
    required void Function()? sideEffect,
  }) async {
    state = true;

    final res = await _reportsRepository.updateBugStatusInReview(bug: bug);
    state = false;
    res.fold(
      (l) => showSnackBar(text: l.message, context: context),
      (r) {
        sideEffect!.call();
      },
    );
  }

  void updateBugStatusUbsolved({
    required BuildContext context,
    required BugModel bug,
    required void Function()? sideEffect,
  }) async {
    state = true;

    final res = await _reportsRepository.updateBugStatusUbsolved(bug: bug);
    state = false;
    res.fold(
      (l) => showSnackBar(text: l.message, context: context),
      (r) {
        sideEffect!.call();
      },
    );
  }

  //! get all bugs for a version
  Stream<List<BugModel>> getAllBugsForAVersion() {
    VersionModel? version = _ref.read(versionModelStateControllerProvider);
    return _reportsRepository.getAllBugsForAVersion(versionName: version!.name);
  }

  Stream<List<BugModel>> getAllBugsForAnOrganisation({required String status}) {
    OrganisationModel? orgInState = _ref.watch(orgModelStateControllerProvider);
    return _reportsRepository.getAllBugsForAVersionB(
      isSolved: true,
      orgName: orgInState!.name,
      status: status,
    );
  }

  Stream<List<BugModel>> getAllUnsolvedBugsForAnOrganisation(
      {required String status}) {
    OrganisationModel? orgInState = _ref.watch(orgModelStateControllerProvider);
    return _reportsRepository.getAllBugsForAVersionB(
      isSolved: false,
      orgName: orgInState!.name,
      status: status,
    );
  }

  //! get bug by id
  Stream<BugModel> getBugById({required String bugId}) {
    return _reportsRepository.getBugById(bugId: bugId);
  }
}

//! version model state
class VersionModelStateController extends StateNotifier<VersionModel> {
  VersionModelStateController() : super(verse);

  //! fix an organisation in state
  void fixVersionInState({required VersionModel version}) async {
    version.name.log();
    state = version;
  }

  //1 remove
  void removeVersionFromState() {
    state = verse;
  }
}

VersionModel verse = VersionModel(
  id: '',
  orgName: '',
  projectName: '',
  name: '',
  assignedBy: '',
  unsolvedBugs: [],
  inProgressBugs: [],
  inReviewBugs: [],
  resolvedBugs: [],
  createdAt: DateTime.now(),
);
