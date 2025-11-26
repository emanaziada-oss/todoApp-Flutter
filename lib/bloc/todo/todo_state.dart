// import 'package:equatable/equatable.dart';
// import '../../core/data/models/todo_model.dart';
// // part of 'todo_cubit.dart';
//
// // @immutable
// sealed class TodoState extends Equatable{
//   final List<TodoModel> todos;
//   const TodoState(this.todos);
//   @override
//   List<Object?> get props => [todos] ;
// }
//
// final class TodoInitial extends TodoState {
//   TodoInitial ():super([]);
// }

//
// import 'package:equatable/equatable.dart';
//
// import '../../core/data/models/todo_model.dart';
//
//
// sealed class TodoState extends Equatable {
//     final List<TodoModel> todos;
//   const TodoState(this.todos);
//   @override
//   List<Object?> get props => [];
//
// }
//
// final class TodoInitial extends TodoState {
//   TodoInitial(super.todos);
// }
// final class TodoLoading extends TodoState {
//   TodoLoading(super.todos);
// }
//
// final class TodoSuccess extends TodoState {
//   // final List<TodoModel?> todos;
//
//   const TodoSuccess(super.todos);
//
//   List<Object?> get props => [todos];
// }
// final class TodoError extends TodoState {
//   final String error;
//
//   TodoError(this.error) : super();
//
//   List<Object?> get props => [error];
// }
//
// class UpdateTodo extends TodoState{
//   const UpdateTodo(super.todos);
// }

import 'package:equatable/equatable.dart';
import '../../core/model/todo_model.dart';

sealed class TodoState extends Equatable {
  final List<TodoModel> todos;

  const TodoState(this.todos);

  @override
  List<Object?> get props => [todos];
}

final class TodoInitial extends TodoState {
  const TodoInitial() : super(const []);
}

final class TodoLoading extends TodoState {
  const TodoLoading(super.todos);
}

final class TodoSuccess extends TodoState {
  const TodoSuccess(super.todos);
}

final class TodoError extends TodoState {
  final String error;

  const TodoError(this.error, List<TodoModel> todos) : super(todos);

  @override
  List<Object?> get props => [error, todos];
}
