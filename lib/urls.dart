class Urls {
  static const String _mainUrl = "https://api.github.com";
  static const String _orgListingPath = "/organizations";

  static String get orgListingUrl => _mainUrl + _orgListingPath;
}
