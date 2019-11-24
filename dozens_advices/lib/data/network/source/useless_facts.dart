import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://uselessfacts.jsph.pl';
const String _RANDOM_FACT_PATH = _BASE_URL + '/random.json?language=en';

class UselessFactsResponse extends Advisable {
  UselessFactsResponse._internal({this.id, this.text});

  factory UselessFactsResponse.fromJson(Map<String, dynamic> json) =>
      UselessFactsResponse._internal(id: json[_id_key], text: json[_text_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: id,
        mainContent: text,
        source: _BASE_URL,
        type: AdviceType.FACT,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String id;
  final String text;

  static const _id_key = "id";
  static const _text_key = "text";
}

class UselessFactsNetworkManager with CanMakeNetworkRequest<UselessFactsResponse> {
  Future<NetworkResult<UselessFactsResponse>> getUselessFact() async {
    return makeRequest(http.get(_RANDOM_FACT_PATH, headers: {'content-type': 'application/json'}), (response) {
      return UselessFactsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
