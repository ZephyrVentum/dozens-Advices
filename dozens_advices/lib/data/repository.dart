import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/database/database.dart';
import 'package:dozens_advices/data/network/network_service.dart';

class Repository {
  NetworkService _networkService;
  DatabaseImpl _database;

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
    var networkResult = await _networkService.getRandomSlipAdvice();
    _complete(networkResult, completion);
  }

  _complete<I extends NetworkResult<Advisable>>(
      NetworkResult networkResult, Function(Result<Advice>) completion) async {
    if (networkResult is SuccessNetworkResult) {
      Advice advice = networkResult.data.toAdvice();
      if (await _isValid(advice)) {
        await _database.insertOrUpdateAdvice(advice);
        completion(SuccessResult(advice));
      } else {
        getRandomAdvice(completion);
      }
    } else if (networkResult is FailureNetworkResult) {
      completion(ErrorResult(networkResult.error));
    }
  }

  Future<bool> _isValid(Advice advice) async =>
      await _database.getExistingAdvice(advice) == null;
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
