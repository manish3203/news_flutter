import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EnvConfig {
  static String get newsApiKey =>
      dotenv.env['NEWS_API_KEY'] ?? '';
}