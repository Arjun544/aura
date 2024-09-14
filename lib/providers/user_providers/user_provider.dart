import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/providers/common/supabase_provider.dart';

final userProvider =
    StateProvider<User?>((ref) => ref.read(supabaseProvider).auth.currentUser);
