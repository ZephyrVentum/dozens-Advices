import 'package:dozens_advices/data/database/database.dart';
import 'package:dozens_advices/data/network/slip_advice.dart';

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

  @override
  Future<NetworkResult<SlipAdviceResponse>> getRandomSlipAdvice() {
    return _networkManager.slipAdviceNetworkManager.getSlipAdvice();
  }
}

abstract class INetwork {
  Future<NetworkResult<SlipAdviceResponse>> getRandomSlipAdvice();
}

class NetworkManager {
  static NetworkManager _instance;

  SlipAdviceNetworkManager slipAdviceNetworkManager;

  NetworkManager._internal();

  factory NetworkManager.getInstance() {
    if (_instance == null) {
      _instance = NetworkManager._internal();
    }
    return _instance;
  }

  SlipAdviceNetworkManager getSlipAdviceNetworkManager() {
    if (slipAdviceNetworkManager == null) {
      slipAdviceNetworkManager = SlipAdviceNetworkManager();
    }
    return slipAdviceNetworkManager;
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
