/// A Dart library for generating Dart model classes from JSON data.
///
/// This library provides functionality to automatically create Dart classes
/// with proper serialization/deserialization methods based on JSON structure.
///
/// The generated classes include:
/// - Constructor with required parameters
/// - `fromJson` factory method for deserialization
/// - `toJson` method for serialization
/// - `copyWith` method for immutable updates
/// - Proper `==` operator and `hashCode` implementation
library json_model_gen;

/// Dart model generator from JSON
export 'generator.dart';
