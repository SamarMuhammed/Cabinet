class LocalizedData {
  final String value;

  LocalizedData(this.value);

  factory LocalizedData.fromMap(Map<String, dynamic> data, String languageCode, String field) {
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

    return LocalizedData(data[key] ?? 'No $field available');
  }
}

// Usage example:
class SomeClass {
  final LocalizedData title;
  final LocalizedData description;

  SomeClass({
    required this.title,
    required this.description
  });

  factory SomeClass.fromJson(Map<String, dynamic> json, String languageCode) {
    return SomeClass(
        title: LocalizedData.fromMap(json, languageCode, 'title'),
        description: LocalizedData.fromMap(json, languageCode, 'description')
    );
  }
}

// Example of how you might use it
