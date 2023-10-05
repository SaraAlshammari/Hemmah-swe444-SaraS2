import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../global/global.dart';

class Utils {
  static Future<void> sendNotificationToDriverNow({
    required BuildContext context,
    required String? deviceRegistrationToken,
    required String? body,
    required String? title,
  }) async {
    log("sendNotificationToDriverNow $deviceRegistrationToken $body $title ");

    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': serverNotificationToken,
    };

    Map bodyNotification = {
      "body": body,
      "title": title,
    };

    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
    };

    Map officialNotificationFormat = {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": deviceRegistrationToken,
    };

    await http
        .post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: headerNotification,
          body: jsonEncode(officialNotificationFormat),
        )
        .then((value) => log("Notification send ${value.body.toString()}"));
  }
}
