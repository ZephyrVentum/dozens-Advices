import 'package:dozens_advices/data/database/Advice.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:dozens_advices/data/network/slip_advice.dart';

class Repository {
  NetworkService _networkService;

  static Repository _repository;

  Repository._internal() {
    _networkService = NetworkService.getInstance();
  }

  factory Repository.getInstance() {
    if (_repository == null) {
      _repository = Repository._internal();
    }
    return _repository;
  }

  void getRandomAdvice(Function(Result<Advice>) completion) async {
    _networkService
        .getRandomSlipAdvice()
        .then((NetworkResult<SlipAdviceResponse> networkResult) {
      _complete(networkResult, completion);
    });
  }

  _complete<I extends NetworkResult<Advisable>>(
      NetworkResult networkResult, Function(Result<Advice>) completion) {
    if (networkResult is SuccessNetworkResult) {
      completion(SuccessResult((networkResult.data as Advisable).toAdvice()));
    } else if (networkResult is FailureNetworkResult) {
      completion(ErrorResult(networkResult.error));
    }
  }

  _validateAndSave(){

  }
}

abstract class Result<T> {}

class ErrorResult<T> extends Result<T> {
  final dynamic error;

  ErrorResult(this.error);
}

class SuccessResult<T> extends Result<T> {
  final T data;

  SuccessResult(this.data);
}
