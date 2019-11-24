import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://official-joke-api.appspot.com';
const String _GENERAL_JOKE_PATH = _BASE_URL + '/jokes/general/random';
const String _GEEK_JOKE_PATH = _BASE_URL + '/jokes/programming/random';

class D15KatzResponse extends Advisable {
  D15KatzResponse._internal({this.id, this.setup, this.punchline});

  factory D15KatzResponse.fromJson(Map<String, dynamic> json) =>
      D15KatzResponse._internal(id: json[_id_key], setup: json[_setup_key], punchline: json[_punchline_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: id.toString(),
        mainContent: setup + "\n" + punchline,
        source: _BASE_URL,
        type: AdviceType.JOKE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String setup;
  final String punchline;
  final int id;

  static const _setup_key = "setup";
  static const _id_key = "id";
  static const _punchline_key = "punchline";
}

class D15KatzNetworkManager with CanMakeNetworkRequest<D15KatzResponse> {
  Future<NetworkResult<D15KatzResponse>> getGeneralJoke() async {
    return makeRequest(http.get(_GENERAL_JOKE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return D15KatzResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes))[0]);
    });
  }

  Future<NetworkResult<D15KatzResponse>> getGeekJoke() async {
    return makeRequest(http.get(_GEEK_JOKE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return D15KatzResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes))[0]);
    });
  }
}
