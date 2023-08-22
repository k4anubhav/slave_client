
import 'package:flutter/material.dart';
import 'package:slave_client/models/JobResult.dart';
import 'package:slave_client/models/rest_payload.dart';

@immutable
abstract class Payload {
  final String jobId;
  const Payload(this.jobId, Map<String, dynamic> json);

  factory Payload.fromJson(String jobId, Map<String, dynamic> json, String type) {
    switch (type) {
      case "REST":
        return RestPayload(jobId, json);
      default:
        throw Exception("Unknown payload type");
    }
  }

  Future<JobResult> execute();
}