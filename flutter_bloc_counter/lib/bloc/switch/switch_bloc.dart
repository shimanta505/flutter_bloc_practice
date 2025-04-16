import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/bloc/switch/switch_events.dart';
import 'package:flutter_bloc_counter/bloc/switch/switch_states.dart';

class SwitchBloc extends Bloc<SwitchEvents, SwitchStates> {
  SwitchBloc(super.initialState) {
    on<EnableOrDisableSwitch>(_enableOrDisable);
    on<SliderValNotifier>(_sliderNotifier);
  }

  _enableOrDisable(EnableOrDisableSwitch events, Emitter<SwitchStates> emit) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  _sliderNotifier(SliderValNotifier events, Emitter<SwitchStates> emit) {
    emit(state.copyWith(slider: events.slider));
  }
}
