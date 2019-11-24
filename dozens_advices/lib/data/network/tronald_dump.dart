import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://api.tronalddump.io';
const String _RANDOM_QUOTE_PATH = _BASE_URL + '/random/quote';

class TronaldDumpResponse extends Advisable {
  TronaldDumpResponse._internal({this.value, this.quoteId});

  factory TronaldDumpResponse.fromJson(Map<String, dynamic> json) =>
      TronaldDumpResponse._internal(value: json[_value_key], quoteId: json[_quote_id_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: quoteId,
        mainContent: value + "\n— Donald Trump",
        source: _BASE_URL,
        type: AdviceType.QUOTE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String value;
  final String quoteId;

  static const _value_key = "value";
  static const _quote_id_key = "quote_id";
}

class TronaldDumpNetworkManager with CanMakeNetworkRequest<TronaldDumpResponse> {
  Future<NetworkResult<TronaldDumpResponse>> getRandomQuote() async {
    return makeRequest(http.get(_RANDOM_QUOTE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return TronaldDumpResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
