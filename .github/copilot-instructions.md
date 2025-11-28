## Quick context — what this project is

This is a small Flutter app (multi-platform) whose main entry is `lib/main.dart` and the visible screen is a login UI at `lib/login/login_page.dart`.

Key points agents should know up front:
- The UI is implemented in `lib/login/login_page.dart`. It's a StatefulWidget using three TextEditingControllers and inline validators.
- There are placeholder files intended for separation of concerns: `lib/login/login_model.dart`, `lib/login/login_validator.dart`, and `lib/login/login_controller.dart`. These are incomplete/empty and expect logic to be moved/extracted there.
- The `test/widget_test.dart` still contains the default counter test and will fail unless updated to reflect the login UI.

## Big picture architecture
- Single-screen demo app: main -> LoginPage (lib/main.dart -> lib/login/*).
- UI (presentational) is in `login_page.dart`; the author intended separate files for controller/model/validation but currently most logic is kept inline in the widget.
- No backend integration exists — the Sign In button shows a SnackBar; adding network/auth should introduce a clear service abstraction and tests.

## How to run / test / debug
- Use standard Flutter dev commands from the repo root:
  - Install deps: `flutter pub get`
  - Run on desktop: `flutter run -d windows` (or `-d chrome`, `-d emulator-id` for other targets)
  - Run tests: `flutter test` (note: current `test/widget_test.dart` will fail until updated to match the login UI)
  - Static analysis: `flutter analyze` (configuration in `analysis_options.yaml`)
  - Build artifacts: `flutter build apk|ios|web|windows` as appropriate

## Project-specific patterns & conventions
- Separation of concerns is expected: move business logic out of the widget into the matching files under `lib/login/`:
  - `login_controller.dart` — UI state + actions (or ChangeNotifier/provider class)
  - `login_model.dart` — data shapes (e.g., LoginRequestDto, User model)
  - `login_validator.dart` — validation helpers used by the form validators

- Avoid duplicating state between `login_page.dart` and `login_controller.dart`. Right now `login_controller.dart` contains a partial duplicate of the State class — prefer a single source of truth.

## What an AI agent should do first (concrete starter tasks)
1. Update tests: change `test/widget_test.dart` to match the visible UI (assert finds `Login` or `Sign In` button) so CI/doctests don’t fail.
2. Extract validation logic to `login_validator.dart` and reference it from `login_page.dart` — e.g., provide `bool isValidEmail(String s)` and `String? emailError(String s)`.
3. Move stateful behavior into `login_controller.dart` (or a provider/ChangeNotifier) and update `login_page.dart` to read from that controller.
4. Add minimal tests for validation functions and a widget test for the login UI.

## Where to look for examples when changing code
- UI: `lib/login/login_page.dart`
- (Intended) controller model/validator: `lib/login/login_controller.dart`, `lib/login/login_model.dart`, `lib/login/login_validator.dart`
- Tests: `test/widget_test.dart`

## Avoid these pitfalls
- Do not leave duplicate state definitions across files; unify in the controller.
- Don't alter platform-generated files (android/, ios/, windows/, linux/, macos/) except when absolutely necessary for platform-specific bugs.

If anything here is incorrect or you want the file to emphasize a different area (e.g., CI, specific test patterns), tell me which parts to expand or the tasks you want prioritized and I'll iterate. ✅
