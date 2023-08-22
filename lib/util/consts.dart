import 'package:flutter_dotenv/flutter_dotenv.dart';

// const String baseUrl = "http://192.168.64.233:8000";
final String baseUrl = dotenv.env['BASE_URL']!;
