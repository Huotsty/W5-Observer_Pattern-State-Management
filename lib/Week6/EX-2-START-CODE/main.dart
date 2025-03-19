import 'package:flutter/material.dart';
import 'package:week5/Week6/EX-2-START-CODE/repository/http_posts_repository.dart';
import 'package:week5/Week6/EX-2-START-CODE/ui/screens/get_one_post_screen.dart';

import 'repository/post_repository.dart';
import 'package:provider/provider.dart';

import 'ui/providers/post_provider.dart';


void main() {
  // 1- Create the repository
  PostRepository postRepo = HttpPostRepository();

  // 2 - Run the UI
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(repository: postRepo),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: PostScreenOne()),
    ),
  );
}
