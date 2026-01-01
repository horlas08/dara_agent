import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';

class NotificationDynamicIcon {
  static String getNotificationIcon(String? type) {
    switch (type) {
      case "agent_commission":
        return PngAssets.agentCommissionNotification;
      case "agent_ticket_reply":
        return PngAssets.agentTicketReplyNotification;
      case "agent_cashout_received":
        return PngAssets.agentCashOIutReceivedNotification;
      case "user_manual_deposit_rejected":
        return PngAssets.userManualDepositRejectedNotification;
      default:
        return PngAssets.agentCommissionNotification;
    }
  }
}
