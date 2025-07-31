import 'dart:convert';
import 'dart:io';
import 'package:json_model_gen/generator.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('❗ Usage: json_model_gen <input_json_file>');
    return;
  }

  final inputFile = File(arguments[0]);

  if (!await inputFile.exists()) {
    print('❗ File not found: ${arguments[0]}');
    return;
  }

  final content = await inputFile.readAsString();
  final jsonMap = jsonDecode(content);

  final result = generateDartModel(jsonMap, className: 'RootModel');
  final outputFile = File('root_model.dart');
  await outputFile.writeAsString(result);

  print('✅ Model generated: root_model.dart');
}
