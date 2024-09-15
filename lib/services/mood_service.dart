import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:fpdart/fpdart.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';
import '../providers/common/supabase_provider.dart';

final authServiceProvider = AutoDisposeProvider<AuthService>(
  (ref) => AuthService(
    client: ref.watch(supabaseProvider),
  ),
);

class AuthService {
  final SupabaseClient _client;

  AuthService({
    required SupabaseClient client,
  }) : _client = client;

  

  FutureEither<bool> loginAnonymously() async {
    try {
      await _client.auth.signInAnonymously();

      return const Right(true);
    } catch (e) {
      logError(e.toString());
      return const Left(Failure('Failed to login'));
    }
  }

 
}
