🧬 json_model_gen

Generate Dart model classes effortlessly from raw JSON using this CLI tool.



✨ Features

🔄 Converts JSON into Dart classes
❄️ Supports freezed annotation
♻️ Supports equatable
🔒 Optional field nullability
💬 Interactive prompts (if no flags provided)
🛑 Prevents accidental overwrites
📁 Auto-renames .json → .dart when needed



🚀 Installation

To install from pub.dev, run:

dart pub add json_model_gen
Or manually add it to your pubspec.yaml:

dependencies:
  json_model_gen: ^0.0.6
Then run:

dart pub get



🔧 Usage

📦 Full command with flags:
dart run json_model_gen \
  --input=raw.json \
  --output=lib/user_model.dart \
  --class=UserModel \
  --freezed \
  --equatable \
  --nullable

🧠 Or use interactive mode:
Just run:

dart run json_model_gen
It will ask you step-by-step:

📥 Input file path
📤 Output file path
🧪 Class name
⚙️ Use equatable
❄️ Use freezed
❓ Make all fields nullable
📌 Example

Input (raw.json)
{
  "id": 1,
  "name": "Alice",
  "active": true,
  "bio": null
}
Output (user_model.dart)
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    String? name,
    bool? active,
    String? bio,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}


⚠️ Notes

✅ Input file must contain ONLY valid JSON, not Dart code.
📄 If your input file ends with .dart, it will still work, but a warning will appear.
🧪 Class names are validated to be in PascalCase.
📌 --output=model.json will auto-convert to model.dart.

⭐ Star the repo on GitHub if you like it!