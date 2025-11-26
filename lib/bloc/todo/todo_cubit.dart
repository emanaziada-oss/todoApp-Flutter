// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:myproject/bloc/todo/todo_state.dart';
// import 'package:myproject/core/data/models/todo_model.dart';
// import 'package:uuid/uuid.dart';
// // part 'todo_state.dart';
//
// class TodoCubit extends Cubit<TodoState> {
//   TodoCubit() : super(TodoInitial());
//
//   void addToDo (String title){
//     TodoModel task = TodoModel(id:DateTime.now().millisecondsSinceEpoch, title: title, isCompleted: false);
//     emit(UpdateTodo([...state.todos , task]));
//   }
//
//   void removeToDo (int id){
//       final List<TodoModel> newTodos = state.todos.where((item)=> item.id != id).toList();
//       emit(UpdateTodo(newTodos));
//   }
//
//   void toggleTask (int id){
//       final List <TodoModel> newTodos = state.todos.map((item) {
//         return item.id == id ? item.copyWith(isCompleted : !item.isCompleted) : item;
//       }).toList();
//
//       emit(UpdateTodo(newTodos));
//   }
//  }
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/bloc/todo/todo_state.dart';
import '../../services/firebase_todo_realtime.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoInitial());

  StreamSubscription? _streamSub;
  final FirebaseTodoService _service = FirebaseTodoService.instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  Future<void> listenTodos() async {
    emit(TodoLoading(state.todos));

    await _streamSub?.cancel();

    _streamSub = _service.getAllTodos(uid).listen(
          (todos) {
        emit(TodoSuccess(todos));
      },
      onError: (error) {
        emit(TodoError(error.toString(), state.todos));
      },
    );
  }

  Future<void> addTodo(String title) async {
    try {
      await _service.addTodo(uid, title);
    } catch (e) {
      emit(TodoError(e.toString(), state.todos));
    }
  }

  Future<void> removeTodo(String todoId) async {
    try {
      await _service.deleteTodo(uid, todoId);
   } catch (e) {
      emit(TodoError(e.toString(), state.todos));
    }
  }

  Future<void> toggleTodo(String todoId) async {
    try {
      final todo = state.todos.firstWhere((t) => t.id == todoId);
      await _service.updateTodo(uid, todoId, {'isCompleted': !todo.isCompleted});
    } catch (e) {
      emit(TodoError(e.toString(), state.todos));
    }
  }

  @override
  Future<void> close() {
    _streamSub?.cancel();
    return super.close();
  }
}


