import 'package:flutter/material.dart';
// login_model.dart is intentionally unused here at the moment; keep in repo for future DTOs.

/// Controller that centralizes the UI state and actions for the login page.
///
/// This class mirrors the previous inline state from `_LoginPageState` and
/// exposes methods for validation, toggling password visibility, and submit.
class LoginController extends ChangeNotifier {
  final phoneController = TextEditingController();
  final passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showPass = false;

  void toggleShowPass() {
    showPass = !showPass;
    notifyListeners();
  }

  bool validate() => formKey.currentState?.validate() ?? false;

  void submit(BuildContext context) {
    if (!validate()) return;

    // Build a value object for potential future use (auth, navigation, logging)
    // final data = LoginData(phone: phoneController.text, password: passController.text);

    // Demo behaviour (same as before): show a SnackBar. Replace with real
    // authentication/service calls when integrating a backend.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login Successful (Demo)')));

    // Optionally: do something with a LoginData instance (logging, navigation)
  }

  /// Demo social sign-in handler. Replace with real OAuth flow when available.
  void signInWithGoogle(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Google sign-in (demo)')));
  }

  /// Demo Gmail sign-in handler (UI-only stub). Replace with a real flow.
  void signInWithGmail(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Gmail sign-in (demo)')));
  }

  @override
  void dispose() {
    phoneController.dispose();
    // emailController removed (no longer used in UI)
    passController.dispose();
    super.dispose();
  }
}
