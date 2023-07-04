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
class Wording {
  /// strings used in app
  static const String stagingScreenTitle = 'staging';
  static const String explorerScreenTitle = 'explorer';
  static const String locationScreenTitle = 'location';

  static const String commitBlockTitle = 'COMMIT';
  static const String locationBlockTitle = 'LOCATION';
  static const String commitSummaryBlockTitle = 'COMMIT SUMMARY';
  static const String previewBlockTitle = 'PREVIEW';
  static const String explorerBlockTitle = 'EXPLORER';
  static const String stagingBlockTitle = 'STAGING';
  static const String diffBlockTitle = 'DIFF';
  static const String consoleBlockTitle = 'CONSOLE';

  /// list of strings by screen
  static const List<String> stagingScreenTitles = <String>[
    stagingBlockTitle,
    commitBlockTitle,
    diffBlockTitle,
  ];

  static const List<String> explorerScreenTitles = <String>[
    previewBlockTitle,
    explorerBlockTitle,
  ];

  static const List<String> locationScreenTitles = <String>[
    commitBlockTitle,
    locationBlockTitle,
    commitSummaryBlockTitle,
  ];

  /// map blokes titles with screen title to get corresponding titles
  static const Map<String, List<String>> mapScreenTitles =
      <String, List<String>>{
    stagingScreenTitle: stagingScreenTitles,
    explorerScreenTitle: explorerScreenTitles,
    locationScreenTitle: locationScreenTitles,
  };
}
