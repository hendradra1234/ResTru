import 'dart:math';

import 'package:intl/intl.dart';

class Utils {
  static String priceGenerator() {
    var rand = Random().nextInt(1000) * 100;
    var f = NumberFormat("#,000", "id_ID");
    return "Rp. ${f.format(rand)}";
  }

  static String camelCase(String? text) {
    if (text == null) {
      return '';
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }
}
