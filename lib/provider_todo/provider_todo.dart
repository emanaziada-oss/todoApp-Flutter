import 'package:flutter/cupertino.dart';

import '../core/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  void add(String title) {
    final todo = TodoModel(
      id: "${DateTime.now().microsecondsSinceEpoch}",
      title: title,
      isCompleted: false,
    );
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
      notifyListeners();
    }
  }
}
