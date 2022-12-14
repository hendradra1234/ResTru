import 'dart:isolate';
import 'dart:ui';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service = BackgroundService();
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;


  BackgroundService._createObject();

  factory BackgroundService() {
    _service = BackgroundService._createObject();
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Notification Trigger');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().getList();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
    debugPrint('Notification Done');
  }
}
