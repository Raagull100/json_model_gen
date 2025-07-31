import 'package:json_model_gen/generator.dart';
import 'package:test/test.dart';

void main() {
  group('generateDartModel', () {
    test('generates Dart class from simple JSON', () {
      final json = {
        'name': 'John Doe',
        'age': 30,
        'isActive': true,
      };

      final result = generateDartModel(json, className: 'Person');

      expect(result, contains('class Person {'));
      expect(result, contains('final String name;'));
      expect(result, contains('final int age;'));
      expect(result, contains('final bool isActive;'));
      expect(result, contains('factory Person.fromJson'));
      expect(result, contains('Map<String, dynamic> toJson()'));
      expect(result, contains('Person copyWith('));
    });

    test('handles different data types correctly', () {
      final json = {
        'stringValue': 'test',
        'intValue': 42,
        'doubleValue': 3.14,
        'boolValue': false,
        'listValue': [1, 2, 3],
        'mapValue': {'key': 'value'},
      };

      final result = generateDartModel(json, className: 'TestModel');

      expect(result, contains('final String stringValue;'));
      expect(result, contains('final int intValue;'));
      expect(result, contains('final double doubleValue;'));
      expect(result, contains('final bool boolValue;'));
      expect(result, contains('final List<dynamic> listValue;'));
      expect(result, contains('final Map<String, dynamic> mapValue;'));
    });
  });
}
