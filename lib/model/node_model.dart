import 'dart:convert';

class Node {
  const Node({required this.title, 
  this.description,    
  required this.isCompleted,
  required this.author});
  

  final String title;
  final String? description;  
  final bool isCompleted;
  final String author;  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,      
      'isCompleted': isCompleted,
      'author': author,
    };
  }

  factory Node.fromMap(Map<String, dynamic> map) {
    return Node(
      title: map['title'] as String,
      description: map['description'] as String?,      
      isCompleted: map['isCompleted'] as bool,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Node.fromJson(String source) => 
  Node.fromMap(json.decode(source) as Map<String, dynamic>);

  String? get id => null;
}