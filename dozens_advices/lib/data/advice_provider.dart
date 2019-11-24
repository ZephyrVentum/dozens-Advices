import 'dart:math';

import 'package:dozens_advices/bloc/configure/configure_state.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/database/database.dart';
import 'package:dozens_advices/data/database/storage.dart' as storage;
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

  Future<Result<Advice>> getRandomAdvice({int attempt = 0}) async {
    Configs configs = await storage.getConfigs();
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
    List<Future<NetworkResult<Advisable>> Function()> endPoints = [
      () async => await _networkService.getSlipAdvice(),
      () async => await _networkService.getSV443GeneralAdvice(noPolitics: noPolitics),
      () async => await _networkService.getUselessFact(),
      () async => await _networkService.getKanyeWestQuote(),
    ];
    return await _complete(endPoints[Random().nextInt(endPoints.length)], attempt);
  }

  Future<Result<Advice>> getMoralityAdvice(int attempt, {bool noPolitics = false}) async {
    List<Future<NetworkResult<Advisable>> Function()> endPoints = [
      () async => await _networkService.getSV443MoralityAdvice(noPolitics: noPolitics)
    ];
    return await _complete(endPoints[Random().nextInt(endPoints.length)], attempt);
  }

  Future<Result<Advice>> getPoliticsAdvice(int attempt) async {
    List<Future<NetworkResult<Advisable>> Function()> endPoints = [
      () async => await _networkService.getSV443GeneralAdvice(noPolitics: false),
      () async => await _networkService.getTrumpThinkQuote(),
      () async => await _networkService.getTronaldDumpQuote()
    ];
    return await _complete(endPoints[Random().nextInt(endPoints.length)], attempt);
  }

  Future<Result<Advice>> getGeekAdvice(int attempt, {bool noPolitics = false}) async {
    List<Future<NetworkResult<Advisable>> Function()> endPoints = [
      () async => await _networkService.getSV443GeekAdvice(noPolitics: noPolitics)
    ];
    return await _complete(endPoints[Random().nextInt(endPoints.length)], attempt);
  }

  Future<Result<Advice>> _complete<I extends NetworkResult<Advisable>>(
      Future<NetworkResult<Advisable>> Function() endPoint, attempt) async {
    try {
      NetworkResult networkResult = await endPoint();
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
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  Future<bool> _isValid(Advice advice) async {
    Advice existingAdvice = await _database.getExistingAdvice(advice);
    return (existingAdvice == null) || (existingAdvice.mainContent != advice.mainContent);
  }
}
