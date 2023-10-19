// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   const HomeView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HomeView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'HomeView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_getx_todo/app/modules/model/todo.dart';
import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:firebase_with_getx_todo/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homecontroller = TextEditingController();
  String time = '';
  @override
  void dispose() {
    homecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo_List'),
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore.collection('todos').snapshots(),
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
                  child: InkWell(
                    onTap: () {
                      homecontroller.text = todo.text;
                      time = todo.time;
                    },
                  ),
                );
              },
            );
          },
        ),
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
              controller: homecontroller,
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
        // actions: [
        //   if (todo != null)
        //     TextButton.icon(
        //       onPressed: () {
        //         homecontroller.deleteTodo();
        //       },
        //     )
        // ],
      ),
    );
  }
}
