import 'package:recase/recase.dart';

/// Generates a Dart model class from a given JSON structure.
///
/// This utility supports generation of:
/// - Standard Dart data classes
/// - `freezed` classes with deep equality and sealed union types
/// - `Equatable` support for value equality
/// - Optional `copyWith`, `fromJson`, and `toJson` methods
///
/// It supports making fields nullable and adapts the class structure based on flags.
///
/// Example:
/// ```dart
/// final code = generateDartModel(
///   {"name": "John", "age": 30},
///   className: 'User',
///   useEquatable: true,
///   useFreezed: false,
///   allNullable: false,
/// );
/// print(code); // prints the full Dart class
/// ```
///
/// Parameters:
/// - [json]: A Map representing the JSON structure.
/// - [className]: The desired name for the Dart class (in PascalCase).
/// - [useEquatable]: Whether to extend `Equatable` for value-based equality.
/// - [useFreezed]: Whether to use `freezed` package for code generation.
/// - [allNullable]: Whether to make all fields nullable (i.e., optional).
///
/// Returns the generated Dart class as a [String].
String generateDartModel(
  Map<String, dynamic> json, {
  required String className,
  bool useEquatable = false,
  bool useFreezed = false,
  bool allNullable = false,
}) {
  final buffer = StringBuffer();

  // Add imports
  if (useFreezed) {
    buffer.writeln(
        "import 'package:freezed_annotation/freezed_annotation.dart';");
    buffer.writeln();
    buffer.writeln("part '${className.snakeCase}.freezed.dart';");
    buffer.writeln("part '${className.snakeCase}.g.dart';");
  } else if (useEquatable) {
    buffer.writeln("import 'package:equatable/equatable.dart';");
  }

  buffer.writeln();

  // Add @freezed annotation
  if (useFreezed) buffer.writeln('@freezed');

  final classDeclaration = useFreezed
      ? 'class $className with _\$$className'
      : useEquatable
          ? 'class $className extends Equatable'
          : 'class $className';

  buffer.writeln('$classDeclaration {');

  // Constructor or factory (for freezed)
  if (useFreezed) {
    buffer.write('  const factory $className({');
    json.forEach((key, value) {
      final type = _getDartType(value);
      final nullableMark = allNullable ? '?' : '';
      buffer.write(' ${type}$nullableMark ${key.camelCase},');
    });
    buffer.writeln(' }) = _$className;');
    buffer.writeln();
    buffer.writeln(
        '  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);');
  } else {
    // Fields
    json.forEach((key, value) {
      final type = _getDartType(value);
      final nullableMark = allNullable ? '?' : '';
      buffer.writeln('  final $type$nullableMark ${key.camelCase};');
    });

    // Constructor
    buffer.write('\n  const $className({');
    json.forEach((key, _) {
      buffer.write('required this.${key.camelCase}, ');
    });
    buffer.writeln('});');

    // fromJson
    buffer.writeln(
        '\n  factory $className.fromJson(Map<String, dynamic> json) => $className(');
    json.forEach((key, value) {
      final type = _getDartType(value);
      final nullableCast = allNullable ? ' as $type?' : ' as $type';
      buffer.writeln("    ${key.camelCase}: json['$key']$nullableCast,");
    });
    buffer.writeln('  );');

    // toJson
    buffer.writeln('\n  Map<String, dynamic> toJson() => {');
    json.forEach((key, _) {
      buffer.writeln("    '$key': ${key.camelCase},");
    });
    buffer.writeln('  };');

    // copyWith
    buffer.writeln('\n  $className copyWith({');
    json.forEach((key, value) {
      final type = _getDartType(value);
      buffer.writeln("    $type? ${key.camelCase},");
    });
    buffer.writeln('  }) => $className(');
    json.forEach((key, _) {
      buffer.writeln(
          "    ${key.camelCase}: ${key.camelCase} ?? this.${key.camelCase},");
    });
    buffer.writeln('  );');

    // Equatable override
    if (useEquatable) {
      buffer.writeln('\n  @override');
      buffer.writeln('  List<Object?> get props => [');
      json.forEach((key, _) {
        buffer.writeln('    ${key.camelCase},');
      });
      buffer.writeln('  ];');
    } else {
      // equality
      buffer.writeln('\n  @override');
      buffer.writeln('  bool operator ==(Object other) =>');
      buffer.writeln('    identical(this, other) ||');
      buffer.writeln('    other is $className &&');
      buffer.writeln('      runtimeType == other.runtimeType &&');
      json.forEach((key, _) {
        buffer.writeln('      ${key.camelCase} == other.${key.camelCase} &&');
      });
      buffer.writeln('      true;');

      buffer.writeln('\n  @override');
      buffer.writeln('  int get hashCode =>');
      json.keys.map((k) => k.camelCase).forEach((key) {
        buffer.writeln('    $key.hashCode ^');
      });
      buffer.writeln('    0;');
    }
  }

  buffer.writeln('}');

  return buffer.toString();
}

/// Determines the appropriate Dart type for a given JSON value.
///
/// This helper function maps JSON value types to their corresponding Dart types:
/// - `int` values map to `int`
/// - `double` values map to `double`
/// - `bool` values map to `bool`
/// - `List` values map to `List<dynamic>`
/// - `Map` values map to `Map<String, dynamic>`
/// - All other values default to `String`
///
/// [value] The JSON value to determine the type for.
///
/// Returns a [String] representing the Dart type.
String _getDartType(dynamic value) {
  if (value is int) return 'int';
  if (value is double) return 'double';
  if (value is bool) return 'bool';
  if (value is List) return 'List<dynamic>';
  if (value is Map) return 'Map<String, dynamic>';
  return 'String';
}
