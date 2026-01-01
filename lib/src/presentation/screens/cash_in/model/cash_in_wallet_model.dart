class CashInWalletModel {
  String? status;
  String? message;
  CashInWalletData? data;

  CashInWalletModel({this.status, this.message, this.data});

  CashInWalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? CashInWalletData.fromJson(json['data']) : null;
  }
}

class CashInWalletData {
  List<Wallets>? wallets;

  CashInWalletData({this.wallets});

  CashInWalletData.fromJson(Map<String, dynamic> json) {
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(Wallets.fromJson(v));
      });
    }
  }
}

class Wallets {
  int? id;
  String? name;
  String? accountNo;
  String? balance;
  String? formattedBalance;
  String? code;
  String? symbol;
  String? icon;
  bool? isDefault;
  bool? isCrypto;
  int? currencyId;
  CashinLimit? cashinLimit;
  String? conversionRate;

  Wallets({
    this.id,
    this.name,
    this.accountNo,
    this.balance,
    this.formattedBalance,
    this.code,
    this.symbol,
    this.icon,
    this.isDefault,
    this.isCrypto,
    this.currencyId,
    this.cashinLimit,
    this.conversionRate,
  });

  Wallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountNo = json['account_no'];
    balance = json['balance'];
    formattedBalance = json['formatted_balance'];
    code = json['code'];
    symbol = json['symbol'];
    icon = json['icon'];
    isDefault = json['is_default'];
    isCrypto = json['is_crypto'];
    currencyId = json['currency_id'];
    cashinLimit =
        json['cashin_limit'] != null
            ? CashinLimit.fromJson(json['cashin_limit'])
            : null;
    conversionRate = json['conversion_rate'];
  }
}

class CashinLimit {
  String? min;
  String? max;

  CashinLimit({this.min, this.max});

  CashinLimit.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }
}
