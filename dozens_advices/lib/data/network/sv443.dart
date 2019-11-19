import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = "https://sv443.net/jokeapi";
const String _GEEK_CATEGORY = _BASE_URL + '/category/Programming';
const String _MORALITY_CATEGORY = _BASE_URL + '/category/Dark';
const String _NO_POLITICS = '?blacklistFlags=political';
const String _GENERAL_CATEGORY = _BASE_URL + '/category/Miscellaneous';

class Sv443Response extends Advisable {
  final String category;
  final String type;
  final String setup;
  final String delivery;
  final String joke;
  final int id;

  Sv443Response._internal({this.category, this.type, this.setup, this.delivery, this.joke, this.id});

  factory Sv443Response.fromJson(Map<String, dynamic> json) => Sv443Response._internal(
      category: json[category_key],
      type: json[type_key],
      setup: json[setup_key],
      delivery: json[delivery_key],
      joke: json[joke_key],
      id: json[id_key]);

  @override
  Advice toAdvice() {
    String mainContent;
    if (joke != null) {
      mainContent = joke;
    } else {
      mainContent = "$setup\n$delivery";
    }
    return Advice(
        id: null,
        remoteId: id.toString(),
        mainContent: mainContent,
        source: _BASE_URL,
        type: AdviceType.JOKE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }

  static const category_key = "category";
  static const type_key = "type";
  static const setup_key = "setup";
  static const delivery_key = "delivery";
  static const joke_key = "joke";
  static const id_key = "id";
}

class Sv443NetworkManager with CanMakeNetworkRequest<Sv443Response> {
  Future<NetworkResult<Sv443Response>> getMoralityAdvice({bool noPolitics = false}) async {
    return makeRequest(
        http.get(_MORALITY_CATEGORY + (noPolitics ? _NO_POLITICS : ''), headers: {'content-type': 'application/json'}),
        (response) {
          return Sv443Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<Sv443Response>> getGeekAdvice({bool noPolitics = false}) async {
    return makeRequest(
        http.get(_GEEK_CATEGORY + (noPolitics ? _NO_POLITICS : ''), headers: {'content-type': 'application/json'}),
        (response) {
          return Sv443Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }

  Future<NetworkResult<Sv443Response>> getGeneralAdvice({bool noPolitics = false}) async {
    return makeRequest(
        http.get(_GENERAL_CATEGORY + (noPolitics ? _NO_POLITICS : ''), headers: {'content-type': 'application/json'}),
        (response) {
      return Sv443Response.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    });
  }
}
