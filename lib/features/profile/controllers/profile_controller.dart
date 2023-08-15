import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traq/core/providers/storage_repository_provider.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/features/profile/repositories/profile_repository.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/utils/snack_bar.dart';

part '../controllers/profile_controller.providers.dart';

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _userProfileRepository = userProfileRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  //! edit user profile
  void editUserProfile({
    required BuildContext context,
    required UserModel user,
  }) async {
    state = true;

    final res = await _userProfileRepository.editProfile(user);
    state = false;
    res.fold(
      (l) => showSnackBar(context: context, text: l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => user);
      },
    );
  }

  //! edit user profile image
  void editUserProfileImage({
    required BuildContext context,
    required File? profileFile,
    Uint8List? file,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;
    if (profileFile != null) {
      final res = await _storageRepository.storeFile(
        path: 'users/profile',
        id: user.uid!,
        file: profileFile,
        webFile: file,
      );
      res.fold(
        (l) => showSnackBar(context: context, text: l.message),
        (r) => user = user.copyWith(profilePic: r),
      );
    }

    final res = await _userProfileRepository.editProfile(user);
    state = false;
    res.fold(
      (l) => showSnackBar(context: context, text: l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => user);
      },
    );
  }
}
