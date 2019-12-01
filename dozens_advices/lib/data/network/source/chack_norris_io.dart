import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://api.chucknorris.io/jokes';
const String _MORALITY_PATH = _BASE_URL + '/random?category=explicit';
const String _POLITICAL_PATH = _BASE_URL + '/random?category=political';
const String _GEEK_PATH = _BASE_URL + '/random?category=dev';

class ChuckNorrisIOResponse extends Advisable {
  ChuckNorrisIOResponse._internal({this.id, this.value});

  factory ChuckNorrisIOResponse.fromJson(Map<String, dynamic> json) =>
      ChuckNorrisIOResponse._internal(id: json[_id_key], value: json[_value_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: id,
        mainContent: value,
        source: _BASE_URL,
        type: AdviceType.JOKE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String value;
  final String id;

  static const String _value_key = "value";
  static const String _id_key = "id";
}

class ChuckNorrisIONetworkManager with CanMakeNetworkRequest<ChuckNorrisIOResponse> {

  Future<NetworkResult<ChuckNorrisIOResponse>> getDarkJoke() async {
    return makeRequest(http.get(_MORALITY_PATH, headers: {'content-type': 'application/json'}), (response) {
      return ChuckNorrisIOResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<ChuckNorrisIOResponse>> getPoliticalJoke() async {
    return makeRequest(http.get(_POLITICAL_PATH, headers: {'content-type': 'application/json'}), (response) {
      return ChuckNorrisIOResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<ChuckNorrisIOResponse>> getGeekJoke() async {
    return makeRequest(http.get(_GEEK_PATH, headers: {'content-type': 'application/json'}), (response) {
      return ChuckNorrisIOResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
