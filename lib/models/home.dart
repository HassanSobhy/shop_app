import 'data.dart';

class Home {
  bool status;
  Data data;

  Home({
    this.status,
    this.data,
  });

  Home.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}
