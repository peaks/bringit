/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class CustomerPrinter extends LogPrinter {
  CustomerPrinter(this.className, this.logFile);
  final String className;
  final File logFile;

  @override
  List<String> log(LogEvent event) {
    final dynamic message = event.message;
    final DateTime time = event.time;
    final String formatedTime = DateFormat('yyyy-MM-dd kk:mm:ss').format(time);
    final String level = event.level.name.toUpperCase();
    final String paddingR = '[$level]'.padRight(9);
    final String logLine = '$paddingR[$formatedTime] $className: $message';
    logFile.writeAsStringSync(logLine, mode: FileMode.append);
    return <String>[logLine];
  }
}

Logger getLogger(String classname) {
  final File loggerFile = File('./bringit.log');
  final Logger log = Logger(
    printer: CustomerPrinter(classname, loggerFile),
    output: MultiOutput(
        <LogOutput?>[FileOutput(file: loggerFile), ConsoleOutput()]),
  );
  return log;
}
