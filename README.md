# 🧬 json_model_gen

[![pub version](https://img.shields.io/pub/v/json_model_gen.svg)](https://pub.dev/packages/json_model_gen)
[![likes](https://badges.bar/json_model_gen/likes)](https://pub.dev/packages/json_model_gen/score)
[![popularity](https://badges.bar/json_model_gen/popularity)](https://pub.dev/packages/json_model_gen/score)

`json_model_gen` is a **Dart CLI tool** that helps you convert a raw JSON file into a clean, fully-functional Dart model class — complete with:

- `fromJson` & `toJson`
- `copyWith` method
- `==` operator & `hashCode`

Perfect for Flutter and Dart developers who want fast, consistent, and maintainable model classes.

---

## 🚀 Installation

To install this CLI tool globally:

```bash
dart pub global activate --source path .
Make sure you're inside the package directory when running the command above.
⚙️ How to Use

1️⃣ Prepare a JSON file
Example: sample.json

{
  "id": 1,
  "name": "Raagull",
  "isActive": true,
  "rating": 4.5
}
Save it anywhere on your system.

2️⃣ Run the generator
json_model_gen path/to/sample.json
✅ This command will:

Parse the JSON
Generate a Dart model class
Save it as root_model.dart in the same directory
3️⃣ Output: What You Get
root_model.dart will contain something like:

class RootModel {
  final int id;
  final String name;
  final bool isActive;
  final double rating;

  const RootModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.rating,
  });

  factory RootModel.fromJson(Map<String, dynamic> json) => RootModel(
    id: json['id'] as int,
    name: json['name'] as String,
    isActive: json['isActive'] as bool,
    rating: json['rating'] as double,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'isActive': isActive,
    'rating': rating,
  };

  RootModel copyWith({
    int? id,
    String? name,
    bool? isActive,
    double? rating,
  }) => RootModel(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    rating: rating ?? this.rating,
  );

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is RootModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      name == other.name &&
      isActive == other.isActive &&
      rating == other.rating;

  @override
  int get hashCode =>
    id.hashCode ^
    name.hashCode ^
    isActive.hashCode ^
    rating.hashCode;
}
🧪 Example: Using in Dart Code

You can also use it programmatically:

import 'package:json_model_gen/json_model_gen.dart';
import 'dart:convert';

void main() {
  final jsonString = '{"id": 1, "name": "Raagull", "isActive": true}';
  final jsonMap = jsonDecode(jsonString);

  final classCode = generateDartModel(jsonMap, className: 'User');
  print(classCode);
}
📦 Features

✅ Clean & readable Dart code
✅ Handles primitive types: int, double, bool, String
✅ Constructor, fromJson, toJson, copyWith
✅ Value equality support (==, hashCode)


📄 License

This project is licensed under the MIT License.

You can use, copy, modify, and distribute this software freely — just give credit and don’t blame the author if something breaks.
🙌 Author

Made with ❤️ by Raagull Sakthivel

✨ Contributions

Feel free to fork, contribute, or suggest ideas via GitHub Issues!


Let me know if you want this published as a public GitHub repo or want a GitHub Actions workflow to auto-release it to pub.dev on each new version.
