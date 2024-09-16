import 'dart:io';

import 'package:aura/helpers/get_file_name.dart';
import 'package:aura/providers/user_providers/user_provider.dart';
import 'package:fpdart/fpdart.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../providers/common/supabase_provider.dart';
import 'storage_service.dart';

final userServiceProvider = AutoDisposeProvider<UserService>(
  (ref) => UserService(
    client: ref.watch(supabaseProvider),
    ref: ref,
  ),
);

class UserService {
  final SupabaseClient _client;
  final AutoDisposeProviderRef _ref;

  UserService({
    required SupabaseClient client,
    required AutoDisposeProviderRef ref,
  })  : _client = client,
        _ref = ref;

  FutureEither<String> updateImage({
    required File file,
  }) async {
    try {
      final storageProvider = _ref.read(storageServiceProvider);
      final metaData =
          _ref.read(userProvider.select((value) => value!.userMetadata));

      final String? oldProfileUrl = metaData?['photo'];

      if (oldProfileUrl != null && !oldProfileUrl.contains('google')) {
        // Replace old profile image with new profile image
        await storageProvider.deleteImage(
          folder: 'profiles',
          name: getFileName(oldProfileUrl, folder: 'profiles'),
        );
      }

      final photo = await storageProvider.uploadImage(
        folder: 'profiles',
        subFolder: _client.auth.currentUser!.id,
        file: file,
      );

      final uploadUrl = photo.getOrNull();

      if (uploadUrl != null) {
        await _client.auth.updateUser(
          UserAttributes(
            data: {
              'photo': uploadUrl,
            },
          ),
        );

        return Right(uploadUrl);
      } else {
        return const Left(Failure('Failed to update image'));
      }
    } catch (e) {
      logError(e.toString());
      return const Left(Failure('Failed to update image'));
    }
  }
}
