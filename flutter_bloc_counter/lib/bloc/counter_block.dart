import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/bloc/counter.dart';
import 'package:flutter_bloc_counter/bloc/counter_state.dart';

class CounterBlock extends Bloc<CounterEvent, CounterState> {
  CounterBlock(super.initialState) {
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
  }

  _increment(IncrementCounter event, Emitter emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  _decrement(DecrementCounter event, Emitter emit) {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
