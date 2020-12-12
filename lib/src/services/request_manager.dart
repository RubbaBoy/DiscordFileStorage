import 'dart:convert';
import 'dart:html';

import 'package:DiscordFileStorage/src/constants.dart';
import 'package:DiscordFileStorage/src/request_objects.dart';
import 'package:DiscordFileStorage/src/services/auth_service.dart';
import 'package:angular/angular.dart';

@Injectable()
class RequestService {
  final AuthService authService;

  RequestService(this.authService);

  /// Makes a GET request with given headers. Returns JSON.
  Future<RequestResponse> makeRequest(String url,
          {String baseUrl = BASE_URL,
          Map<String, String> query,
          Map<String, String> requestHeaders,
          void Function(ProgressEvent e) onProgress}) =>
      HttpRequest.request('$baseUrl$url${joinQuery(query)}',
              method: 'GET',
              requestHeaders: requestHeaders,
              onProgress: onProgress)
          .then((HttpRequest xhr) =>
              RequestResponse(xhr.status, jsonDecode(xhr.responseText)));

  Future<RequestResponse> makeAuthedRequest(String url,
          {String baseUrl = BASE_URL,
          Map<String, dynamic> query = const {},
          Map<String, String> requestHeaders = const {}}) async =>
      makeRequest(url,
          baseUrl: baseUrl,
          query: query
              .map((k, v) => MapEntry(k, Uri.encodeComponent('${v ?? ''}'))),
          requestHeaders: {
            ...requestHeaders,
            ...{
              'Username': authService.username,
              'Password': authService.password
            }
          });

  String joinQuery(Map<String, dynamic> query) =>
      (query.isNotEmpty ? '?' : '') +
      query.entries.map((entry) => '${entry.key}=${entry.value}').join('&');

  Future<List<FetchedFile>> listFiles() async {
    var response = await makeAuthedRequest('/list');

    if (!response.success) {
      throw 'List request not successful. Code ${response.status}\n${response.json}';
    }

    return List.of(response.json['files'])
            .map<FetchedFile>((item) => FetchedFile.fromJson(item))
            .toList();
  }
}

class RequestResponse {
  int status;
  dynamic json;

  bool get success => status == 200;

  RequestResponse(this.status, this.json);
}
