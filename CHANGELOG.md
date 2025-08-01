## 0.0.1
- Initial release: generate Dart model from JSON
## 0.0.2
- format code
## 0.0.3
- documentation commands
## 0.0.4
- formatted
## 0.0.5
- Added support for both CLI flags and interactive prompts.
- Supports generation of Dart models with:
  - `equatable` integration
  - `freezed` integration
  - `nullable` fields option
- Automatic renaming of output `.json` files to `.dart`.
- Class name validation enforcing PascalCase.
- Detects and confirms before overwriting existing output files.

### 🛠 Enhancements
- Improved error handling for:
  - Missing input file
  - Invalid JSON content
- Clear warnings for `.dart` inputs that contain raw JSON.
- Added file-level and function-level documentation comments.
