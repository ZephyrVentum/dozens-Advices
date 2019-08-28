
class Strings{
  Strings._internal();

  static final List<String> sortMenuTitles = List()
    ..addAll([
      Strings.sortMostRecentHistory,
      Strings.sortTheOldestHistory,
      Strings.sortMostPopularHistory,
      Strings.sortMostUnpopularHistory
    ]);

  static final List<String> filterMenuTitles = List()
    ..addAll([
      Strings.filterAllHistory,
      Strings.filterOnlyAdvicesHistory,
      Strings.filterOnlyJokesHistory,
      Strings.filterOnlyQuotesHistory,
      Strings.filterOnlyFactsHistory
    ]);

  //general
  static final String dozensLogo = "dozens";
  static final String advicesLogo = "Advices";

  //home
  static final String configureTab = "Configure";
  static final String historyTab = "History";
  static final String favouritesTab = "Favourites";

  //new advice
  static final String welcomeHome = "Welcome";
  static final String descriptionHome = "You are able to fetch a random\n";
  static final String spansHome = "Advice, Quote, Joke ";
  static final String orHome = "or ";
  static final String factHome = "Fact\n\n";
  static final String tapToStartHome = "To start just tap the button below!";
  static final String getAnythingButtonHome = "Get anything!";
  static final String configureTipHome = "You are also may to configure app to get a specific content according to your preferences.";
  static final String somethingElseButtonHome = "Something else!";
  static final String createdAtAdviceHome = "Created at:";
  static final String viewsAdviceHome = "Views";
  static final String lastSeenAdviceHome = "Last seen:";

  //history
  static final String sortMostRecentHistory = "Most recent";
  static final String sortTheOldestHistory = "The oldest";
  static final String sortMostPopularHistory = "Most popular";
  static final String sortMostUnpopularHistory = "Most unpopular";
  static final String filterAllHistory = "Show all";
  static final String filterOnlyAdvicesHistory = "Only advices";
  static final String filterOnlyJokesHistory = "Only jokes";
  static final String filterOnlyQuotesHistory = "Only quotes";
  static final String filterOnlyFactsHistory = "Only facts";
}

