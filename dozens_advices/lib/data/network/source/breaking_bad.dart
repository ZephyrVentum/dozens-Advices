import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://breaking-bad-quotes.herokuapp.com/v1/quotes';

class BreakingBadResponse extends Advisable {
  BreakingBadResponse._internal({this.quote, this.author});

  factory BreakingBadResponse.fromJson(Map<String, dynamic> json) =>
      BreakingBadResponse._internal(quote: json[_quote_key], author: json[_author_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: quote.hashCode.toString(),
        mainContent: quote + (author.isNotEmpty ? '\n—' + author : ''),
        source: _BASE_URL,
        type: AdviceType.QUOTE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String quote;
  final String author;
  static const _quote_key = "quote";
  static const _author_key = "author";
}

class BreakingBadNetworkManager with CanMakeNetworkRequest<BreakingBadResponse> {
  Future<NetworkResult<BreakingBadResponse>> getRandomQuote() async {
    return makeRequest(http.get(_BASE_URL, headers: {'content-type': 'application/json'}), (response) {
      return BreakingBadResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes))[0]);
    });
  }
}
