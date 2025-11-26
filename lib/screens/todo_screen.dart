// import 'package:flutter/material.dart';
// import 'package:myproject/bloc/todo/todo_cubit.dart';
// import 'package:myproject/bloc/todo/todo_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myproject/core/data/models/todo_model.dart';
// class TodoScreen extends StatelessWidget {
//    TodoScreen({super.key});
//  final TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return  BlocProvider(
//       create :(context )=> TodoCubit(),
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: Center(child: Text('ToDo')),
//           ),
//           body: BlocBuilder<TodoCubit , TodoState>(
//               builder: (BuildContext context , state) {
//                 return Container(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextFormField(
//                             controller: controller,
//                           decoration: const InputDecoration(
//                             hintText: ('Add task'),
//                           ),
//                         ),
//                         ElevatedButton(onPressed: (){
//                           if(controller.text.trim().isEmpty ) return ;
//                           context.read<TodoCubit>().addTodo(controller.text.trim());
//                           controller.clear();
//                           }, child: Text('Add')),
//                         Expanded(child: ListView.builder(
//                             itemCount:state.todos.length,
//                           itemBuilder: (BuildContext context , int index){
//                               return ListTile(
//                                 leading: Checkbox(value: state.todos[index].isCompleted, onChanged: (value){
//                                   context.read<TodoCubit>().toggleTodo(state.todos[index].id);
//                                 }),
//                                 title: Text(state.todos[index].title),
//                                   trailing: IconButton(onPressed: (){
//                                     context.read<TodoCubit>().removeTodo(state.todos[index].id);
//                                   }, icon: Icon(Icons.delete, color: Colors.red,)
//                                   )
//                               );
//                           },
//
//                         ))
//                       ],
//                     ),
//                   ),
//                 );
//               })
//
//
//
//           )
//         ),
//       );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:myproject/bloc/todo/todo_cubit.dart';
// import 'package:myproject/bloc/todo/todo_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class TodoScreen extends StatelessWidget {
//   TodoScreen({super.key});
//
//   final TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => TodoCubit()..listenTodos(),   // ← تشغيل الاستماع هنا
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Center(child: Text('ToDo')),
//           ),
//           body: BlocBuilder<TodoCubit, TodoState>(
//             builder: (context, state) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: controller,
//                       decoration: const InputDecoration(
//                         hintText: 'Add task',
//                       ),
//                     ),
//
//                     ElevatedButton(
//                       onPressed: () {
//                         if (controller.text.trim().isEmpty) return;
//                         context.read<TodoCubit>().addTodo(controller.text.trim());
//                         controller.clear();
//                       },
//                       child: const Text('Add'),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     // --------- LIST VIEW ---------
//                     Expanded(
//                       child: state is TodoLoading
//                           ? const Center(child: CircularProgressIndicator())
//                           : ListView.builder(
//                         itemCount: state.todos.length,
//                         itemBuilder: (_, index) {
//                           final todo = state.todos[index];
//
//                           return ListTile(
//                             leading: Checkbox(
//                               value: todo.isCompleted,
//                               onChanged: (_) {
//                                 context.read<TodoCubit>().toggleTodo(todo.id);
//                               },
//                             ),
//                             title: Text(todo.title),
//                             trailing: IconButton(
//                               onPressed: () => context.read<TodoCubit>().removeTodo(todo.id),
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo/todo_cubit.dart';
import '../bloc/todo/todo_state.dart';
import '../widget/bottom_nav_bar.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();

  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit()..listenTodos(),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: const BottomNavBar(currentIndex: 0),
          backgroundColor: const Color(0xfff7efe6),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xfff7efe6),
            centerTitle: true,
            title: RichText(
              text: const TextSpan(
                text: "Todo",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: " List",
                    style: TextStyle(color: Colors.greenAccent),
                  )
                ],
              ),
            ),
          ),

          body: BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              final todos = state.todos;

                // Filtering
              final visibleTodos = showCompleted
                  ? todos.where((e) => e.isCompleted).toList()
                  : todos.where((e) => !e.isCompleted).toList();

              final completedCount =
                  todos.where((e) => e.isCompleted).length;
              final uncompletedCount =
                  todos.where((e) => !e.isCompleted).length;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // ---------------- Input + Add Button ----------------

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2))
                              ],
                            ),
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: 'Add task...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // ADD BUTTON
                        GestureDetector(
                          onTap: () {
                            if (controller.text.trim().isEmpty) return;
                            context.read<TodoCubit>().addTodo(
                                controller.text.trim());
                            controller.clear();
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ---------------- Filter Buttons ----------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            showCompleted = true;
                          }),
                          child: Column(
                            children: [
                              const Text("completed"),
                              CircleAvatar(
                                backgroundColor:
                                showCompleted ? Colors.purple : Colors.grey,
                                radius: 10,
                                child: Text(
                                  "$completedCount",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () => setState(() {
                            showCompleted = false;
                          }),
                          child: Column(
                            children: [
                              const Text("unCompleted"),
                              CircleAvatar(
                                backgroundColor:
                                !showCompleted ? Colors.purple : Colors.grey,
                                radius: 10,
                                child: Text(
                                  "$uncompletedCount",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Divider(),

                    // ---------------- List ----------------
                    Expanded(
                      child: state is TodoLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        itemCount: visibleTodos.length,
                        itemBuilder: (_, index) {
                          final todo = visibleTodos[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: todo.isCompleted
                                  ? Colors.pink.shade200
                                  : Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                // custom circular checkbox
                                GestureDetector(
                                  onTap: () => context
                                      .read<TodoCubit>()
                                      .toggleTodo(todo.id),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: todo.isCompleted
                                        ? Colors.purple
                                        : Colors.white,
                                    child: todo.isCompleted
                                        ? const Icon(Icons.check,
                                        size: 16, color: Colors.white)
                                        : null,
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    todo.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      decoration: todo.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ),

                                IconButton(
                                  onPressed: () => context
                                      .read<TodoCubit>()
                                      .removeTodo(todo.id),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
