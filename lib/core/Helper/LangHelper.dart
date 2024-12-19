import 'package:reidsc/data/model/news/NewsVM.dart';

class LocalizationHelper {
  static String getLocalizedValue(dynamic data, String languageCode,
      String field) {
    String key;

    switch (languageCode) {
      case 'fr':
        key = '${field}F'; // e.g., titleF, descriptionF
        break;
      case 'It':
        key = '${field}It';
        break;

      case 'es':
        key = '${field}Es';
        break;
      case 'ru':
        key = '${field}R';
        break;
      case 'C':
        key = '${field}C';
        break;
      case 'en':
      default:
        key = '${field}E'; // Default to English
    }
    return data[key] ?? 'No $field available';
  }

}