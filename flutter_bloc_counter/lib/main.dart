import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/bloc/counter/counter_block.dart';
import 'package:flutter_bloc_counter/bloc/counter/counter_state.dart';
import 'package:flutter_bloc_counter/bloc/switch/switch_bloc.dart';
import 'package:flutter_bloc_counter/bloc/switch/switch_states.dart';
import 'package:flutter_bloc_counter/ui/counter_screen.dart';
import 'package:flutter_bloc_counter/ui/switch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBlock(const CounterState(counter: 0)),
      child: BlocProvider(
        create: (_) => SwitchBloc(const SwitchStates(isSwitch: false)),
        child: MaterialApp(
          title: "counter app",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SwitchScreen(),
        ),
      ),
    );
  }
}
