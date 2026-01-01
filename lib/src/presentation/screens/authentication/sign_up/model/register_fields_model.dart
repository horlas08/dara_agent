class RegisterFieldsModel {
  bool? status;
  List<RegisterFieldsData>? data;

  RegisterFieldsModel({this.status, this.data});

  RegisterFieldsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <RegisterFieldsData>[];
      json['data'].forEach((v) {
        data!.add(RegisterFieldsData.fromJson(v));
      });
    }
  }
}

class RegisterFieldsData {
  String? key;
  String? value;

  RegisterFieldsData({this.key, this.value});

  RegisterFieldsData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }
}
