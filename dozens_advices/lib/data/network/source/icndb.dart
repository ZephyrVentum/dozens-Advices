import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'http://api.icndb.com';
const String _MORALITY_JOKE_PATH = _BASE_URL + '/jokes/random?limitTo=[explicit]';
const String _GEEK_JOKE_PATH = _BASE_URL + '/jokes/random?limitTo=[nerdy]';

class ICNDbResponse extends Advisable {
  ICNDbResponse._internal({this.id, this.joke});

  factory ICNDbResponse.fromJson(Map<String, dynamic> json) =>
      ICNDbResponse._internal(id: json[_value_key][_id_key], joke: json[_value_key][_joke_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: id.toString(),
        mainContent: joke,
        source: _BASE_URL,
        type: AdviceType.JOKE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String joke;
  final int id;

  static const _value_key = "value";
  static const _id_key = "id";
  static const _joke_key = "joke";
}

class ICNDbNetworkManager with CanMakeNetworkRequest<ICNDbResponse> {
  Future<NetworkResult<ICNDbResponse>> getMoralityJoke() async {
    return makeRequest(http.get(_MORALITY_JOKE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return ICNDbResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<ICNDbResponse>> getGeekJoke() async {
    return makeRequest(http.get(_GEEK_JOKE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return ICNDbResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
