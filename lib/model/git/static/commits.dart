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
import 'package:git_ihm/model/git/git_commit.dart';

final List<GitCommit> commits = <GitCommit>[
  GitCommit(
    '454fdf5d',
    DateTime(2023, 02, 01, 16, 02),
    'Megane',
    'jchevalier@peaks.fr',
    'feat: create summary ',
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  ),
  GitCommit(
      '454fdf5e',
      DateTime.now(),
      'Elsa',
      'meganeelsa@gmail.com',
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
      'feat: create summary '),
];

GitCommit getCommit(String hashValue) {
  final GitCommit uniquecommit =
      commits.where((GitCommit commit) => commit.hashValue == hashValue).first;

  return uniquecommit;
}
