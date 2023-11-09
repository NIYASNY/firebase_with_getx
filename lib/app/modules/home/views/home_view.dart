import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_getx_todo/app/modules/home/views/end.dart';
import 'package:firebase_with_getx_todo/app/modules/model/todo.dart';
import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:firebase_with_getx_todo/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  String time = '';
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text(
          'Todo_List',
          style: GoogleFonts.pacifico(fontSize: 25),
        ),
      ),
      endDrawer: const EndDrawer(),
      body: Container(
        color: Colors.grey.shade100,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('Users')
              .doc(authcontroller.user!.uid)
              .collection('todos')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final todoList =
                snapshot.data!.docs.map((e) => Todo.fromMap(e)).toList();

            return GroupedListView(
              order: GroupedListOrder.DESC,
              elements: todoList,
              groupBy: (Todo todo) => todo.date,
              groupHeaderBuilder: (Todo todo) => Padding(
                padding: const EdgeInsets.all(10.0).copyWith(left: 20),
                child: Text(
                  getFormattedDate(todo.date).toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ),
              itemBuilder: (context, Todo todo) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Slidable(
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          homeController.deleteTodo(todo.id);
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          showTodoInput(context, todo: todo);
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.update,
                        label: 'Update',
                      )
                    ]),
                    child: InkWell(
                      onTap: () {
                        textController.text = todo.text;
                        time = todo.time;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                left: BorderSide(
                              color: getLabelColor(todo.date),
                              width: 10,
                            )),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(4, 4),
                                blurRadius: 2.0,
                                color: Colors.black,
                              )
                            ]),
                        child: AnimatedOpacity(
                          opacity: todo.isDone ? 0.4 : 1.0,
                          duration: const Duration(milliseconds: 100),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    todo.text,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                todo.time,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  homeController.updateTodo(todo.id,
                                      todo.copyWith(isDone: !todo.isDone));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4)
                                      .copyWith(right: 14),
                                  child: Icon(
                                    todo.isDone
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    size: 28,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[700],
        onPressed: () async {
          setState(() {
            time = TimeOfDay.now().format(context);
          });
          await showTodoInput(context).then((value) {
            textController.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  showTodoInput(BuildContext context, {Todo? todo}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(todo == null ? 'Add Todo' : 'Update Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            const SizedBox(
              height: 5,
            ),
            OutlinedButton(
                onPressed: () async {
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (newTime != null) {
                    setState(() {
                      time = newTime.format(context);
                    });
                  }
                },
                child: Text('Time : $time')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                if (textController.text.isEmpty) {
                  return;
                }
                if (todo != null) {
                  homeController.updateTodo(
                      todo.id,
                      todo.copyWith(
                        text: textController.text,
                        time: time,
                      ));
                } else {
                  homeController.addTodo(
                    textController.text,
                    time,
                    getDateTimestamp(
                      DateTime.now(),
                    ),
                  );
                }
                Get.back();
              },
              child: Text(todo == null ? 'Add Todo' : 'Update Todo'))
        ],
      ),
    );
  }
}
