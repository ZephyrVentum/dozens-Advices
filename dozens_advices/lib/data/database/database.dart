class Advice {
  final String remoteId;
  final int id;
  final String mainContent;
  final int views;

  final AdviceType type;
  final int createdAt;
  final int viewedAt;
  final String author;
  final String source;

  Advice(
      {this.id,
      this.remoteId,
      this.mainContent,
      this.views = 0,
      this.type,
      this.createdAt = 0,
      this.viewedAt = 0,
      this.author,
      this.source});
}

enum AdviceType { ADVICE, QUOTE, JOKE, FACT }

abstract class Advisable {
  Advice toAdvice();
}
