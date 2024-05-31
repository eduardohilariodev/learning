import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const int _postLimit = 20;

/// The duration used to throttle events in the post bloc.
const Duration throttleDuration = Duration(milliseconds: 100);

/// Returns an [EventTransformer] that throttles incoming events for a given
/// [duration] and drops any events that occur during that time. The returned
/// [EventTransformer] takes a stream of `events` and a `mapper` function that
/// maps each event to a new stream of events. The incoming events are throttled
/// using the given [duration], and any events that occur during that time are
/// dropped. The resulting stream of events is then mapped using the `mapper`
/// function.
EventTransformer<E> throttleDroppable<E>(Duration duration) =>
    (Stream<E> events, Stream<E> Function(E) mapper) =>
        droppable<E>().call(events.throttle(duration), mapper);

/// At a high level, [PostBloc] will be responding to user input (scrolling) and
/// fetching more posts in order for the presentation layer to display them.
///
/// Our [PostBloc] will only be responding to a single event; [PostFetched]
/// which will be added by the presentation layer whenever it needs more Posts
/// to present.
class PostBloc extends Bloc<PostEvent, PostState> {
  /// Just from the class declaration we can tell that our [PostBloc] will be
  /// taking [PostEvent] as input and outputting [PostState].
  ///
  /// One optimization we can make is to debounce the `events` in order to
  /// prevent spamming our API unnecessarily. We can do this by overriding the
  /// `transform` method in our [PostBloc].
  ///
  /// Passing a `transformer` to `on<PostFetched>` allows us to customize how
  /// events are processed.
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  /// Now every time a [PostEvent] is added, if it is a [PostFetched] event
  /// and there are more posts to fetch, our [PostBloc] will
  /// fetch the next 20 posts.
  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List<dynamic>;
      return body.map((json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  /// Our [PostBloc] will emit new states via the [Emitter<PostState>] provided
  /// in the event handler. Check out core concepts for more information.
  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }

      final posts = await _fetchPosts(state.posts.length);

      /// The API will return an empty array if we try to fetch beyond
      /// the maximum number of posts (100), so if we get back an empty array,
      /// our bloc will [emit] the currentState except we will
      /// set [hasReachedMax] to true. If we cannot retrieve the posts,
      /// we throw an exception and emit [PostFailure()].
      emit(
        posts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                /// If we can retrieve the posts, we return [PostSuccess()]
                /// which takes the entire list of posts.
                status: PostStatus.success,
                posts: List<Post>.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
      );
    } on Exception {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
