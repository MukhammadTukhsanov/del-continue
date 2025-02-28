int removeSpacesAndConvertToInt(String input) {
  String cleanedString = input.replaceAll(RegExp(r'\s+'), "");
  return int.tryParse(cleanedString) ?? 0;
}
