import 'dart:convert';

import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _BASE_URL = "https://api.adviceslip.com";
const String _ADVICE_PATH = _BASE_URL + "/advice";

class SlipAdviceResponse extends Advisable {
  static const _SLIP_REMOTE_KEY = "slip";

  final _Slip slip;

  SlipAdviceResponse._internal({this.slip});

  factory SlipAdviceResponse.fromJson(Map<String, dynamic> json) =>
      SlipAdviceResponse._internal(slip: _Slip.fromJson(json[_SLIP_REMOTE_KEY]));

  @override
  Advice toAdvice() {
    return Advice(
        id: null,
        remoteId: slip.slipId,
        mainContent: slip.advice,
        source: _BASE_URL,
        type: AdviceType.ADVICE,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        viewedAt: DateTime.now().microsecondsSinceEpoch);
  }
}

class _Slip {
  static const _ADVICE_REMOTE_KEY = "advice";
  static const _SLIP_ID_REMOTE_KEY = "slip_id";

  final String advice;
  final String slipId;

  _Slip({this.advice, this.slipId});

  factory _Slip.fromJson(Map<String, dynamic> json) =>
      _Slip(advice: json[_ADVICE_REMOTE_KEY], slipId: json[_SLIP_ID_REMOTE_KEY]);
}

class SlipAdviceNetworkManager with CanMakeNetworkRequest<SlipAdviceResponse> {
  Future<NetworkResult<SlipAdviceResponse>> getSlipAdvice() async {
    return makeRequest(http.get(_ADVICE_PATH), (response) {
      return SlipAdviceResponse.fromJson(jsonDecode(response.body));
    });
  }
}
