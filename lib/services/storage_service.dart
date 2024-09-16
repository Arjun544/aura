import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../providers/common/supabase_provider.dart';

final storageServiceProvider = AutoDisposeProvider<StorageService>(
  (ref) => StorageService(
    client: ref.watch(supabaseProvider),
  ),
);

class StorageService {
  final SupabaseClient _client;

  StorageService({
    required SupabaseClient client,
  }) : _client = client;

  FutureEither<String> uploadImage({
    required String folder,
    required String subFolder,
    required File file,
  }) async {
    try {
      await _client.storage.from(folder).upload(
            subFolder,
            file,
          );
      final String publicUrl =
          _client.storage.from(folder).getPublicUrl(subFolder);
      return Right(publicUrl);
    } catch (e) {
      return const Left(Failure('Failed to upload image'));
    }
  }

  FutureEither<bool> deleteImage({
    required String folder,
    required String name,
  }) async {
    try {
      final files = await _client.storage.from(folder).remove([name]);

      if (files.isEmpty) {
        return const Left(Failure('Failed to delete image'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      log(e.toString());
      return const Left(Failure('Failed to delete image'));
    }
  }

  FutureEither<bool> replaceImage({
    required String folder,
    required String name,
    required File file,
  }) async {
    log('name $name');
    try {
      final String path = await _client.storage.from(folder).update(
            name,
            file,
          );
      log('path $path');
      final String publicUrl = _client.storage.from(folder).getPublicUrl(path);
      if (publicUrl.isEmpty) {
        return const Left(Failure('Failed to update image'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      log(e.toString());
      return const Left(Failure('Failed to update image'));
    }
  }
}
