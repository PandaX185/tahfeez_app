class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://tahfeez-b842e04d074e.herokuapp.com/api',
  );
}
