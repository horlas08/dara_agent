import 'dart:ui';

class TransactionDynamicColor {
  static Color getTransactionColor(String? type) {
    switch (type) {
      case "Credit":
        return Color(0xFFE4DDFF);
      case "Debit":
        return Color(0xFFDCE8C1);
      case "Deposit":
        return Color(0xFFCCC3FF);
      case "Manual Deposit":
        return Color(0xFFF9CAFF);
      case "Withdraw":
        return Color(0xFFE1E0FF);
      case "Withdraw Auto":
        return Color(0xFFBBEDAE);
      case "Send Money":
        return Color(0xFFFFD4D7);
      case "Receive Money":
        return Color(0xFFF2DCAC);
      case "Request Money":
        return Color(0xFFFFDE9C);
      case "Payment":
        return Color(0xFFA4FFDB);
      case "Invoice":
        return Color(0xFF78C841);
      case "Referral":
        return Color(0xFFD2FFFF);
      case "Signup Bonus":
        return Color(0xFFB7E9FE);
      case "Gift Redeemed":
        return Color(0xFFE4DAFF);
      case "Gift Card":
        return Color(0xFFDDDDDD);
      case "Cash In":
        return Color(0xFFF5DBAB);
      case "Cash In Commission":
        return Color(0xFFDBE5FF);
      case "Cash Out":
        return Color(0xFFC5C5FF);
      case "Cashout Commission":
        return Color(0xFFFFE7CE);
      case "Cash Received":
        return Color(0xFFBFEFDF);
      case "Refund":
        return Color(0xFFFFC2A8);
      case "Exchange":
        return Color(0xFFB0FBE5);
      default:
        return Color(0xFFE4DDFF);
    }
  }
}
