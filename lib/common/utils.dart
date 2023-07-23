dynamic tryParseString(String str) {
  try {
    return double.parse(str);
  } catch (e) {
    return str;
  }
}
