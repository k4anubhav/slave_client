import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:slave_client/main.dart';

import '../providers/auth_provider.dart';
import 'snackbar.dart';

InterceptorErrorCallback logoutInterceptor =
    (DioException e, ErrorInterceptorHandler handler) async {
  log('logoutInterceptor: ${e.message}');
  if (e.response?.statusCode == 401) {
    log('logoutInterceptor: ${e.message} - 401');
    showFailSnackBar(navigatorKey.currentContext!, 'Invalid Token');

    final authProvider =
        Provider.of<Auth>(navigatorKey.currentContext!, listen: false);
    await authProvider.logout();
  }
  if (e.response?.statusCode == 403) {
    log('logoutInterceptor: ${e.message} - 403');
    showFailSnackBar(navigatorKey.currentContext!, 'Invalid Token');

    final authProvider =
        Provider.of<Auth>(navigatorKey.currentContext!, listen: false);
    await authProvider.logout();
  }
  log('logoutInterceptor: ${e.message}');
  handler.next(e);
};

extension DioExtension on Dio {
  static Dio get(String? token, {bool addLogoutInterceptor = true}) {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      if (token != null) {
        options.headers['SLAVE-AUTH'] = 'Slave $token';
      }
      return handler.next(options);
    }));

    if (addLogoutInterceptor) {
      dio.interceptors.add(InterceptorsWrapper(onError: logoutInterceptor));
    }
    return dio;
  }
}
