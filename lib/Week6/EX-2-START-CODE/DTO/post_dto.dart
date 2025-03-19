import 'package:week5/Week6/EX-2-START-CODE/model/post.dart';

class PostDTO{
  final int id;
  final String title;
  final String body;

  PostDTO({required this.id, required this.title, required this.body});
  factory PostDTO.fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int, 'Invalid or missing "id". Expected an int.');
    assert(json['title'] is String, 'Invalid or missing "title". Expected a string.');
    assert(json['body'] is String, 'Invalid or missing "body". Expected a string.');

    return PostDTO(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Post toModel(){
    return Post(id: id, title: title, description: body);
  }
}