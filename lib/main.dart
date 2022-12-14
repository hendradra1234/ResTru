import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/common/navigation.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/layouts/detail_page.dart';
import 'package:restaurant_app/layouts/home_page.dart';
import 'package:restaurant_app/data/common/styles.dart';
import 'package:restaurant_app/layouts/reviews_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/config.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) await AndroidAlarmManager.initialize();

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(MenuAdapter());
  Hive.registerAdapter(OptionAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(ReviewAdapter());
  await Hive.openBox(Config.boxFavorite);
  await Hive.openBox(Config.boxDarkMode);
  runApp(MyApp(
    dbService: DbService(),
  ));
}

class MyApp extends StatelessWidget {
  final DbService dbService;
  const MyApp({Key? key, required this.dbService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(Config.boxDarkMode).listenable(),
      builder: (BuildContext context, box, Widget? child) {
        var darkMode = dbService.isDarkMode();
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: appName,
          themeMode: !darkMode ? ThemeMode.light : ThemeMode.dark,
          theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  background: !darkMode ? baseColor : baseDarkColor,
                  primary: !darkMode ? primaryColor : primaryDarkColor,
                  onPrimary: !darkMode ? Colors.black : Colors.white,
                  secondary: !darkMode ? secondaryColor : secondaryDarkColor,
                ),
            scaffoldBackgroundColor: !darkMode ? baseColor : baseDarkColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: !darkMode ?  resTruTheme : resTruDarkTheme,
            appBarTheme: const AppBarTheme(elevation: 0),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: baseColor,
                textStyle: const TextStyle(),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
            ),
          ),
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            DetailPage.routeName: (context) => DetailPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
            ReviewScreen.routeName: (context) => ReviewScreen(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
          },
        );
      },
    );
  }
}
