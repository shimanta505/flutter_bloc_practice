import 'package:equatable/equatable.dart';

abstract class SwitchEvents extends Equatable {
  const SwitchEvents();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EnableOrDisableSwitch extends SwitchEvents {}
