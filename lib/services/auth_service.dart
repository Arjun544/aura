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

  FutureEither<bool> loginWithGoogle() async {
    try {
      final rawNonce = _client.auth.generateRawNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final clientId = Platform.isIOS
          ? '81060931160-mtf9ddlk7hofqg3ua54jomgb3nu3c2r9.apps.googleusercontent.com'
          : '81060931160-3end1kftav59msgolumc56j0arj60hos.apps.googleusercontent.com';

      final redirectUrl = '${clientId.split('.').reversed.join('.')}:/';

      const discoveryUrl =
          'https://accounts.google.com/.well-known/openid-configuration';

      const appAuth = FlutterAppAuth();

      final result = await appAuth.authorize(
        AuthorizationRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          nonce: hashedNonce,
          scopes: [
            'openid',
            'email',
            'profile',
          ],
        ),
      );

      if (result.authorizationCode == null) {
        throw 'No result';
      }

      // Request the access and id token to google
      final tokenResult = await appAuth.token(
        TokenRequest(
          clientId,
          redirectUrl,
          authorizationCode: result.authorizationCode,
          discoveryUrl: discoveryUrl,
          codeVerifier: result.codeVerifier,
          nonce: result.nonce,
          scopes: [
            'openid',
            'email',
            'profile',
          ],
        ),
      );

      final idToken = tokenResult.idToken;

      if (idToken == null) {
        throw 'No idToken';
      }

      final response = await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        nonce: rawNonce,
      );
      if (response.user != null) {
        return const Right(true);
      } else {
        return const Left(Failure('User not found'));
      }
    } catch (e) {
      return const Left(Failure('Failed to login'));
    }
  }

  FutureEither<bool> loginAnonymously() async {
    try {
      await _client.auth.signInAnonymously();

      return const Right(true);
    } catch (e) {
      logError(e.toString());
      return const Left(Failure('Failed to login'));
    }
  }

  Future<void> logout({
    SignOutScope? scope,
  }) async {
    try {
      await _client.auth.signOut(
        scope: scope ?? SignOutScope.local,
      );
    } catch (e) {
      logError(e.toString());
    }
  }
}
