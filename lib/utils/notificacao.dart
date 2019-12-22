import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kidney_app/model/medicacao.dart';

class NotificacaoDiaria {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> iniciar(Medicacao medicacao) async {
    print('NOTIFICAO');
    print(medicacao);

    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        icon: 'kidney_black_white',
        sound: 'slow_spring_board',
        largeIcon: 'sample_large_icon',
        largeIconBitmapSource: BitmapSource.Drawable,
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);


    var time = Time(medicacao.hora.hour, medicacao.hora.minute, 0);
    print(time.hour);
    print(time.minute);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        medicacao.id,
        '${medicacao.hora.toString()} - ${medicacao.nome} - ${medicacao.quantidade.toString()} cápsulas ',
        'Hora de tomar ${medicacao.nome} - ${medicacao.quantidade.toString()} cápsulas ',
        time,
        platformChannelSpecifics);

  }

  Future<void> lista() async {
    var notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    print(notificationAppLaunchDetails.didNotificationLaunchApp);
    print(notificationAppLaunchDetails.payload);
    print(notificationAppLaunchDetails.toString());

  }
}