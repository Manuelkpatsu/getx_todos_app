import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/todo.dart';

class TodoService {
  CollectionReference<Todo> todosRef =
      FirebaseFirestore.instance.collection('todos').withConverter<Todo>(
            fromFirestore: (snapshots, _) => Todo.fromJson(snapshots.data()!),
            toFirestore: (todo, _) => todo.toJson(),
          );

  Stream<List<Todo>> findAll({required String userId}) {
    return todosRef
        .where("userId", isEqualTo: userId)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs
          .map((snapshot) => Todo.fromSnapshot(snapshot))
          .toList();
    }).asStream();
  }

  Future<DocumentSnapshot<Todo>> findOne({required String id}) async {
    return todosRef.doc(id).get();
  }

  Future<DocumentReference> addOne({required Todo todo}) async {
    return todosRef.add(todo);
  }

  Future<void> updateOne({required Todo todo}) async {
    await todosRef.doc(todo.id).update(todo.toJson());
  }

  Future<void> deleteOne({required Todo todo}) async {
    await todosRef.doc(todo.id).delete();
  }
}
