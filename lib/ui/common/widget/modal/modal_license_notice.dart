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
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.*/

import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/localization/wording.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ModalLicenseNotice extends StatefulWidget {
  const ModalLicenseNotice(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  @override
  State<ModalLicenseNotice> createState() => _ModalLicenseNoticeState();
}

class _ModalLicenseNoticeState extends State<ModalLicenseNotice> {
  late final PackageInfo packageInfo;
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  Future<void> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titlePadding: const EdgeInsets.symmetric(horizontal: 10),
      title: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.short_text,
                      size: 16,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(Wording.licenseNoticeModalTitle,
                        style: Theme.of(context).textTheme.displayLarge),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            const Divider(
              thickness: 1,
            )
          ],
        ),
      ),
      content: Container(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Brint'Git $appVersion ",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(
                height: 10,
              ),
              Text('Copyright (c) 2020 Peaks',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(
                height: 15,
              ),
              Text('GNU General Public License 3.0',
                  style: Theme.of(context).textTheme.bodyMedium),
            ]),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      side: BorderSide(
                        color: Theme.of(context).primaryColorDark,
                      )),
                  onPressed: () {
                    final Uri uri = Uri.parse('http://www.gnu.org/licenses/');
                    launchUrl(uri);
                  },
                  child: Text(
                    Wording.licenseNoticeModalMoreButtonTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      side: BorderSide(
                        color: Theme.of(context).primaryColorDark,
                      )),
                  onPressed: () {
                    widget.sharedPreferences.setBool('isFirstLaunch', false);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Wording.licenseNoticeModalContinueButtonTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
