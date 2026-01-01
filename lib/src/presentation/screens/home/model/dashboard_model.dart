class DashboardModel {
  String? status;
  String? message;
  DashboardData? data;

  DashboardModel({this.status, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
  }
}

class DashboardData {
  List<Transactions>? transactions;
  List<Wallets>? wallets;

  DashboardData({this.transactions, this.wallets});

  DashboardData.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(Wallets.fromJson(v));
      });
    }
  }
}

class Transactions {
  String? description;
  String? tnx;
  bool? isPlus;
  String? type;
  String? amount;
  String? charge;
  String? finalAmount;
  String? status;
  String? method;
  String? createdAt;
  String? payCurrency;
  String? payAmount;
  String? walletType;
  bool? isCrypto;
  String? trxCurrency;
  String? trxCurrencySymbol;
  String? trxCurrencyCode;

  Transactions({
    this.description,
    this.tnx,
    this.isPlus,
    this.type,
    this.amount,
    this.charge,
    this.finalAmount,
    this.status,
    this.method,
    this.createdAt,
    this.payCurrency,
    this.payAmount,
    this.walletType,
    this.isCrypto,
    this.trxCurrency,
    this.trxCurrencySymbol,
    this.trxCurrencyCode,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    tnx = json['tnx'];
    isPlus = json['is_plus'];
    type = json['type'];
    amount = json['amount'];
    charge = json['charge'];
    finalAmount = json['final_amount'];
    status = json['status'];
    method = json['method'];
    createdAt = json['created_at'];
    payCurrency = json['pay_currency'];
    payAmount = json['pay_amount'];
    walletType = json['wallet_type'];
    isCrypto = json['is_crypto'];
    trxCurrency = json['trx_currency'];
    trxCurrencySymbol = json['trx_currency_symbol'];
    trxCurrencyCode = json['trx_currency_code'];
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
    conversionRate = json['conversion_rate'];
  }
}
