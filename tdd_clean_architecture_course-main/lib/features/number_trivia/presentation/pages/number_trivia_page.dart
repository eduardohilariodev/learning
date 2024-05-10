import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) =>
      BlocProvider<NumberTriviaBloc>(
        create: (_) => sl<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (BuildContext context, NumberTriviaState state) =>
                      DisplayContainer(
                    child: _buildContent(state),
                  ),
                ),
                const SizedBox(height: 20),
                const TriviaControls(),
              ],
            ),
          ),
        ),
      );

  dynamic _buildContent(NumberTriviaState state) {
    if (state is NumberTriviaInitial) {
      return const MessageDisplay(message: 'Start searching!');
    } else if (state is NumberTriviaLoading) {
      return const CircularProgressIndicator();
    } else if (state is NumberTriviaSuccess) {
      return TriviaDisplay(numberTrivia: state.trivia);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: buildBody(context),
      );
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    super.key,
  });

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController inputNumberEC = TextEditingController();

  String inputString = '';

  void addConcrete() {
    inputNumberEC.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputString));
  }

  void addRandom() {
    inputNumberEC.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          TextField(
            controller: inputNumberEC,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (String value) {
              inputString = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FilledButton.tonal(
                  style: const ButtonStyle(),
                  onPressed: addConcrete,
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FilledButton(
                  style: const ButtonStyle(),
                  onPressed: addRandom,
                  child: Text(
                    'Get random trivia',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
