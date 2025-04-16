class Format {
  String degrees(final double num) {
    String res = '';
    res = (num / 10).toStringAsFixed(2);
    return res;
  }
}
