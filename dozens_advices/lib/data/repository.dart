import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/advice_provider.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/database/database.dart';
import 'package:dozens_advices/data/database/storage.dart' as storage;
import 'package:dozens_advices/data/network/network_service.dart';

class Repository {
  NetworkService _networkService;
  DatabaseImpl _database;
  AdviceProvider _adviceProvider;

  static Repository _repository;

  Repository._internal() {
    _networkService = NetworkService.getInstance();
    _database = DatabaseImpl.getInstance();
    _adviceProvider = AdviceProvider.getInstance(_networkService, _database);
  }

  factory Repository.getInstance() {
    if (_repository == null) {
      _repository = Repository._internal();
    }
    return _repository;
  }

  Future<Result<Advice>> getRandomAdvice() async {
    Configs configs = await getConfigs();
    return _adviceProvider.getRandomAdvice(configs: configs);
  }

  Future<List<Advice>> getAdvicesHistory() async {
    return _database.getAdvices();
  }

  Future<List<Advice>> getFavouriteAdvices() async {
    return _database.getFavouriteAdvices();
  }

  Future<Advice> markAdviceAsFavourite(int id, bool isFavourite) async {
    return _database.markAsFavourite(id, isFavourite);
  }

  updateAdviceLastSeen(int id) => _database.updateAdviceLastSeen(id);

  Future<Advice> setAdviceViews(int id, int views) async {
    return _database.setAdviceViews(id, views);
  }

  Future<List<Advice>> getAdvicesByType(String type) async {
    return _database.getAdvicesByType(type);
  }

  Future saveConfigs(Configs configs) async => storage.saveConfigs(configs);

  Future<Configs> getConfigs() async => storage.getConfigs();
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
