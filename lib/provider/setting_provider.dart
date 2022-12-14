part of 'provider.dart';

class SettingProvider extends ChangeNotifier {
  DbService dbService = DbService();
  bool _isScheduled = false;

  bool get isScheduled => dbService.isNotify();

  Future<bool> scheduledInfo(bool value) async {
    _isScheduled = await dbService.setNotify(value);
    const id = 10;

    if (_isScheduled) {
      debugPrint('Notification activated');
      debugPrint(DateTimeHelper.format().toString());
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          id,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true);
    }
    debugPrint("Notification Canceled");
    notifyListeners();
    return await AndroidAlarmManager.cancel(id);
  }

  bool isDarkMode() {
    return dbService.isDarkMode();
  }

  Future<bool> setDarkMode(bool value) async {
    notifyListeners();
    return await dbService.darkMode(value);
  }
}
