import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_getx_todo/app/modules/model/todo.dart';
import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  addTodo(String todoText, String time, int date) async {
    try {
      final ref = firestore.collection('todos').doc();
      final todo = Todo(
        id: ref.id,
        text: todoText,
        isDone: false,
        time: time,
        date: date,
      );
      await ref.set(todo.toMap());
    } catch (e) {
      print('Someting went wrong(Add) : $e');
    }
  }

  updateTodo(String id, Todo todo) async {
    try {
      await firestore.collection('todos').doc(id).update(todo.toMap());
    } catch (e) {
      print('Something went wrong(Update): $e');
    }
  }

  deleteTodo(String id) async {
    try {
      await firestore.collection('todos').doc(id).delete();
    } catch (e) {
      print('Something went wrong(Delete): $e');
    }
  }

  deleteCompleted() {
    try {
      WriteBatch batch = firestore.batch();
      return firestore
          .collection('todos')
          .where('isDone', isEqualTo: true)
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          batch.delete(document.reference);
        }
        return batch.commit();
      });
    } catch (e) {
      print('Something went wrong(Batch Delete): $e');
    }
  }
}
