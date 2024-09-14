import '../../../utils/app_utils.dart';

extension AppStringUtils on String {
  String? get capitalizeFirst => AppUtils.capitalizeFirst(this);

  bool get isPhoneNumber => AppUtils.isPhoneNumber(this);

  bool get isURL => AppUtils.isURL(this);

  bool get isEmail => AppUtils.isValidEmail(this);

  String toK() {
    int? value = int.tryParse(this);
    if (value == null) {
      return this; // Return the original string if it's not a valid integer
    }
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(value % 1000000 == 0 ? 0 : 1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1)}k';
    }
    return this; // Return the original string if it's less than 1000
  }
}
