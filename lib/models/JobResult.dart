import 'dart:convert';

class JobResult {
  final String jobId;
  final bool isSuccessful;
  final dynamic data;
  final String contentType;
  final String? error;

  JobResult({
    required this.jobId,
    required this.isSuccessful,
    this.contentType = '*/*',
    this.data,
    this.error,
  });

  Map<String, dynamic> toJson() {
    String res;
    if (data is Map) {
      res = jsonEncode(data);
    } else if (data is List) {
      res = jsonEncode(data);
    } else {
      res = data.toString();
    }
    return {
      'job': jobId,
      'status': isSuccessful ? 'SUCCESS' : 'FAILURE',
      'result': res,
      'content_type': contentType,
      'error': error,
    };
  }

  @override
  String toString() {
    return 'JobResult{jobId: $jobId, isSuccessful: $isSuccessful, data: $data, contentType: $contentType, error: $error}';
  }
}
