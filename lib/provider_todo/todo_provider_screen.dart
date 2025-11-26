// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:myproject/provider_todo/provider_todo.dart'; // TodoProvider
// import 'package:myproject/core/data/models/todo_model.dart'; // TodoModel
//
// class TodoScreenProvider extends StatelessWidget {
//   TodoScreenProvider({super.key});
//   final TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => TodoProvider(),
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Center(child: Text('ToDo')),
//           ),
//           body: Consumer<TodoProvider>(
//             builder: (context, todoProv, _) {
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
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         final text = controller.text.trim();
//                         if (text.isEmpty) return;
//                         todoProv.add(text);
//                         controller.clear();
//                       },
//                       child: const Text('Add'),
//                     ),
//                     const SizedBox(height: 10),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: todoProv.todos.length,
//                         itemBuilder: (context, index) {
//                           final todo = todoProv.todos[index];
//                           return ListTile(
//                             leading: Checkbox(
//                               value: todo.isCompleted,
//                               onChanged: (value) {
//                                 todoProv.toggleTask(todo.id);
//                               },
//                             ),
//                             title: Text(todo.title),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 todoProv.removeTodo(todo.id);
//                               },
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
import 'package:provider/provider.dart';
import 'package:todoapp/provider_todo/provider_todo.dart';

import '../widget/bottom_nav_bar.dart';

class TodoScreenProvider extends StatelessWidget {
  TodoScreenProvider({super.key});

  final TextEditingController controller = TextEditingController();
  final ValueNotifier<bool> showCompleted = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: const BottomNavBar(currentIndex: 2),
          backgroundColor: const Color(0xfff7efe6),
          appBar: AppBar(
            backgroundColor: const Color(0xfff7efe6),
            elevation: 0,
            centerTitle: true,
            title: RichText(
              text: const TextSpan(
                text: "Todo",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "List",
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ],
              ),
            ),
          ),

          body: Consumer<TodoProvider>(
            builder: (context, todoProv, _) {
              final completed = todoProv.todos.where((e) => e.isCompleted).toList();
              final uncompleted = todoProv.todos.where((e) => !e.isCompleted).toList();

              return ValueListenableBuilder(
                valueListenable: showCompleted,
                builder: (_, isCompletedTab, __) {
                  final visibleTodos = isCompletedTab ? completed : uncompleted;

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // ========== INPUT ==========
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                    )
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

                            GestureDetector(
                              onTap: () {
                                if (controller.text.trim().isEmpty) return;
                                todoProv.add(controller.text.trim());
                                controller.clear();
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ========== FILTER (completed / uncompleted) ==========
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => showCompleted.value = true,
                              child: Column(
                                children: [
                                  const Text("completed"),
                                  CircleAvatar(
                                    backgroundColor: isCompletedTab ? Colors.purple : Colors.grey,
                                    radius: 12,
                                    child: Text(
                                      "${completed.length}",
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () => showCompleted.value = false,
                              child: Column(
                                children: [
                                  const Text("unCompleted"),
                                  CircleAvatar(
                                    backgroundColor: !isCompletedTab ? Colors.purple : Colors.grey,
                                    radius: 12,
                                    child: Text(
                                      "${uncompleted.length}",
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Divider(),

                        // ========== LIST ==========
                        Expanded(
                          child: ListView.builder(
                            itemCount: visibleTodos.length,
                            itemBuilder: (_, index) {
                              final todo = visibleTodos[index];

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: todo.isCompleted
                                      ? Colors.pink.shade200
                                      : Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    /// circular checkbox
                                    GestureDetector(
                                      onTap: () => todoProv.toggleTask(todo.id),
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
                                      icon: const Icon(Icons.delete, color: Colors.black54),
                                      onPressed: () => todoProv.removeTodo(todo.id),
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
              );
            },
          ),
        ),
      ),
    );
  }
}

