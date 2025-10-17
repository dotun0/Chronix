import 'package:hive/hive.dart';
part 'task_class.g.dart';

@HiveType(typeId: 0)
class TaskClass extends HiveObject {
  @HiveField(0)
  String taskName;
  @HiveField(1)
  bool taskState;
  @HiveField(2)
  String taskCategory;
  @HiveField(3)
  DateTime taskTime;
  @HiveField(4)
  String id;
  @HiveField(5)
  int catColor;

  TaskClass({
    required this.taskName,
    required this.taskState,
    required this.taskCategory,
    required this.taskTime,
    required this.id,
    required this.catColor,
  });
  TaskClass clone() {
    return TaskClass(
      taskName: taskName,
      taskState: taskState,
      taskCategory: taskCategory,
      taskTime: taskTime,
      id: id,
      catColor: catColor,
    );
  }
}
