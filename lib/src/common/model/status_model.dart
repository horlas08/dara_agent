class StatusModel {
  bool? status;
  StatusData? data;

  StatusModel({this.status, this.data});

  StatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? StatusData.fromJson(json['data']) : null;
  }
}

class StatusData {
  List<Statuses>? statuses;

  StatusData({this.statuses});

  StatusData.fromJson(Map<String, dynamic> json) {
    if (json['statuses'] != null) {
      statuses = <Statuses>[];
      json['statuses'].forEach((v) {
        statuses!.add(Statuses.fromJson(v));
      });
    }
  }
}

class Statuses {
  String? name;
  String? value;

  Statuses({this.name, this.value});

  Statuses.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }
}
