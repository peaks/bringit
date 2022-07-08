class GitLogCommitFormatter {
  GitLogCommitFormatter(
      [this.hash = '00',
      this.timeStamp = '0',
      this.author = '',
      this.subject = '',
      this.reference = '']);

  String hash;
  String timeStamp;
  String author;
  String subject;
  String reference;

  List<String> format() =>
      <String>[_joinSimpleElementsWithAntiSlash(), subject, reference];

  String _joinSimpleElementsWithAntiSlash() =>
      <String>[hash, timeStamp, author].join(r'\');
}
