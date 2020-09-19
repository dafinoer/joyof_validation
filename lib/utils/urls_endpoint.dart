

class UrlsEndpoint {
  
  static const String _BASE_URL = 'https://ibnux.github.io';

  static const String _PATH = '/data-indonesia/';

  static const String URL_PROVINCE  = _BASE_URL + _PATH + 'propinsi.json';
  static const String URL_KABUPATEN = _BASE_URL + _PATH + 'kabupaten/{id}.json';
  static const String URL_KECAMATAN = _BASE_URL + _PATH + 'kecamatan/{id}.json';
  static const String URL_KELURAHAN = _BASE_URL + _PATH + 'kelurahan/{id}.json';
}