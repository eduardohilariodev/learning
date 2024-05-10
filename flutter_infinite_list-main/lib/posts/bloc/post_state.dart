part of 'post_bloc.dart';

/// Our presentation layer will need to have several pieces of information in
/// order to properly lay itself out:
enum PostStatus {
  /// [initial] will tell the presentation layer it needs to render a loading
  ///  indicator while the initial batch of posts are loaded
  initial,

  /// [success] will tell the presentation layer it has content to render
  success,

  /// [failure] will tell the presentation layer that an error has occurred
  /// while fetching posts
  failure,
}

/// Represents the state of the PostBloc.
class PostState extends Equatable {
  /// [status] represents the current status of the bloc. [posts] represents the
  /// list of posts in the current state. [hasReachedMax] is a boolean value
  /// that indicates whether the maximum number of posts has been reached.
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  /// [hasReachedMax] will tell the presentation layer whether or not it has
  /// reached the maximum number of posts
  final bool hasReachedMax;

  /// [posts] will be the [List<Post>] which will be displayed
  final List<Post> posts;

  /// The status of the post, indicating whether it is currently loading,
  /// loaded, or failed to load.
  final PostStatus status;

  @override
  List<Object> get props => <Object>[status, posts, hasReachedMax];

  @override
  String toString() =>
      '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';

  /// We implemented [copyWith] so that we can copy an instance of
  /// [PostStatus.success] and update zero or more properties conveniently.
  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) =>
      PostState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );
}
