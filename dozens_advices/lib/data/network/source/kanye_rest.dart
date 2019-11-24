import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://api.kanye.rest';

class KanyeRestResponse extends Advisable {
  KanyeRestResponse._internal({this.quote});

  factory KanyeRestResponse.fromJson(Map<String, dynamic> json) => KanyeRestResponse._internal(quote: json[_quote_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: quote.hashCode.toString(),
        mainContent: quote + "\n— Kanye West",
        source: _BASE_URL,
        type: AdviceType.QUOTE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String quote;

  static const _quote_key = "quote";
}

class KanyeRestNetworkManager with CanMakeNetworkRequest<KanyeRestResponse> {
  Future<NetworkResult<KanyeRestResponse>> getQuote() async {
    return makeRequest(http.get(_BASE_URL, headers: {'content-type': 'application/json'}), (response) {
      return KanyeRestResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
