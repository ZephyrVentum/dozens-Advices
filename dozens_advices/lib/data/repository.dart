import 'package:dozens_advices/data/database/database.dart';
import 'package:dozens_advices/data/network/network_service.dart';

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
    _networkService.getRandomSlipAdvice().then((networkResult) {
      complete<Advice>(networkResult, completion);
    });
  }


  complete<T extends Advice>(NetworkResult<T> networkResult, Function(Result<T>) completion){
    if (networkResult is SuccessNetworkResult){

    } else if (networkResult is FailureNetworkResult){

    }
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
