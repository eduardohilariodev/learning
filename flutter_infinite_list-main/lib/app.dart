import 'package:flutter/material.dart';

import 'package:flutter_infinite_list/posts/view/posts_page.dart';

/// In our App widget, the root of our project,
/// we can then set the home to PostsPage
class App extends MaterialApp {
  const App({super.key}) : super(home: const PostsPage());
}
