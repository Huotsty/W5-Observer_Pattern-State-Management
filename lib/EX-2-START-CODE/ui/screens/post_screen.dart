import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the post provider
    final PostProvider postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            // Fetch the list of posts
            onPressed: () => postProvider.fetchPosts(),
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      // Display the list of posts
      body: _buildBody(postProvider),
    );
  }

  Widget _buildBody(PostProvider postProvider) {
    final postListValue = postProvider.postListValue;

    if (postListValue == null) {
      return const Center(
        child: Text("Tap the refresh button to load posts."),
      ); // Display an empty state
    }

    switch (postListValue.state) {
      case AsyncValueState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        ); // Display a loading spinner

      case AsyncValueState.error:
        return Center(
          child: Text('Error: ${postListValue.error}'),
        ); // Display an error message

      case AsyncValueState.success:
        final posts = postListValue.data!;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostCard(post: post);
          },
        ); // Display the list of posts
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(
            post.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(post.description),
        ),
      ),
    );
  }
}
