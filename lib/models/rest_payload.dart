import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:slave_client/models/payload.dart';

import '../main.dart';
import '../util/snackbar.dart';
import 'JobResult.dart';

@immutable
class RestPayload extends Payload {
  late final String url;
  late final String method;
  late final Map<String, String>? headers;
  late final Map<String, dynamic>? body;

  RestPayload(String jobId, Map<String, dynamic> json) : super(jobId, json) {
    url = json['url'];
    method = json['method'];
    headers = json['headers'];
    body = json['body'];
  }

  @override
  Future<JobResult> execute() async {
    Dio dio = Dio();
    if (headers != null) {
      dio.options.headers.addAll(headers!);
    }
    var isSuccessful = false;
    String error = '';
    String contentType = '';
    dynamic responseData;
    try {
      if (method == 'GET') {
        var response = await dio.get(url);
        contentType = response.headers.map['content-type']?.first ?? '';
        responseData = response.data;
        isSuccessful = true;
      } else if (method == 'POST') {
        var response = await dio.post(url, data: body);
        contentType = response.headers.map['content-type']?.first ?? '';
        responseData = response.data;
        isSuccessful = true;
      } else {
        error = 'Unknown method';
      }
    } catch (e) {
      log('Error in RestPayload.execute(): $e');
      if (navigatorKey.currentState != null) {
        showFailSnackBar(
            navigatorKey.currentContext!, 'Error in RestPayload.execute(): $e');
      }
      error = e.toString();
    }
    return JobResult(
      jobId: jobId,
      isSuccessful: isSuccessful,
      contentType: contentType,
      data: responseData,
      error: error,
    );
  }

  @override
  String toString() {
    return 'RestPayload{url: $url, method: $method, headers: $headers, body: $body}';
  }
}
