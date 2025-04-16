import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/bloc/switch/switch_bloc.dart';
import 'package:flutter_bloc_counter/bloc/switch/switch_events.dart';
import 'package:flutter_bloc_counter/bloc/switch/switch_states.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('switch example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Notification'),
              BlocBuilder<SwitchBloc, SwitchStates>(
                  buildWhen: (previous, current) =>
                      //it will check previous object switch value
                      //and current switch value
                      previous.isSwitch != current.isSwitch,
                  builder: (context, state) {
                    print("notification ");
                    return Switch(
                        value: state.isSwitch,
                        onChanged: (value) {
                          context
                              .read<SwitchBloc>()
                              .add(EnableOrDisableSwitch());
                        });
                  }),
            ],
          ),
          SizedBox(height: 10),
          BlocBuilder<SwitchBloc, SwitchStates>(
            buildWhen: (previous, current) =>
                previous.isSwitch == current.isSwitch,
            builder: (context, state) => Container(
                height: 200,
                color: Colors.red.withValues(alpha: state.sliderVal)),
          ),
          SizedBox(height: 10),
          BlocBuilder<SwitchBloc, SwitchStates>(
            buildWhen: (previous, current) =>
                previous.isSwitch == current.isSwitch,
            builder: (context, state) {
              print('slider');
              return Slider(
                  value: state.sliderVal,
                  onChanged: (val) {
                    context
                        .read<SwitchBloc>()
                        .add(SliderValNotifier(slider: val));
                  });
            },
          ),
        ],
      ),
    );
  }
}
