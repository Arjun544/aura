import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../core/imports/core_imports.dart';
import '../core/imports/packages_imports.dart';

final aiServiceProvider = AutoDisposeProvider<AiService>((ref) {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: dotenv.get('GEMINI_API_KEY'),
  );

  return AiService(
    model: model,
    ref: ref,
  );
});

class AiService {
  final GenerativeModel _model;
  final AutoDisposeProviderRef<AiService> _ref;

  AiService({
    required GenerativeModel model,
    required AutoDisposeProviderRef<AiService> ref,
  })  : _model = model,
        _ref = ref;

  Future<List<String>> recommendActivities({
    required String mood,
    String? note,
  }) async {
    try {
      logError(mood);
      final prompt = note != null
          ? 'List of 10 short activities for $mood mood using this note: $note'
          : 'List of 10 short activities for $mood mood.';
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(
        content,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: Schema.array(
            items: Schema.string(),
          ),
        ),
      );

      if (response.text != null) {
        final List<dynamic> decodedList = jsonDecode(response.text!);
        return decodedList.cast<String>();
      } else {
        throw const Left(Failure('Failed to recommend activities'));
      }
    } catch (e) {
      logError(e.toString());
      throw const Left(Failure('Failed to recommend activities'));
    }
  }
}
