import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
});
   String id;
  final String title;
  final bool isCompleted;

  TodoModel copyWith({
    String? id,
     String? title,
     bool? isCompleted,
}) {
    return TodoModel (
      id : id ?? this.id,
      title : title ?? this.title,
      isCompleted : isCompleted ?? this.isCompleted,
    );
  }
  factory TodoModel.fromJson(Map<String,dynamic> json){
    return TodoModel(
      id: json["id"],
      title: json["title"],
      isCompleted : json["isCompleted"]
    );
  }
  Map<String, dynamic> toJson()=>{
    "id" : id,
    "title": title,
    "isCompleted" :isCompleted,
  };

  @override
  List<Object?> get props => [id, title,isCompleted];

}