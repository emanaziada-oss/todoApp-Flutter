
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/getx/todo_controller.dart';

import '../widget/bottom_nav_bar.dart';

class TodoScreengetx extends StatefulWidget {
  const TodoScreengetx({super.key});

  @override
  State<TodoScreengetx> createState() => _TodoScreengetxState();
}

class _TodoScreengetxState extends State<TodoScreengetx> {
  final TextEditingController controller = TextEditingController();
  final TodoController controllerGetx = Get.put(TodoController());

  RxBool showCompleted = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
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
                  text: "List",
                  style: TextStyle(color: Colors.greenAccent),
                )
              ],
            ),
          ),
        ),

        body: Obx(() {
          final todos = controllerGetx.todos;

          final visibleTodos = showCompleted.value
              ? todos.where((e) => e.isCompleted).toList()
              : todos.where((e) => !e.isCompleted).toList();

          final completedCount =
              todos.where((e) => e.isCompleted).length;
          final uncompletedCount =
              todos.where((e) => !e.isCompleted).length;

          return Padding(
            padding: const EdgeInsets.all(16),
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

                    // ADD Button (circle)
                    GestureDetector(
                      onTap: () {
                        if (controller.text.trim().isEmpty) return;
                        controllerGetx.addToDo(controller.text.trim());
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
                      onTap: () => showCompleted.value = true,
                      child: Column(
                        children: [
                          const Text("completed"),
                          CircleAvatar(
                            backgroundColor: showCompleted.value
                                ? Colors.purple
                                : Colors.grey,
                            radius: 12,
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
                      onTap: () => showCompleted.value = false,
                      child: Column(
                        children: [
                          const Text("unCompleted"),
                          CircleAvatar(
                            backgroundColor: !showCompleted.value
                                ? Colors.purple
                                : Colors.grey,
                            radius: 12,
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

                // ---------------- Todo List ----------------
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
                            // custom circular checkbox
                            GestureDetector(
                              onTap: () =>
                                  controllerGetx.toggleTask(todo.id),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: todo.isCompleted
                                    ? Colors.purple
                                    : Colors.white,
                                child: todo.isCompleted
                                    ? const Icon(Icons.check,
                                    size: 16,
                                    color: Colors.white)
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
                              icon: const Icon(Icons.delete,
                                  color: Colors.black54),
                              onPressed: () =>
                                  controllerGetx.removeTodo(todo.id),
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
        }),
      ),
    );
  }
}
