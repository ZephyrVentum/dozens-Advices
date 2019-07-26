import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/slip_advice.dart';
import 'package:http/http.dart';

const SUCCESS_CODE = 200;

class NetworkService implements INetwork {
  NetworkManager _networkManager;

  static NetworkService _networkService;

  NetworkService._internal() {
    _networkManager = NetworkManager.getInstance();
  }

  factory NetworkService.getInstance() {
    if (_networkService == null) {
      _networkService = NetworkService._internal();
    }
    return _networkService;
  }

  Future<NetworkResult<SlipAdviceResponse>> getRandomSlipAdvice() {
    return _networkManager.getSlipAdviceNetworkManager().getSlipAdvice();
  }
}

abstract class INetwork {
  Future<NetworkResult<SlipAdviceResponse>> getRandomSlipAdvice();
}

class NetworkManager {
  static NetworkManager _instance;

  SlipAdviceNetworkManager _slipAdviceNetworkManager;

  NetworkManager._internal();

  factory NetworkManager.getInstance() {
    if (_instance == null) {
      _instance = NetworkManager._internal();
    }
    return _instance;
  }

  SlipAdviceNetworkManager getSlipAdviceNetworkManager() {
    if (_slipAdviceNetworkManager == null) {
      _slipAdviceNetworkManager = SlipAdviceNetworkManager();
    }
    return _slipAdviceNetworkManager;
  }
}

abstract class NetworkResult<T> {}

class SuccessNetworkResult<T> extends NetworkResult<T> {
  final T data;

  SuccessNetworkResult(this.data);
}

class FailureNetworkResult<T> extends NetworkResult<T> {
  final dynamic error;

  FailureNetworkResult(this.error);
}

mixin CanMakeNetworkRequest<T extends Advisable> {
  Future<NetworkResult<T>> makeRequest(
      Future<Response> networkCall, T Function(Response) onParse) async {
    try {
      final response = await networkCall;
      if (response.statusCode == SUCCESS_CODE) {
        return SuccessNetworkResult(onParse(response));
      } else {
        return FailureNetworkResult(response.body);
      }
    } catch (e) {
      return FailureNetworkResult(e.toString());
    }
  }
}
