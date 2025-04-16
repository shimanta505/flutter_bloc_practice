import 'package:equatable/equatable.dart';

class SwitchStates extends Equatable {
  final bool isSwitch;
  final double sliderVal;

  const SwitchStates({this.isSwitch = false, this.sliderVal = 0.0});

  SwitchStates copyWith({bool? isSwitch, double? slider}) {
    return SwitchStates(
        isSwitch: isSwitch ?? this.isSwitch, sliderVal: slider ?? sliderVal);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isSwitch, sliderVal];
}
