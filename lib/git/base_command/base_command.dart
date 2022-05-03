import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class BaseCommand {
  @protected
  bool commandIsSuccessful(ProcessResult result) =>
      result.stdout is String && result.exitCode == 0;
}
