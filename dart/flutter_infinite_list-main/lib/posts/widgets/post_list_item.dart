import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';

/// A widget that displays a single post item in a list.
class PostListItem extends StatelessWidget {
  /// The [post] parameter is required and represents the post to be displayed.
  /// The [key] parameter is optional and is used to identify the widget.
  const PostListItem({required this.post, super.key});

  /// A widget that displays a single post item.
  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${post.id}', style: textTheme.bodySmall),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}
