import 'dart:io';

import 'package:restaurant_app/widgets/custom_dialog.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  static const String settingsTitle = 'Settings';
  static final box = Hive.box('darkModeBox');

  const SettingsPage({Key? key}) : super(key: key);

  Widget _android(BuildContext context) {
    return Scaffold(
      // backgroundColor: baseColor,
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _list(context),
    );
  }

  Widget _ios(BuildContext context) {
    return CupertinoPageScaffold(
      // backgroundColor: baseColor,
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _list(context),
    );
  }

  Widget _list(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SettingProvider(),
      child: ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Scheduling Notification', style: TextStyle(color: Colors.black),),
              trailing: Consumer<SettingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledInfo(value);
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Material(
            child: ListTile(
              title: const Text(
                'Dark Theme',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Consumer<SettingProvider>(
                builder: (context, provider, _) {
                  return Switch.adaptive(
                    onChanged: (value) async {
                      provider.setDarkMode(value);
                    },
                    value: provider.isDarkMode(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _android,
      iosBuilder: _ios,
    );
  }
}
