import 'package:json_model_gen/json_model_gen.dart';
import 'dart:convert';

void main() {
  final jsonString = '''
  {
    "id": 1,
    "title": "Hello World",
    "isPublished": true,
    "rating": 4.5
  }
  ''';

  final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

  final dartModel = generateDartModel(jsonMap, className: 'Post');
  print(dartModel);
}
