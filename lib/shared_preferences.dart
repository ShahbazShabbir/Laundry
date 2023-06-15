import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final String apiKeyKey = 'apiKey';
  static final String apiSecretKey = 'apiSecret';

  static Future<void> setApiCredentials(String apiKey, String apiSecret) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(apiKeyKey, apiKey);
    await prefs.setString(apiSecretKey, apiSecret);
  }

  static Future<Map<String, String?>> getApiCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString(apiKeyKey);
    final apiSecret = prefs.getString(apiSecretKey);
    return {'apiKey': apiKey, 'apiSecret': apiSecret};
  }
}
