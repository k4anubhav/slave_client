import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mutex/mutex.dart';
import 'package:provider/provider.dart';
import 'package:slave_client/providers/auth_provider.dart';
import 'package:slave_client/util/consts.dart';
import 'package:slave_client/util/dio.dart';
import 'package:slave_client/util/snackbar.dart';

import 'main.dart';
import 'models/Job.dart';
import 'models/JobResult.dart';

class BgWork {
  static Timer? _bgTimer;
  static final Mutex _lock = Mutex();

  static void disableTimer() {
    _bgTimer?.cancel();
    _bgTimer = null;
  }

  static void enableTimer() {
    _bgTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      bgWork();
    });
  }

  static Future<void> bgWork() async {
    if (_lock.isLocked) {
      log('bgWork skip, locked');
      return;
    }
    await _lock.protect(() async {
      _criticalWork();
    });
  }

  static Future<void> _criticalWork() async {
    log('Critical work started');
    var authProvider =
        Provider.of<Auth>(navigatorKey.currentContext!, listen: false);
    Dio dio = DioExtension.get(authProvider.token);
    try {
      var jobResponse = await dio.get('$baseUrl/core/job/get-assigned/');
      var jobData = jobResponse.data;
      log('JobData: $jobData');
      Job job = Job.fromJson(jobData);
      log('Job: $job');
      var jobResult = await job.execute();
      log('JobResult: $jobResult');
      var success = await sendJobResult(jobResult);
      log('JobResult sent: $success');
      log('Critical work finished');
    } on DioException catch (e) {
      if (e.response?.statusCode != 404) rethrow;
    } catch (e) {
      log('Error while executing job: $e');
      if (navigatorKey.currentState != null) {
        showFailSnackBar(
            navigatorKey.currentContext!, 'Error while executing job: $e');
      }
      log('Critical work failed');
    }
  }

  static Future<bool> sendJobResult(JobResult result) async {
    var authProvider =
        Provider.of<Auth>(navigatorKey.currentContext!, listen: false);
    Dio dio = DioExtension.get(authProvider.token);
    try {
      var response =
          await dio.post('$baseUrl/core/job/result/', data: result.toJson());
      return response.statusCode == 200;
    } on Exception catch (e) {
      log('Error sending job result: $e');
      if (navigatorKey.currentState != null) {
        showFailSnackBar(
            navigatorKey.currentContext!, 'Error sending job result: $e');
      }
      return false;
    }
  }
}
