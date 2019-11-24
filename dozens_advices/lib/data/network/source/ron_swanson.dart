import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'http://ron-swanson-quotes.herokuapp.com/v2/quotes';

class RonSwansonResponse extends Advisable {
  RonSwansonResponse._internal({this.content});

  factory RonSwansonResponse.fromJson(String content) => RonSwansonResponse._internal(content: content);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: content.hashCode.toString(),
        mainContent: content + '\n— Ron Swanson',
        source: _BASE_URL,
        type: AdviceType.QUOTE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String content;
}

class RonSwansonNetworkManager with CanMakeNetworkRequest<RonSwansonResponse> {
  Future<NetworkResult<RonSwansonResponse>> getRandomQuote() async {
    return makeRequest(http.get(_BASE_URL, headers: {'content-type': 'application/json'}), (response) {
      return RonSwansonResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes))[0]);
    });
  }
}
