// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'dart:developer';
import 'package:dio/dio.dart';

class DioHandler {
  static final Dio dio = Dio();
  // static const String baseUrl =
  //     "https://liveweare.com/newdemo/smileexcelnew/api/doctorapp/";
  static const String baseUrl2 =
      "https://liveweare.com/newdemo/smileexcelnew/api/doctorapp/";

//post method
  static Future<dynamic> dioPOST({
    required String endpoint,
    dynamic body, // Optional body
    Map<String, dynamic>? params, // Optional params
    Options,
  }) async {
    Map<String, dynamic> headers = {
      "content-type": "application/json",
    };
    dio.options.headers.addAll(headers);

    try {
      // Construct the final URL with query parameters if provided
      final uri =
          Uri.parse("$baseUrl2$endpoint").replace(queryParameters: params);

      // Make POST request with or without body
      Response response;
      if (body != null) {
        response = await dio
            .post(
              uri.toString(),
              data: body,
            )
            .timeout(const Duration(seconds: 60));
      } else {
        response = await dio
            .post(
              uri.toString(),
            )
            .timeout(const Duration(seconds: 60));
      }

      return response.data;
    } on DioException catch (e) {
      log("DioError: ${e.response?.data ?? e.message}");
      return {"error": "DioError: ${e.message}"};
    } catch (e) {
      log("Error: $e");
      return {"error": "Unknown error: $e"};
    }
  }

//get menthod
  static Future<dynamic> dioGET({required String endpoint}) async {
    try {
      final dio = Dio();
      final response = await dio.get('$baseUrl2$endpoint');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
