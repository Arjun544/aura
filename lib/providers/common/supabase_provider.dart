import 'package:aura/core/imports/packages_imports.dart';

Future<SupabaseClient> supabaseInit() async {
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['ANON_KEY']!,
  );

  return Supabase.instance.client;
}

final supabaseProvider =
    Provider<SupabaseClient>((_) => Supabase.instance.client);
