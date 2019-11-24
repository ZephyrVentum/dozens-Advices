import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'http://api.forismatic.com';
const String _GENERAL_QUOTE_PATH = _BASE_URL + '/api/1.0/?format=json&method=getQuote&lang=en';

class ForismaticResponse extends Advisable {
  ForismaticResponse._internal({this.quoteText, this.quoteAuthor});

  factory ForismaticResponse.fromJson(Map<String, dynamic> json) =>
      ForismaticResponse._internal(quoteText: json[_quote_text_key], quoteAuthor: json[_quote_author_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: quoteText.hashCode.toString(),
        mainContent: quoteText + (quoteAuthor.isNotEmpty ? '\n—' + quoteAuthor : ''),
        source: _BASE_URL,
        type: quoteAuthor.isNotEmpty ? AdviceType.QUOTE : AdviceType.ADVICE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String quoteText;
  final String quoteAuthor;
  static const _quote_text_key = "quoteText";
  static const _quote_author_key = "quoteAuthor";
}

class ForismaticNetworkManager with CanMakeNetworkRequest<ForismaticResponse> {
  Future<NetworkResult<ForismaticResponse>> getRandomQuote() async {
    return makeRequest(http.get(_GENERAL_QUOTE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return ForismaticResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes).replaceAll("\\'", "'")));
    });
  }
}
