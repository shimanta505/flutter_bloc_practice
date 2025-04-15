import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/bloc/counter/counter.dart';
import 'package:flutter_bloc_counter/bloc/counter/counter_block.dart';
import 'package:flutter_bloc_counter/bloc/counter/counter_state.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("counter"),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context.read<CounterBlock>().add(IncrementCounter());
              },
              child: Icon(Icons.plus_one),
            ),
            InkWell(
              onTap: () {
                context.read<CounterBlock>().add(DecrementCounter());
              },
              child: Icon(Icons.person),
            )
          ],
        ),
        body:
            BlocBuilder<CounterBlock, CounterState>(builder: (context, state) {
          return Center(
            child: Text(
              "${state.counter}",
              style: TextStyle(fontSize: 30),
            ),
          );
        }));
  }
}
