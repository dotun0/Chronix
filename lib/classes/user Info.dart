import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class TaskClass extends HiveObject {
  @HiveField(0)
  String userName;
  @HiveField(1)
  String appTheme;
  @HiveField(2)
  DateTime notiTime;

  TaskClass({
    required this.userName,
    required this.notiTime,
    required this.appTheme,
  });
}
