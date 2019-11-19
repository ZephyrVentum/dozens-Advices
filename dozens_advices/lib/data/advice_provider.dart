import 'dart:math';

import 'package:dozens_advices/bloc/configure/configure_state.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/database/database.dart';
import 'package:dozens_advices/data/network/network_service.dart';
import 'package:dozens_advices/data/repository.dart';

const _MAX_ATTEMPTS_TO_GET_ADVICE = 5;

class AdviceProvider {
  final NetworkService _networkService;
  final DatabaseImpl _database;

  static AdviceProvider _adviceProvider;

  AdviceProvider._internal(this._networkService, this._database);

  factory AdviceProvider.getInstance(NetworkService networkService, DatabaseImpl databaseImpl) {
    if (_adviceProvider == null) {
      _adviceProvider = AdviceProvider._internal(networkService, databaseImpl);
    }
    return _adviceProvider;
  }

  Future<Result<Advice>> getRandomAdvice({Configs configs, int attempt = 0}) {
    double bound = configs.morality + configs.politics + configs.geek;
    double generalTypeAdvicesFrequency = bound * 0.25;
    bound += generalTypeAdvicesFrequency;
    Random random = Random();
    double randomValueBetweenZeroAndBound = random.nextDouble() * bound;
    if (randomValueBetweenZeroAndBound >= 0 && randomValueBetweenZeroAndBound < configs.morality) {
      return getMoralityAdvice(attempt, noPolitics: configs.politics == 0);
    } else if (randomValueBetweenZeroAndBound >= configs.morality &&
        randomValueBetweenZeroAndBound < configs.morality + configs.politics) {
      return getPoliticsAdvice(attempt);
    } else if (randomValueBetweenZeroAndBound >= configs.morality + configs.politics &&
        randomValueBetweenZeroAndBound < configs.morality + configs.politics + configs.geek) {
      return getGeekAdvice(attempt, noPolitics: configs.politics == 0);
    } else {
      return getGeneralAdvice(attempt, noPolitics: configs.politics == 0);
    }
  }

  Future<Result<Advice>> getGeneralAdvice(int attempt, {bool noPolitics = false}) async {
    int randomValue = Random().nextInt(2);
    var networkResult;
    switch (randomValue) {
      case 0:
        networkResult = await _networkService.getSlipAdvice();
        break;
      case 1:
        networkResult = await _networkService.getSV443GeneralAdvice(noPolitics: noPolitics);
        break;
    }
    return await _complete(networkResult, attempt);
  }

  Future<Result<Advice>> getMoralityAdvice(int attempt, {bool noPolitics = false}) async {
    int randomValue = 0; //Random().nextInt(2);
    var networkResult;
    switch (randomValue) {
      case 0:
        networkResult = await _networkService.getSV443MoralityAdvice(noPolitics: noPolitics);
        break;
    }
    return await _complete(networkResult, attempt);
  }

  Future<Result<Advice>> getPoliticsAdvice(int attempt) async {
    int randomValue = 0;//Random().nextInt(2);
    var networkResult;
    switch (randomValue) {
      case 0:
        networkResult = await _networkService.getSV443GeneralAdvice(noPolitics: false);
        break;
    }
    return await _complete(networkResult, attempt);
  }

  Future<Result<Advice>> getGeekAdvice(int attempt, {bool noPolitics = false}) async {
    int randomValue = 0; //Random().nextInt(2);
    var networkResult;
    switch (randomValue) {
      case 0:
        networkResult = await _networkService.getSV443GeekAdvice(noPolitics: noPolitics);
        break;
    }
    return await _complete(networkResult, attempt);
  }

  Future<Result<Advice>> _complete<I extends NetworkResult<Advisable>>(NetworkResult networkResult, attempt) async {
    if (networkResult is SuccessNetworkResult) {
      Advice advice = networkResult.data.toAdvice();
      if (await _isValid(advice)) {
        await _database.insertOrUpdateAdvice(advice);
        return SuccessResult(advice);
      } else if (attempt < _MAX_ATTEMPTS_TO_GET_ADVICE) {
        return getRandomAdvice(attempt: ++attempt);
      } else {
        return ErrorResult('Sorry. No data for you =(');
      }
    } else if (networkResult is FailureNetworkResult) {
      return ErrorResult(networkResult.error);
    } else {
      return ErrorResult('Ups. Something went wrong.');
    }
  }

  Future<bool> _isValid(Advice advice) async => await _database.getExistingAdvice(advice) == null;
}
