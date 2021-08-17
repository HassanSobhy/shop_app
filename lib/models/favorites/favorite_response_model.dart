class FavoriteResponseModel {
  bool status;
  String message;

  FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
