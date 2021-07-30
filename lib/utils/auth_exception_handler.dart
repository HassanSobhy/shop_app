import 'package:dio/dio.dart';

class AuthExceptionHandler {
  /*
  static handleException(DioError dioError) {
    DioErrorType status;
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        status = DioErrorType.connectTimeout;
        break;
      case DioErrorType.cancel:
        status = DioErrorType.cancel;
        break;
      case DioErrorType.response:
        status = DioErrorType.response;
        break;
      case DioErrorType.receiveTimeout:
        status = DioErrorType.receiveTimeout;
        break;
      case DioErrorType.sendTimeout:
        status = DioErrorType.sendTimeout;
        break;
      default:
        status = DioErrorType.other;
      }
      return status;
    }
*/


  static String handleException(DioError dioError) {
    String errorMessage;
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = "Request to API server was cancelled.";
        break;
      case DioErrorType.connectTimeout:
        errorMessage = "Connection timeout with API server.";
        break;
      case DioErrorType.other:
        errorMessage = "Connection to API server failed due to internet connection.";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receive timeout in connection with API server.";
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "Send timeout in connection with API server.";
        break;
      case DioErrorType.response:
        errorMessage = _handleResponseError(dioError.response.statusCode,dioError.response.data);
        break;
      default:
        errorMessage = "Something went wrong.";
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
