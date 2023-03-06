import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:retry/retry.dart';

import '../constants/network_config.dart';

@lazySingleton
class HttpServiceRequester {
  HttpServiceRequester({
    required this.dio,
  });

  final Dio dio;
  static const String BASE_URL_AUTH = "https://hookupcity.net/endpoint/v1/models/users/";


  Future<Response> post({
    required String endpoint,
    String? token,
    Object? body,
    String? contentType = Headers.formUrlEncodedContentType,
    Map? queryParam,
    Map<String, dynamic>? headers,
  }) async {
    dio.options.headers['Authorization'] = '$token';

    Logger().i(BASE_URL_AUTH + endpoint);
    Logger().d(body);
    final response = await retry(
      () => dio
          .post(
            BASE_URL_AUTH + endpoint,
            data: body,
            queryParameters: queryParam as Map<String, dynamic>?,
            options: Options(
              contentType: contentType,
              headers: headers,
            ),
          )
          .timeout(const Duration(seconds: 7)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) =>
          e is SocketException ||
          e is TimeoutException ||
          (e is DioError &&
              (e.type == DioErrorType.connectTimeout ||
                  e.type == DioErrorType.sendTimeout ||
                  e.type == DioErrorType.receiveTimeout)),
    );

    return response;
  }

  Future<Response> getRequest({
    required String endpoint,
    String? token,
    Map<String, dynamic>? queryParam,
  }) async {
    Options? options;
    dio.options.headers['Authorization'] = '$token';
    final response = await retry(
      () => dio
          .get(
            BASE_URL_AUTH + endpoint,
            options: options,
            queryParameters: queryParam,
          )
          .timeout(
            const Duration(
              seconds: 7,
            ),
          ),
      // Retry on SocketException or TimeoutException
      retryIf: (e) =>
          e is SocketException ||
          e is TimeoutException ||
          (e is DioError &&
              (e.type == DioErrorType.connectTimeout ||
                  e.type == DioErrorType.sendTimeout ||
                  e.type == DioErrorType.receiveTimeout)),
    );
    return response;
  }
}
