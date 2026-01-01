class CashInConfigModel {
  String? status;
  String? message;
  CashInConfigData? data;

  CashInConfigModel({this.status, this.message, this.data});

  CashInConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? CashInConfigData.fromJson(json['data']) : null;
  }
}

class CashInConfigData {
  Settings? settings;

  CashInConfigData({this.settings});

  CashInConfigData.fromJson(Map<String, dynamic> json) {
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }
}

class Settings {
  String? minimumAmount;
  String? maximumAmount;
  String? dailyLimit;
  String? monthlyLimit;
  String? charge;
  String? chargeType;
  String? agentCommission;
  String? agentCommissionType;

  Settings({
    this.minimumAmount,
    this.maximumAmount,
    this.dailyLimit,
    this.monthlyLimit,
    this.charge,
    this.chargeType,
    this.agentCommission,
    this.agentCommissionType,
  });

  Settings.fromJson(Map<String, dynamic> json) {
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    dailyLimit = json['daily_limit'];
    monthlyLimit = json['monthly_limit'];
    charge = json['charge'];
    chargeType = json['charge_type'];
    agentCommission = json['agent_commission'];
    agentCommissionType = json['agent_commission_type'];
  }
}
