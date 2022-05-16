import 'package:get/get.dart';

import 'Arabic.dart';
import 'English.dart';

class LanguageTranslations extends Translations
{

  @override
  Map<String, Map<String, String>> get keys =>
      {
        'en_US':en,
        'ar': ar,
      };
}
