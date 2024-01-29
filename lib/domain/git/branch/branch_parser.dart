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

class BranchParser {
  String parse(String branchOutput) {
    final List<String> lines = branchOutput.trim().split('\n');
    final String currentBranchLine = lines.firstWhere(
      (String line) => line.startsWith('*'),
      orElse: () => '',
    );
    final String currentBranch = currentBranchLine.replaceAll('*', '').trim();

    return currentBranch;
  }
}
