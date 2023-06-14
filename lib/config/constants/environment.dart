

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static intitEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'APIURL not set';
}