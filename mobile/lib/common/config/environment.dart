import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName => '.env';

  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'Environment variable not found';

  static Future<void> init() async {
    await dotenv.load(fileName: fileName);
  }
}
