import 'dart:convert';

import 'package:week5/Week6/EX-2-START-CODE/DTO/post_dto.dart';
import 'package:week5/Week6/EX-2-START-CODE/model/post.dart';
import 'package:week5/Week6/EX-2-START-CODE/repository/post_repository.dart';
import 'package:http/http.dart' as http;
class HttpPostRepository extends PostRepository{
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Future<Post> getPost(int postId) async{
    final response = await http.get(Uri.parse('$apiUrl/$postId'));
    if(response.statusCode == 200){
      final postDTO = PostDTO.fromJson(json.decode(response.body));
      return postDTO.toModel();
    }else{
      throw Exception("Failed to load post with ID: $postId");
    }
  }

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => PostDTO.fromJson(json).toModel()).toList();
    }
    else{
      throw Exception("Failed to load posts");
    }
  }

}