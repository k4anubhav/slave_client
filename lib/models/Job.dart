import 'package:flutter/foundation.dart';
import 'package:slave_client/models/payload.dart';

import 'JobResult.dart';

@immutable
class Job {
  final String id;
  final String? name;
  final String type;
  final int priority;
  final Payload payload;
  final int timeToReassign;
  final String createdAt;

  const Job({
    required this.id,
    required this.name,
    required this.type,
    required this.priority,
    required this.payload,
    required this.timeToReassign,
    required this.createdAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      priority: json['priority'],
      payload:
          Payload.fromJson(json['id'], json['payload'] ?? {}, json['type']),
      timeToReassign: json['time_to_reassign'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'priority': priority,
      'payload': payload,
      'time_to_reassign': timeToReassign,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return 'Job{id: $id, name: $name, type: $type, priority: $priority, payload: $payload, time_to_reassign: $timeToReassign, created_at: $createdAt}';
  }

  Future<JobResult> execute() {
    return payload.execute();
  }
}
