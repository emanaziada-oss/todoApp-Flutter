
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../core/model/todo_model.dart';

class FirebaseTodoService {
  FirebaseTodoService._();

  static final FirebaseTodoService instance = FirebaseTodoService._();

  final FirebaseDatabase _db = FirebaseDatabase.instance;
  static const String collectionPath = 'todos';
  // final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addTodo(String uid,String title) async {
    final newTodo = TodoModel(id:"", title: title, isCompleted: false);
    try{
      await _db.ref('$collectionPath/$uid').push().set({...newTodo.toJson(),});
    }on FirebaseException catch(e){
      rethrow;
    }

  }

  Stream <List<TodoModel>> getAllTodos (String uid) {
    try {
      return _db
          .ref('$collectionPath/$uid')
          .onValue.map((event) {
          if(event.snapshot.value == null) return[];
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          return data.entries.map((e) {
            final todoData = Map<String, dynamic>.from(e.value);
            return TodoModel.fromJson(todoData)..id = e.key ;
          }).toList();
      });

    }on FirebaseException catch(e){
      rethrow;
    }

  }
  Future<void> deleteTodo(String uid, String todoId) async {
    await _db.ref('$collectionPath/$uid/$todoId').remove();
  }

  Future<void> updateTodo(String uid, String todoId, Map<String, dynamic> updates) async {
    await _db.ref('$collectionPath/$uid/$todoId').update(updates);
  }
}