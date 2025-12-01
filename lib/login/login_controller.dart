import 'package:flutter/material.dart';
// login_model.dart is intentionally unused here at the moment; keep in repo for future DTOs.

/// Controller that centralizes the UI state and actions for the login page.
///
/// This class mirrors the previous inline state from `_LoginPageState` and
/// exposes methods for validation, toggling password visibility, and submit.
class LoginController extends ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showPass = false;

  void toggleShowPass() {
    showPass = !showPass;
    notifyListeners();
  }

  bool validate() => formKey.currentState?.validate() ?? false;

  /// Submits the form and returns true when submission is successful.
  ///
  /// This method still only runs demo behaviour (SnackBar) — replace with
  /// real authentication calls for production. Returning a boolean allows
  /// the UI layer to navigate after a successful login.
  bool submit(BuildContext context) {
    if (!validate()) return false;

    // Build a value object for potential future use (auth, navigation, logging)
    // final data = LoginData(phone: phoneController.text, password: passController.text);

    // Demo behaviour (same as before): show a SnackBar. Replace with real
    // authentication/service calls when integrating a backend.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login Successful (Demo)')));

    // Optionally: do something with a LoginData instance (logging, navigation)
    return true;
  }

  // (Google sign-in removed)

  /// Demo Gmail sign-in handler (UI-only stub). Sets a demo name and returns
  /// true so the UI can navigate to the Home screen. Replace with a real
  /// Google Sign-In flow when integrating authentication.
  bool signInWithGmail(BuildContext context) {
    // Demo behaviour: populate name and show a SnackBar
    nameController.text = 'Google User';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Gmail sign-in (demo)')));
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passController.dispose();
    super.dispose();
  }
}
