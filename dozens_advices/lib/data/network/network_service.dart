import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/network/source/15d_katz.dart';
import 'package:dozens_advices/data/network/source/forismatic_com.dart';
import 'package:dozens_advices/data/network/source/icndb.dart';
import 'package:dozens_advices/data/network/source/kanye_rest.dart';
import 'package:dozens_advices/data/network/source/numbers_facts.dart';
import 'package:dozens_advices/data/network/source/slip_advice.dart';
import 'package:dozens_advices/data/network/source/sv443.dart';
import 'package:dozens_advices/data/network/source/tronald_dump.dart';
import 'package:dozens_advices/data/network/source/trump_think.dart';
import 'package:dozens_advices/data/network/source/useless_facts.dart';
import 'package:http/http.dart';

const SUCCESS_CODE = 200;

class NetworkService {
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

  Future<NetworkResult<SlipAdviceResponse>> getSlipAdvice() {
    return _networkManager.getSlipAdviceNetworkManager().getSlipAdvice();
  }

  Future<NetworkResult<Sv443Response>> getSV443MoralityAdvice({bool noPolitics = false}) {
    return _networkManager.getSv443NetworkManager().getMoralityAdvice(noPolitics: noPolitics);
  }

  Future<NetworkResult<Sv443Response>> getSV443GeekAdvice({bool noPolitics = false}) {
    return _networkManager.getSv443NetworkManager().getGeekAdvice(noPolitics: noPolitics);
  }

  Future<NetworkResult<Sv443Response>> getSV443GeneralAdvice({bool noPolitics = false}) {
    return _networkManager.getSv443NetworkManager().getGeneralAdvice(noPolitics: noPolitics);
  }

  Future<NetworkResult<TrumpThinkResponse>> getTrumpThinkQuote() {
    return _networkManager.getTrumpThinkNetworkManager().getRandomQuote();
  }

  Future<NetworkResult<UselessFactsResponse>> getUselessFact() {
    return _networkManager.getUselessFactsNetworkManager().getUselessFact();
  }

  Future<NetworkResult<TronaldDumpResponse>> getTronaldDumpQuote() {
    return _networkManager.getTronaldDumpNetworkManager().getRandomQuote();
  }

  Future<NetworkResult<KanyeRestResponse>> getKanyeWestQuote() {
    return _networkManager.getKanyeRestNetworkManager().getQuote();
  }

  Future<NetworkResult<ICNDbResponse>> getICNDbGeekJoke() {
    return _networkManager.getICNDbNetworkManager().getGeekJoke();
  }

  Future<NetworkResult<ICNDbResponse>> getICNDbMoralityJoke() {
    return _networkManager.getICNDbNetworkManager().getMoralityJoke();
  }

  Future<NetworkResult<D15KatzResponse>> getD15KatzGeekJoke() {
    return _networkManager.getD15KatzNetworkManager().getGeekJoke();
  }

  Future<NetworkResult<D15KatzResponse>> getD15KatzGeneralJoke() {
    return _networkManager.getD15KatzNetworkManager().getGeneralJoke();
  }

  Future<NetworkResult<NumberFactsResponse>> getDateNumberFact() {
    return _networkManager.getNumberFactsNetworkManager().getDateFact();
  }

  Future<NetworkResult<NumberFactsResponse>> getYearNumberFact() {
    return _networkManager.getNumberFactsNetworkManager().getYearFact();
  }

  Future<NetworkResult<NumberFactsResponse>> getTriviaNumberFact() {
    return _networkManager.getNumberFactsNetworkManager().getTriviaFact();
  }

  Future<NetworkResult<NumberFactsResponse>> getGeekNumberFact() {
    return _networkManager.getNumberFactsNetworkManager().getGeekFact();
  }

  Future<NetworkResult<ForismaticResponse>> getForismaticQuoteOrAdvice() {
    return _networkManager.getForismaticNetworkManager().getRandomQuote();
  }
}

class NetworkManager {
  static NetworkManager _instance;

  SlipAdviceNetworkManager _slipAdviceNetworkManager;
  Sv443NetworkManager _sv443networkManager;
  TrumpThinkNetworkManager _trumpThinkNetworkManager;
  UselessFactsNetworkManager _uselessFactsNetworkManager;
  TronaldDumpNetworkManager _tronaldDumpNetworkManager;
  KanyeRestNetworkManager _kanyeRestNetworkManager;
  ICNDbNetworkManager _icnDbNetworkManager;
  D15KatzNetworkManager _d15katzNetworkManager;
  NumberFactsNetworkManager _numberFactsNetworkManager;
  ForismaticNetworkManager _forismaticNetworkManager;

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

  Sv443NetworkManager getSv443NetworkManager() {
    if (_sv443networkManager == null) {
      _sv443networkManager = Sv443NetworkManager();
    }
    return _sv443networkManager;
  }

  TrumpThinkNetworkManager getTrumpThinkNetworkManager() {
    if (_trumpThinkNetworkManager == null) {
      _trumpThinkNetworkManager = TrumpThinkNetworkManager();
    }
    return _trumpThinkNetworkManager;
  }

  UselessFactsNetworkManager getUselessFactsNetworkManager() {
    if (_uselessFactsNetworkManager == null) {
      _uselessFactsNetworkManager = UselessFactsNetworkManager();
    }
    return _uselessFactsNetworkManager;
  }

  TronaldDumpNetworkManager getTronaldDumpNetworkManager() {
    if (_tronaldDumpNetworkManager == null) {
      _tronaldDumpNetworkManager = TronaldDumpNetworkManager();
    }
    return _tronaldDumpNetworkManager;
  }

  KanyeRestNetworkManager getKanyeRestNetworkManager() {
    if (_kanyeRestNetworkManager == null) {
      _kanyeRestNetworkManager = KanyeRestNetworkManager();
    }
    return _kanyeRestNetworkManager;
  }

  ICNDbNetworkManager getICNDbNetworkManager() {
    if (_icnDbNetworkManager == null) {
      _icnDbNetworkManager = ICNDbNetworkManager();
    }
    return _icnDbNetworkManager;
  }

  D15KatzNetworkManager getD15KatzNetworkManager() {
    if (_d15katzNetworkManager == null) {
      _d15katzNetworkManager = D15KatzNetworkManager();
    }
    return _d15katzNetworkManager;
  }

  NumberFactsNetworkManager getNumberFactsNetworkManager() {
    if (_numberFactsNetworkManager == null) {
      _numberFactsNetworkManager = NumberFactsNetworkManager();
    }
    return _numberFactsNetworkManager;
  }

  ForismaticNetworkManager getForismaticNetworkManager() {
    if (_forismaticNetworkManager == null) {
      _forismaticNetworkManager = ForismaticNetworkManager();
    }
    return _forismaticNetworkManager;
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
  Future<NetworkResult<T>> makeRequest(Future<Response> networkCall, T Function(Response) onParse) async {
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
