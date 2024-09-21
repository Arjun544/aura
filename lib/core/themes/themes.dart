import 'package:aura/core/imports/core_imports.dart';

class Themes{
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: AppColors.customBlack,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.customBlack,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFF868590),
          fontWeight: FontWeight.w600,
        ),
        labelColor: AppColors.customBlack,
        unselectedLabelColor: const Color(0xFF8E8E91),
        labelPadding: const EdgeInsets.symmetric(vertical: 6),
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.customGrey,
        hintStyle: TextStyle(
          fontSize: 13,
          color: AppColors.customBlack.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        errorStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.errorColor,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.customBlack,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.customBlack,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      useMaterial3: true,
    );
  }
}
