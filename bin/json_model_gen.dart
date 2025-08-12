// CLI entry point for the `json_model_gen` package.


import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:json_model_gen/json_model_gen.dart';
import 'package:recase/recase.dart';

/// Main function that handles command-line arguments and runs the generator.
void main(List<String> arguments) async {
  // Define CLI options and flags
  final parser = ArgParser()
    ..addOption('input',
        abbr: 'i', help: 'Path to the Dart file containing raw JSON')
    ..addOption('output',
        abbr: 'o', help: 'Path to save the generated Dart model')
    ..addOption('class', abbr: 'c', help: 'Name of the Dart class to generate')
    ..addFlag('equatable', abbr: 'e', help: 'Use Equatable', defaultsTo: false)
    ..addFlag('freezed', abbr: 'f', help: 'Use Freezed', defaultsTo: false)
    ..addFlag('nullable',
        abbr: 'n', help: 'Make all fields nullable', defaultsTo: false);

  final args = parser.parse(arguments);

  // Prompt or retrieve input file path
  final inputPath =
      args['input'] ?? _prompt('📥 Enter path to input Dart file with JSON');

  // Prompt or retrieve output file path
  var outputPath =
      args['output'] ?? _prompt('📤 Enter path to save generated Dart file');
  if (outputPath.endsWith('.json')) {
    print(
        '⚠️  Output file ends with `.json`. Renaming to `.dart` for valid Dart code.');
    outputPath = outputPath.replaceAll(RegExp(r'\.json$'), '.dart');
  }

  // Prompt or retrieve class name and convert to PascalCase
  final rawClassName =
      args['class'] ?? _prompt('🧪 Enter class name for the model');
  final className = ReCase(rawClassName).pascalCase;

  // Validate Dart class name
  if (!_isValidDartIdentifier(className)) {
    print(
        '❌ Invalid class name "$className". Use PascalCase (e.g., UserModel).');
    exit(1);
  }

  // Warn if input is a .dart file (should contain only raw JSON)
  if (inputPath.endsWith('.dart')) {
    print(
        '⚠️  Input file ends with `.dart`. Ensure it contains ONLY raw JSON, not Dart code.');
  }

  // Validate input file existence
  final inputFile = File(inputPath);
  if (!await inputFile.exists()) {
    print('❌ Input file not found: $inputPath');
    exit(1);
  }

  // Validate overwrite on output file
  final outputFile = File(outputPath);
  if (await outputFile.exists()) {
    final overwrite =
        _prompt('⚠️  File already exists. Overwrite? (y/n)').toLowerCase();
    if (overwrite != 'y') {
      print('❌ Cancelled by user.');
      exit(0);
    }
  }

  // Parse JSON from input
  final content = await inputFile.readAsString();
  Map<String, dynamic> jsonData;
  try {
    jsonData = jsonDecode(content);
  } catch (e) {
    print(
        '❌ Error: Failed to parse JSON from file. Make sure the file contains ONLY valid JSON.');
    print('Details: $e');
    exit(1);
  }

  // Interactive or flag-based config
  final useEquatable = args['equatable'] ||
      _prompt('⚙️  Use equatable? (y/n):').toLowerCase() == 'y';
  final useFreezed = args['freezed'] ||
      _prompt('❄️  Use freezed? (y/n):').toLowerCase() == 'y';
  final allNullable = args['nullable'] ||
      _prompt('❓ Make all fields nullable? (y/n):').toLowerCase() == 'y';

  // Generate Dart model code
  final modelCode = generateDartModel(
    jsonData,
    className: className,
    useEquatable: useEquatable,
    useFreezed: useFreezed,
    allNullable: allNullable,
  );

  // Write generated code to file
  await outputFile.writeAsString(modelCode);

  print('✅ Model class "$className" generated successfully at: $outputPath');
  if (useFreezed) {
    print('\n💡 Don\'t forget to run:');
    print('   flutter pub run build_runner build --delete-conflicting-outputs');
  }
}

/// Prompts the user with a message and reads input from the terminal.
String _prompt(String message) {
  stdout.write(message);
  return stdin.readLineSync() ?? '';
}

/// Validates if a string is a valid Dart class name (PascalCase).
bool _isValidDartIdentifier(String name) {
  final validIdentifier = RegExp(r'^[A-Z][a-zA-Z0-9]*$');
  return validIdentifier.hasMatch(name);
}
