import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/posts/widgets/bottom_loader.dart';
import 'package:flutter_infinite_list/posts/widgets/post_list_item.dart';

/// Represents a list of posts in the UI.
class PostsList extends StatefulWidget {
  /// Initializes a new instance of [PostsList]. The purpose of [PostsList] is
  /// to display posts fetched via the [PostBloc]. It extends [StatefulWidget]
  /// because it owns mutable states like a [ScrollController].
  ///
  /// The widget listens to scroll events to possibly trigger more data loading.
  /// The associated [PostBloc] instance can be accessed using
  /// `context.read<PostBloc>()`.
  ///
  /// {@template posts_list_usage}
  /// ## Usage
  ///
  /// To use [PostsList], you need to make sure that [PostBloc] is available in
  /// the widget tree. You can either directly instantiate it or provide it
  /// using a dependency injection framework.
  /// {@endtemplate}
  ///
  /// Accepts an optional [key] which can be used by its parent widgets to
  /// distinguish multiple instances of [PostsList].
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  /// We need to remember to clean up after ourselves and [dispose] of our
  /// [ScrollController] when the [StatefulWidget] is disposed.
  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  /// Whenever the user scrolls, we calculate with `_isBottom` how far you have
  /// scrolled down the page and if our distance is ≥ 90% of our
  /// `maxScrollextent` we add a [PostFetched] event in order to load more
  /// posts.
  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    /// Moving along, our build method returns a [BlocBuilder].  [BlocBuilder]
    /// is a Flutter widget from the [flutter_bloc
    /// package](https://pub.dev/packages/flutter_bloc) which handles building a
    /// widget in response to new bloc states.  Any time our PostBloc state
    /// changes, our builder function will be called with the new PostState.
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? const BottomLoader()
                    : PostListItem(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
