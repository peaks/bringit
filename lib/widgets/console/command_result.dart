class CommandResult {
  CommandResult(
      {required this.stdout, required this.stderr, required this.success});
  final String stdout;
  final String stderr;
  final bool success;
}
