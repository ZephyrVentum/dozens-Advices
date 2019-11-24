import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'https://api.whatdoestrumpthink.com';
const String _RANDOM_QUOTE_PATH = _BASE_URL + '/api/v1/quotes/random';

class TrumpThinkResponse extends Advisable {
  TrumpThinkResponse._internal({this.message});

  factory TrumpThinkResponse.fromJson(Map<String, dynamic> json) =>
      TrumpThinkResponse._internal(message: json[_message_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: message.hashCode.toString(),
        mainContent: message + "\n— Donald Trump",
        source: _BASE_URL,
        type: AdviceType.QUOTE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String message;

  static const _message_key = "message";
}

class TrumpThinkNetworkManager with CanMakeNetworkRequest<TrumpThinkResponse> {
  Future<NetworkResult<TrumpThinkResponse>> getRandomQuote() async {
    return makeRequest(http.get(_RANDOM_QUOTE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return TrumpThinkResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
