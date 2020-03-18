String getRealDuration(String ms) {
  Duration parseMs = Duration(milliseconds: int.parse(ms));
  String parseMsStr = parseMs.toString();
  parseMsStr = parseMsStr.substring(0, parseMsStr.indexOf("."));

  if (parseMsStr[0].split(".")[0] == '0') {
    return parseMsStr.replaceFirst('0:', '');
  }
  return parseMsStr;
}
