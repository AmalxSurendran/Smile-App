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
    required dynamic body,
  }) async {
    Map<String, dynamic> headers = {
      "content-type": "application/json",
    };
    dio.options.headers.addAll(headers);
    try {
      Response response = await dio
          .post(
            "$baseUrl2$endpoint",
            data: body,
          )
          .timeout(const Duration(seconds: 60));

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
