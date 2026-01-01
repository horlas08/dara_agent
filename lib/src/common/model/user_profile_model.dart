class UserProfileModel {
  String? status;
  String? message;
  UserProfileData? data;

  UserProfileModel({this.status, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserProfileData.fromJson(json['data']) : null;
  }
}

class UserProfileData {
  User? user;

  UserProfileData({this.user});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? username;
  String? phone;
  String? country;
  String? gender;
  String? role;
  int? kyc;
  Agent? agent;
  String? createdAt;
  String? updatedAt;
  String? emailVerifiedAt;
  bool? google2faSecret;
  bool? twoFa;
  String? avatar;
  String? accountNumber;
  String? city;
  String? zipCode;
  String? address;
  String? dateOfBirth;
  BoardingSteps? boardingSteps;
  String? greetings;
  int? unreadNotificationsCount;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.username,
    this.phone,
    this.country,
    this.gender,
    this.role,
    this.kyc,
    this.agent,
    this.createdAt,
    this.updatedAt,
    this.emailVerifiedAt,
    this.google2faSecret,
    this.twoFa,
    this.avatar,
    this.accountNumber,
    this.city,
    this.zipCode,
    this.address,
    this.dateOfBirth,
    this.boardingSteps,
    this.greetings,
    this.unreadNotificationsCount,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    country = json['country'];
    gender = json['gender'];
    role = json['role'];
    kyc = json['kyc'];
    agent = json['agent'] != null ? Agent.fromJson(json['agent']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    emailVerifiedAt = json['email_verified_at'];
    google2faSecret = json['google2fa_secret'];
    twoFa = json['two_fa'];
    avatar = json['avatar'];
    accountNumber = json['account_number'];
    city = json['city'];
    zipCode = json['zip_code'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    boardingSteps = json['boarding_steps'] != null
        ? BoardingSteps.fromJson(json['boarding_steps'])
        : null;
    greetings = json['greetings'];
    unreadNotificationsCount = json['unread_notifications_count'];
  }
}

class Agent {
  String? status;
  bool? isRejected;
  String? rejectionReason;

  Agent({this.status, this.isRejected, this.rejectionReason});

  Agent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    isRejected = json['is_rejected'];
    rejectionReason = json['rejection_reason'];
  }
}

class BoardingSteps {
  bool? emailVerification;
  bool? passwordSetup;
  bool? personalInfo;
  bool? idVerification;
  bool? completed;

  BoardingSteps({
    this.emailVerification,
    this.passwordSetup,
    this.personalInfo,
    this.idVerification,
    this.completed,
  });

  BoardingSteps.fromJson(Map<String, dynamic> json) {
    emailVerification = json['email_verification'];
    passwordSetup = json['password_setup'];
    personalInfo = json['personal_info'];
    idVerification = json['id_verification'];
    completed = json['completed'];
  }
}
