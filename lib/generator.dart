import 'package:recase/recase.dart';

String generateDartModel(Map<String, dynamic> json,
    {required String className}) {
  final buffer = StringBuffer();
  buffer.writeln('class $className {');

  // Fields
  json.forEach((key, value) {
    final type = _getDartType(value);
    buffer.writeln('  final $type ${key.camelCase};');
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
    buffer.writeln("    ${key.camelCase}: json['$key'] as $type,");
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
    buffer.writeln('    ${key}.hashCode ^');
  });
  buffer.writeln('    0;\n}');

  return buffer.toString();
}

String _getDartType(dynamic value) {
  if (value is int) return 'int';
  if (value is double) return 'double';
  if (value is bool) return 'bool';
  if (value is List) return 'List<dynamic>';
  if (value is Map) return 'Map<String, dynamic>';
  return 'String';
}
