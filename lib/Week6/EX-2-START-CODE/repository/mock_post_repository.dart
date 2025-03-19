import '../model/post.dart';

import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  final List<Post> _dummyPosts = [
    Post(id: 1, title: 'Post One', description: 'This is the first post.'),
    Post(id: 2, title: 'Post Two', description: 'This is the second post.'),
    Post(id: 3, title: 'Post Three', description: 'This is the third post.'),
    Post(id: 4, title: 'Post Four', description: 'This is the fourth post.'),
    Post(id: 5, title: 'Post Five', description: 'This is the fifth post.'),
  ];

  @override
  Future<Post> getPost(int postId) {
    return Future.delayed(Duration(seconds: 5), () {
      if (postId != 25) {
        throw Exception("No post found");
      }
      return Post(
        id: 25,
        title: 'Who is the best',
        description: 'teacher ronan',
      );
    });
  }

  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(Duration(seconds: 5));
    return _dummyPosts;
  }
}
