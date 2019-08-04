import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/database/database.dart';
import 'package:dozens_advices/data/network/network_service.dart';

const _ATTEMPTS_COUNT = 5;

class Repository {
  NetworkService _networkService;
  DatabaseImpl _database;

  static Repository _repository;

  Repository._internal() {
    _networkService = NetworkService.getInstance();
    _database = DatabaseImpl.getInstance();
  }

  factory Repository.getInstance() {
    if (_repository == null) {
      _repository = Repository._internal();
    }
    return _repository;
  }

  Future<Result<Advice>> getRandomAdvice({attempt = 0}) async {
    var networkResult = await _networkService.getRandomSlipAdvice();
    return await _complete(networkResult, attempt);
  }

  Future<Result<Advice>> _complete<I extends NetworkResult<Advisable>>(
      NetworkResult networkResult, attempt) async {
    if (networkResult is SuccessNetworkResult) {
      Advice advice = networkResult.data.toAdvice();
      if (await _isValid(advice)) {
        await _database.insertOrUpdateAdvice(advice);
        return SuccessResult(advice);
      } else if (attempt < _ATTEMPTS_COUNT) {
        return getRandomAdvice(attempt: ++attempt);
      } else {
        return ErrorResult('Sorry. No data for you');
      }
    } else if (networkResult is FailureNetworkResult) {
      return ErrorResult(networkResult.error);
    } else {
      return ErrorResult('Ups. Something went wrong.');
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
