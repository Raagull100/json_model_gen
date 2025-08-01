## 🧬 json\_model\_gen

A sleek CLI tool to effortlessly generate Dart model classes from raw JSON.

---

## ✨ Features

- 🔄 Convert raw JSON to Dart model classes
- ❄️ Supports `freezed` annotation
- ♻️ Supports `equatable`
- 🔒 Make all fields nullable (optional)
- 💬 Interactive prompts (if flags aren't provided)
- 🛑 Overwrite protection with confirmation
- 📁 Auto-renames `.json` → `.dart` when needed

---

## 🚀 Installation

From [pub.dev](https://pub.dev/packages/json_model_gen):

```bash
dart pub add json_model_gen
```

Or manually add to your `pubspec.yaml`:

```yaml
dependencies:
  json_model_gen: ^0.0.6
```

Then:

```bash
dart pub get
```

---

## 🔧 Usage

### ✅ Full command with all options:

```bash
dart run json_model_gen \
  --input=raw.json \
  --output=lib/user_model.dart \
  --class=UserModel \
  --freezed \
  --equatable \
  --nullable
```

### 🧠 Interactive mode:

If you omit the flags:

```bash
dart run json_model_gen
```

You’ll be guided step-by-step to:

- 📅 Enter input file path
- 📄 Enter output file path
- 🧪 Enter class name
- ⚙️ Use `equatable`?
- ❄️ Use `freezed`?
- ❓ Make all fields nullable?

---

## 📌 Example

### Input (`raw.json`)

```json
{
  "id": 1,
  "name": "Alice",
  "active": true,
  "bio": null
}
```

### Output (`user_model.dart`)

```dart
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
```

---

## ⚠️ Notes

- ✅ Input must be **raw JSON only** (not Dart code).
- 📄 If the input is a `.dart` file, you'll receive a warning.
- 💳 Class names are validated to ensure PascalCase formatting.
- 📌 Output paths ending in `.json` will be renamed to `.dart` automatically.

---

️⭐ Star the [GitHub repo](https://github.com/Raagull100/json_model_gen) if this helps you!

