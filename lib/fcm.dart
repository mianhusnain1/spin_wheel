import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 🔹 Initialize Firebase Messaging
  Future<void> initialize() async {
    // Request permissions (iOS)
    await _requestPermission();

    // Get FCM Token
    await _getToken();

    // Initialize local notifications
    _setupLocalNotifications();

    // Handle messages
    _setupMessageListeners();
  }

  /// 🔹 Request Notification Permissions (iOS)
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("🔹 User granted permission");
    } else {
      debugPrint("❌ User denied permission");
    }
  }

  /// 🔹 Retrieve FCM Token
  Future<void> _getToken() async {
    String? token = await _firebaseMessaging.getToken();
    debugPrint("🔹 FCM Token: $token");
  }

  /// 🔹 Initialize Local Notifications
  void _setupLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    _localNotificationsPlugin.initialize(initializationSettings);
  }

  /// 🔹 Show Local Notification
  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? "No Title",
      message.notification?.body ?? "No Body",
      platformChannelSpecifics,
    );
  }

  /// 🔹 Set Up FCM Message Listeners
  void _setupMessageListeners() {
    // Foreground Message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 Foreground Message: ${message.notification?.title}");
      _showNotification(message);
    });

    // Background Message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // When app is opened by tapping the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("🔄 Notification Clicked: ${message.notification?.title}");
    });
  }
}

/// 🔹 Background Message Handler (Required for background messages)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("📩 Background Message: ${message.notification?.title}");
}
