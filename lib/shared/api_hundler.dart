import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import '../exception/connection_time_out.dart';
import '../exception/no_internet_connection.dart';
import '../exception/un_defined_problem.dart';
import 'package:dio/dio.dart' as dioPackage;

class ApiHundler {
  // ApiHundler({required String endPoint}) {
  //   this.endPoint = endPoint;
  // }
  // static String endPoint = '';
  int timeOutConnection = 10;
  Uri apiLink = Uri.parse('');
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': '',
    'lang': 'ar',
    // Add other headers as needed
  };

  void setEndPoint(String endpoint) {
    apiLink = Uri.parse('${Constants.apiUrl}${endpoint}');
    // print(apiLink);
    // endPoint = endpoint;
  }

  void setToken(String token) {
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
      // Add other headers as needed
    };
    // print(headers);
  }

  void setTimeOutConnection(int timeOutConnection) {
    this.timeOutConnection = timeOutConnection;
  }

  get() async {
    // bool result = await InternetConnectionChecker().hasConnection;
    // if (result == true) {
    try {
      return await http.get(apiLink, headers: headers);
    } catch (e) {
      e.printError();
      if (e is TimeoutException) {
        throw ConnectionTimeOut();
      } else {
        throw UndefindProblem();
      }
    }
    // } else {
    // throw NoInternetConnection();
    // }
  }

  post({dynamic body}) async {
    // bool result = await InternetConnectionChecker().hasConnection;
    // if (result == true) {
    print("::::::::::> Api ${apiLink} Called");
    print("::::::::::> Api Body ${body}");
    try {
      var data = await http
          .post(apiLink, body: body, headers: headers)
          .timeout(Duration(seconds: timeOutConnection));
      print("::::::::::> Api ${apiLink} Finished");
      print("::::::::::> Api Response ${data}");
      print("::::::::::> Api Response ${data.body}");

      return data;
    } catch (e) {
      e.printError();
      print(e);
      if (e is TimeoutException) {
        throw ConnectionTimeOut();
      } else {
        throw UndefindProblem();
      }
    }
    // } else {
    //   throw NoInternetConnection();
    // }
  }

  put({dynamic body}) async {
    // bool result = await InternetConnectionChecker().hasConnection;
    // if (result == true) {
    print("::::::::::> Api ${apiLink} Called");
    print("::::::::::> Api Body ${body}");
    try {
      var data = await http
          .put(apiLink, body: body, headers: headers)
          .timeout(Duration(seconds: timeOutConnection));
      print("::::::::::> Api ${apiLink} Finished");
      print("::::::::::> Api Response ${data}");
      print("::::::::::> Api Response ${data.body}");

      return data;
    } catch (e) {
      e.printError();
      print(e);
      if (e is TimeoutException) {
        throw ConnectionTimeOut();
      } else {
        throw UndefindProblem();
      }
    }
    // } else {
    //   throw NoInternetConnection();
    // }
  }

  postMultiPartDate(
      {required Map<String, String> body,
      List<http.MultipartFile>? files,
      String? method,
      Map<String, dynamic>? arrayData}) async {
    try {
      var response;
      headers['Content-Type'] = 'multipart/form-data';

      var request = http.MultipartRequest(
        method ?? 'POST',
        apiLink,
      )
        ..headers.addAll(headers)
        ..fields.addAll(body);

      // print(request.fields);
      if (files != null) {
        for (http.MultipartFile element in files) {
          request.files.add(element);
        }
      }

      response = await request.send();
      // .timeout(
      // Duration(seconds: timeOutConnection),
      // )
      return await http.Response.fromStream(response);
      // return response.data;
    } catch (e) {
      if (e is TimeoutException) {
        throw ConnectionTimeOut();
      } else {
        throw UndefindProblem();
      }
    }
    // } else {
    //   throw NoInternetConnection();
    // }
  }

  postMultiPartDate1({
    required dioPackage.FormData body,
  }) async {
    // try {
    dioPackage.Dio dio = dioPackage.Dio();
    dioPackage.Response response = await dio.post(
      apiLink.toString(),
      data: body,
      options: dioPackage.Options(
        contentType: 'multipart/form-data',
        headers: headers['Authorization'] != null
            ? {'Authorization': headers['Authorization'], 'lang': 'ar'}
            : {'lang': 'ar'},
      ),
    );
    return response.data;
    // } catch (e) {
    // if (e is TimeoutException) {
    //   throw ConnectionTimeOut();
    // } else {
    //   throw UndefindProblem();
    // }
    // }
  }
  // static put() async{
  //   try {
  //     return await
  //   } catch (e) {

  //   }
  // }
  delete({Map<String, String>? body}) async {
    try {
      var data = await http
          .delete(apiLink, body: body, headers: headers)
          .timeout(Duration(seconds: timeOutConnection));

      return data;
    } catch (e) {
      if (e is TimeoutException) {
        throw ConnectionTimeOut();
      } else {
        throw UndefindProblem();
      }
    }
  }
}
