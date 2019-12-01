import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://cat-fact.herokuapp.com';
const String _RANDOM_FACT_PATH = _BASE_URL + '/facts/random';

class CatFactsResponse extends Advisable {
  CatFactsResponse._internal({this.id, this.text});

  factory CatFactsResponse.fromJson(Map<String, dynamic> json) =>
      CatFactsResponse._internal(id: json[_id_key], text: json[_text_key]);

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

  final String text;
  final String id;

  static const String _text_key = "text";
  static const String _id_key = "_id";
}

class CatFactsNetworkManager with CanMakeNetworkRequest<CatFactsResponse> {
  Future<NetworkResult<CatFactsResponse>> getRandomFact() async {
    return makeRequest(http.get(_RANDOM_FACT_PATH, headers: {'content-type': 'application/json'}), (response) {
      return CatFactsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
