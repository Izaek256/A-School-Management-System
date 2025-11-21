class Config {
  static const String apiUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  // Alternative approach using build-time constants
  static const String devApiUrl = 'http://localhost:8000';
  static const String stagingApiUrl =
      'https://staging-api.schoolsystem.com';
  static const String prodApiUrl = 'https://api.schoolsystem.com';

  // Current environment
  static const String currentEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );

  static String get baseUrl {
    switch (currentEnv) {
      case 'production':
        return prodApiUrl;
      case 'staging':
        return stagingApiUrl;
      case 'development':
      default:
        return devApiUrl;
    }
  }
}
