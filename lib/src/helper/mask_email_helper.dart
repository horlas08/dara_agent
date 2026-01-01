class MaskEmailHelper {
  static String maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return email;

    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];
    final visiblePart =
        username.length > 4 ? username.substring(0, 4) : username;
    final maskedPart = '*' * (username.length > 4 ? username.length - 4 : 0);

    return '$visiblePart$maskedPart@$domain';
  }
}
