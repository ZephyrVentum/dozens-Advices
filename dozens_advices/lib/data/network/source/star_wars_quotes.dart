import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = 'http://swquotesapi.digitaljedi.dk';
const String _RANDOM_QUOTE_PATH = _BASE_URL + '/api/SWQuote/RandomStarWarsQuote';

class StarWarsQuotesResponse extends Advisable {
  StarWarsQuotesResponse._internal({this.id, this.starWarsQuote});

  factory StarWarsQuotesResponse.fromJson(Map<String, dynamic> json) =>
      StarWarsQuotesResponse._internal(id: json[_id_key], starWarsQuote: json[_star_wars_quote_key]);

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: id.toString(),
        mainContent: starWarsQuote.replaceAll(' — ', '\n— '),
        source: _BASE_URL,
        type: AdviceType.QUOTE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  final String starWarsQuote;
  final int id;

  static const String _star_wars_quote_key = "starWarsQuote";
  static const String _id_key = "id";
}

class StarWarsQuotesNetworkManager with CanMakeNetworkRequest<StarWarsQuotesResponse> {
  Future<NetworkResult<StarWarsQuotesResponse>> getRandomQuote() async {
    return makeRequest(http.get(_RANDOM_QUOTE_PATH, headers: {'content-type': 'application/json'}), (response) {
      return StarWarsQuotesResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
