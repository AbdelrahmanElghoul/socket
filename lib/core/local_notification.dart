import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  final String _channelName = 'channelName';
  final String _channelId = 'id';
  final String _channelDescription = 'description';
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  _init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initSettingsAndroid =
        AndroidInitializationSettings('launch_background');
    final initSettingsIOS = IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future selectNotification(String payload) async {
  //   if (payload != null) {
  //     print('mDebug: $payload');
  //   }
  //   // TODO navigate
  //   // await Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute<void>(builder: (context) => WebSocketDemo()),
  //   // );
  // }

  Future showNofication({@required String title, String body}) async {
    if (_flutterLocalNotificationsPlugin == null) _init();
    var androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.high,
    );
    var iosDetail = IOSNotificationDetails();

    var generalNotificaitonDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetail,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      generalNotificaitonDetails,
    );
  }
}
