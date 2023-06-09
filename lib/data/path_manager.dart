/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:shared_preferences/shared_preferences.dart';

abstract class PathManager {
  String get path;
  set path(String path);
}

class SpPathManager implements PathManager {
  SpPathManager(this._sp);

  final SharedPreferences _sp;
  final String pathKey = 'currentPath';

  @override
  String get path => _sp.getString(pathKey) ?? '';

  @override
  set path(String path) => _setPath(path);

  Future<void> _setPath(String path) async {
    await _sp.setString(pathKey, path);
  }
}
