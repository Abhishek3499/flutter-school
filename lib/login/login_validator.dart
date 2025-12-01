String? nameValidator(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Name is required';
  }
  if (v.trim().length < 2) {
    return 'Name must be at least 2 characters';
  }
  return null;
}

bool isValidEmail(String value) {
  // Very small, permissive check used in the original UI
  return value.contains('@');
}

String? emailValidator(String? v) {
  if (v == null || v.isEmpty) return null;
  if (!isValidEmail(v)) return 'Valid email';
  return null;
}

String? phoneValidator(String? v) {
  final phone = v ?? '';
  // Phone is required now (we no longer support email-only login)
  if (phone.isEmpty) {
    return 'Phone ';
  }
  if (phone.isNotEmpty && phone.length != 10) {
    return 'Valid 10 digit number';
  }
  return null;
}

String? passwordValidator(String? v) {
  if (v == null || v.length < 6) {
    return 'Password minimum 6 characters';
  }
  return null;
}
