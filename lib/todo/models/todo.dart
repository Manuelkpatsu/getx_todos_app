import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? id;
  final String title;
  final bool done;
  final String userId;

  Todo({
    this.id,
    required this.userId,
    required this.title,
    this.done = false,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'],
        userId = json['userId'];

  factory Todo.fromSnapshot(DocumentSnapshot snapshot) {
    final newTodo = Todo.fromJson(snapshot.data() as Map<String, dynamic>);
    newTodo.id = snapshot.reference.id;
    return newTodo;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['done'] = done;
    data['userId'] = userId;

    return data;
  }
}
