String formatPhoneNumberWithSpace(String phone) {
  final RegExp regex = RegExp(r'(\+998)(\d{2})(\d{3})(\d{2})(\d{2})');
  return phone.replaceAllMapped(
      regex, (Match m) => '${m[1]} ${m[2]} ${m[3]} ${m[4]} ${m[5]}');
}
