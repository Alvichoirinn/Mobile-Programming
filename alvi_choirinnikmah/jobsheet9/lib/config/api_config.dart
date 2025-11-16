class ApiConfig {
  static const String baseUrl = 'https://your-wiremock-cloud-instance.wiremockapi.cloud';
  static const String usersEndpoint = '/users';
  static const int timeoutSeconds = 30;

  static Map<String, String> headers = {
    'Content-Type': 'applicatiobn/json',
    'Accept': 'application/json',
  };
}