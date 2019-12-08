import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kidney_app/model/medicacao.dart';

class NotificacaoDiaria {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> iniciar(Medicacao medicacao) async {
    print('NOTIFICAO');
    print(medicacao);
    var time = Time(medicacao.hora.hour, medicacao.hora.minute, 0);
    print(time.hour);
    print(time.minute);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
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

  }
}