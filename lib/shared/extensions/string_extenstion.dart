extension StringExt on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  bool containsIgnoreCase(String query) =>
      (this).toLowerCase().contains(query.toLowerCase());

  /// check if string literly empty and remove all of spacing
  bool get pureEmpty => trim().isEmpty;
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  /// Password must be at least 8 characters long,
  /// including one uppercase letter, one lowercase letter,
  /// one number, and one special character
  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  // just allowed number
  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^\d+$');
    return phoneRegExp.hasMatch(this);
  }

  /// here is for suport on localization
  /// we can use this to improvement on text has translated

  /// "This Is Title Case"
  // String get trTitleCase => tr(this).toTitleCase();

  /// for translation
  /// "THIS IS CAPITAL CASE"
  // String get trCapitalCase => tr(this).toUpperCase();

  /// for translation
  /// "this is lower case"
  // String get trLowerCase => tr(this).toLowerCase();

  /// for translation
  /// "This is First capital"
  // String get trCapsFirst =>
  //     '${tr(this)[0].toUpperCase()}${tr(this).substring(1)}';

  /// for translation
  /// "THIS IS UPPERCASE"
  // String get trUpperCase => tr(this).toUpperCase();
}
