import 'dart:convert';

import 'package:dozens_advices/data/network/network_service.dart';
import 'package:http/http.dart' as http;

const String _ADVICE_PATH = "https://api.adviceslip.com/advice";

class SlipAdviceResponse {
  static const _SLIP_REMOTE_KEY = "slip";

  final Slip slip;

  SlipAdviceResponse({this.slip});

  factory SlipAdviceResponse.fromJson(Map<String, dynamic> json) =>
      SlipAdviceResponse(slip: Slip.fromJson(json[_SLIP_REMOTE_KEY]));
}

class Slip {
  static const _ADVICE_REMOTE_KEY = "advice";
  static const _SLIP_ID_REMOTE_KEY = "slip_id";

  final String advice;
  final String slipId;

  Slip({this.advice, this.slipId});

  factory Slip.fromJson(Map<String, dynamic> json) =>
      Slip(advice: json[_ADVICE_REMOTE_KEY], slipId: json[_SLIP_ID_REMOTE_KEY]);
}

class SlipAdviceNetworkManager {
  Future<NetworkResult<SlipAdviceResponse>> getSlipAdvice() async {
    final response = await http.get(_ADVICE_PATH);
    if (response.statusCode == SUCCESS_CODE) {
      return SuccessNetworkResult(
          SlipAdviceResponse.fromJson(json.decode(response.body)));
    } else {
      return FailureNetworkResult(response.body);
    }
  }
}
