import 'package:get/get.dart';

import '../core/model/todo_model.dart';

class TodoController extends GetxController {
  final List todos = <TodoModel>[].obs;

  void addToDo(String title) {
    final todo = TodoModel(
      id: "${DateTime.now().microsecondsSinceEpoch}",
      title: title,
      isCompleted: false,
    );
    todos.add(todo);
  }

  void removeTodo(String id) {
    todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTask(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(
        isCompleted: !todos[index].isCompleted,
      );
    }
  }
}
