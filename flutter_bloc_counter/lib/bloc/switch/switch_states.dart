import 'package:equatable/equatable.dart';

class SwitchStates extends Equatable {
  final bool isSwitch;

  const SwitchStates({this.isSwitch = false});

  SwitchStates copyWith({bool? isSwitch}) {
    return SwitchStates(isSwitch: isSwitch ?? this.isSwitch);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isSwitch];
}
