import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'http://numbersapi.com';
const String _GENERAL_TRIVIA_PATH = _BASE_URL + '/random/trivia?json';
const String _GENERAL_DATE_PATH = _BASE_URL + '/random/date?json';
const String _GENERAL_YEAR_PATH = _BASE_URL + '/random/year?json';
const String _GEEK_FACT_PATH = _BASE_URL + '/random/math?json';

class NumberFactsResponse extends Advisable {
  NumberFactsResponse._internal({this.text});

  factory NumberFactsResponse.fromJson(Map<String, dynamic> json) =>
      NumberFactsResponse._internal(text: json[_text_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: text.hashCode.toString(),
        mainContent: text,
        source: _BASE_URL,
        type: AdviceType.FACT,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String text;
  static const _text_key = "text";
}

class NumberFactsNetworkManager with CanMakeNetworkRequest<NumberFactsResponse> {
  Future<NetworkResult<NumberFactsResponse>> getTriviaFact() async {
    return makeRequest(http.get(_GENERAL_TRIVIA_PATH, headers: {'content-type': 'application/json'}), (response) {
      return NumberFactsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<NumberFactsResponse>> getDateFact() async {
    return makeRequest(http.get(_GENERAL_DATE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return NumberFactsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<NumberFactsResponse>> getYearFact() async {
    return makeRequest(http.get(_GENERAL_YEAR_PATH, headers: {'content-type': 'application/json'}), (response) {
      return NumberFactsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<NumberFactsResponse>> getGeekFact() async {
    return makeRequest(http.get(_GEEK_FACT_PATH, headers: {'content-type': 'application/json'}), (response) {
      return NumberFactsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
