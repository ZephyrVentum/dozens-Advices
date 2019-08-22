const ADVICE_TABLE = "advice";
const ID_COLUMN = 'id';
const REMOTE_ID_COLUMN = 'remoteId';
const CONTENT_COLUMN = 'content';
const VIEWS_COLUMN = 'views';
const IS_FAVOURITE_COLUMN = 'is_favourite';
const TYPE_COLUMN = 'type';
const CREATED_AT_COLUMN = 'created_at';
const VIEWED_AT_COLUMN = 'viewed_at';
const AUTHOR_COLUMN = 'author';
const SOURCE_COLUMN = 'source';

class Advice {
  final String remoteId;
  int id;
  final String mainContent;
  final int views;
  final bool isFavourite;
  final String type;
  final int createdAt;
  final int viewedAt;
  final String author;
  final String source;

  Advice(
      {this.id,
      this.remoteId,
      this.mainContent,
      this.views = 1,
      this.isFavourite = false,
      this.type,
      this.createdAt = 0,
      this.viewedAt = 0,
      this.author,
      this.source});

  Map<String, dynamic> toDatabaseMap() {
    return {
      ID_COLUMN: id,
      REMOTE_ID_COLUMN: remoteId,
      CONTENT_COLUMN: mainContent,
      VIEWS_COLUMN: views,
      IS_FAVOURITE_COLUMN: isFavourite ? 1 : 0,
      TYPE_COLUMN: type,
      CREATED_AT_COLUMN: createdAt,
      VIEWED_AT_COLUMN: viewedAt,
      AUTHOR_COLUMN: author,
      SOURCE_COLUMN: source
    };
  }

  factory Advice.fromDatabaseMap(Map<String, dynamic> map) {
    return Advice(
        id: map[ID_COLUMN],
        remoteId: map[REMOTE_ID_COLUMN],
        mainContent: map[CONTENT_COLUMN],
        views: map[VIEWS_COLUMN],
        isFavourite: map[IS_FAVOURITE_COLUMN] == 1,
        type: map[TYPE_COLUMN],
        createdAt: map[CREATED_AT_COLUMN],
        viewedAt: map[VIEWED_AT_COLUMN],
        author: map[AUTHOR_COLUMN],
        source: map[SOURCE_COLUMN]);
  }
}

class AdviceType {
  final type;

  AdviceType({this.type = ADVICE});

  static const ADVICE = "ADVICE";
  static const JOKE = "JOKE";
  static const FACT = "FACT";
  static const QUOTE = "QUOTE";
}

abstract class Advisable {
  Advice toAdvice();
}
