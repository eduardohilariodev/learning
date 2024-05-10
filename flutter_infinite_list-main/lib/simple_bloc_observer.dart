// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';

/// One added bonus of using the bloc library is that we can have access to all
/// **Transitions** in one place.
///
/// > The change from one state to another is called a **Transition**. A
/// **Transition** consists of the current state, the event, and the next state.
class SimpleBlocObserver extends BlocObserver {
  /// Even though in this application we only have one bloc, it's fairly common
  /// in larger applications to have many blocs managing different parts of the
  /// application's state. If we want to be able to do something in response to
  /// all Transitions we can simply create our own [BlocObserver].
  ///
  /// In practice, you can create different **BlocObservers** and because every
  /// state change is recorded, we are able to very easily instrument our
  /// applications and track all user interactions and state changes in one
  /// place!
  const SimpleBlocObserver();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }

  /// All we need to do is extend [BlocObserver] and override the `onTransition`
  /// method.
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);

    /// Now every time a **Bloc Transition** occurs we can see the transition
    /// printed to the console.
    print(transition);
  }
}
