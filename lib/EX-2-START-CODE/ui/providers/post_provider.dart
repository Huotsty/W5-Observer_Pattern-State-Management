import 'package:flutter/material.dart';

import '../../model/post.dart';
import '../../repository/post_repository.dart';
import 'async_value.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository _repository;

  AsyncValue<Post>? postValue;
  AsyncValue<List<Post>>? postListValue;

  PostProvider({required PostRepository repository}) : _repository = repository;

  void fetchPost(int postId) async {
    // 1-  Set loading state
    postValue = AsyncValue.loading();
    notifyListeners();
    try {
      // 2   Fetch the data
      Post post = await _repository.getPost(postId);
      // 3  Set success state
      postValue = AsyncValue.success(post);
    } catch (error) {
      // 4  Set error state
      postValue = AsyncValue.error(error);
    }
    notifyListeners();
  }
  void fetchPosts() async {
    postListValue = AsyncValue.loading();
    notifyListeners();
    try{
      // 2- Fetch the data
      List<Post> posts = await _repository.getPosts();
      // 3- Set success state for post list
      postListValue = AsyncValue.success(posts);
    }catch(error){
      postListValue = AsyncValue.error(error);
    }
    notifyListeners();
  }
}
