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

import 'package:git_ihm/domain/git/git_proxy.dart';

class GitInitProject {
  GitInitProject(String directoryPath, GitProxy git) {
    initializeGitRepository(directoryPath, git);
  }

  Future<void> initializeGitRepository(
      String directoryPath, GitProxy git) async {
    final Directory repositoryDirectory = Directory(directoryPath);
    final bool isPathExisting = repositoryDirectory.existsSync();

    try {
      if (!isPathExisting) {
        await repositoryDirectory.create(recursive: true);
        print('Dossier créé avec succès : $directoryPath');
      }

      if (repositoryDirectory.existsSync()) {
        await git.gitInit(directoryPath);
        if (await git.isGitDir(directoryPath)) {
          print('$directoryPath est initialisé');
        } else {
          print('non initialisé');
        }
      } else {
        print('Le dossier n\'existe pas');
      }
    } catch (e) {
      print('Erreur lors de initialisation du référentiel Git : $e');
    }
  }
}
