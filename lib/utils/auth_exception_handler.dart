import 'package:dio/dio.dart';

class AuthExceptionHandler {
  static String handleException(DioError dioError) {
    String errorMessage;
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = "Request to server was cancelled.";
        break;
      case DioErrorType.connectTimeout:
        errorMessage =
            "Looks like the server is taking to long to respond, please try again in sometime.";
        break;
      case DioErrorType.other:
        errorMessage =
            "Looks like you have an unstable network at the moment, please try again when network stabilizes.";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage =
            "Looks like the server is taking to long to respond, please try again in sometime.";
        break;
      case DioErrorType.sendTimeout:
        errorMessage =
            "Looks like the server is taking to long to respond, please try again in sometime.";
        break;
      case DioErrorType.response:
        errorMessage = _handleResponseError(
            dioError.response.statusCode, dioError.response.data);
        break;
      default:
        errorMessage =
            "Looks like the server is taking to long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while.";
    }

    return errorMessage;
  }

  static String _handleResponseError(int statusCode, dynamic error) {
    final String errorMessage = error["message"];
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return errorMessage;
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
