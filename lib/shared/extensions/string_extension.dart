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

}