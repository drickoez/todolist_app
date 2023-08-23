import 'package:flutter/material.dart';
import '../model/home_data.dart';
import '../database/database_helper.dart';

class HomeController {
  static final titleController = TextEditingController();
  static final descriptionController = TextEditingController();
  static final _currentDateTime = DateTime.now();
  static late Future<List<Task>> tasks;

  static Future<List<Task>> getPendingTasks() {
    Future<List<Task>> pendingTasks = DatabaseHelper.getTasks();
    pendingTasks.then((value) {
      value.removeWhere((element) => element.status == 1);
    });
    return pendingTasks;
  }

  static Future<List<Task>> getDoneTask() {
    Future<List<Task>> doneTasks = DatabaseHelper.getTasks();
    doneTasks.then((value) {
      value.removeWhere((element) => element.status == 0);
    });
    return doneTasks;
  }

  static void updateTaskStatus(taskId, todoTitle, todoDescription) {
    Task task = Task(
      id: taskId,
      title: todoTitle.toString().trim(),
      description: todoDescription.toString().trim(),
      date:
          "${_currentDateTime.day}/${_currentDateTime.month}/${_currentDateTime.year}",
      time: "${_currentDateTime.hour}:${_currentDateTime.minute}",
      status: 1,
    );
    DatabaseHelper.update(task, taskId)
        .then((value) => tasks = DatabaseHelper.getTasks());
  }

  static Future<void> addTask() async {
    Task task = Task(
      title: titleController.text,
      description: descriptionController.text,
      date:
          "${_currentDateTime.day}/${_currentDateTime.month}/${_currentDateTime.year}",
      time: "${_currentDateTime.hour}:${_currentDateTime.minute}",
      status: 0,
    );

    await DatabaseHelper.insert(task)
        .then((value) => tasks = DatabaseHelper.getTasks());
    titleController.clear(); // Setelah dijalankan, clear value/text
    descriptionController.clear(); // Setelah dijalankan, clear value/text
  }

  static void updateTast(taskId) {
    Task task = Task(
      id: taskId,
      title: titleController.text.toString().trim(),
      description: descriptionController.text.toString().trim(),
      date:
          "${_currentDateTime.day}/${_currentDateTime.month}/${_currentDateTime.year}",
      time: "${_currentDateTime.hour}:${_currentDateTime.minute}",
      status: 0,
    );

    DatabaseHelper.update(task, taskId)
        .then((value) => tasks = DatabaseHelper.getTasks());
    titleController.clear();
    descriptionController.clear();
  }
}
