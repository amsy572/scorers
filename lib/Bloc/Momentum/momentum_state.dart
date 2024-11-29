part of 'momentum_bloc.dart';

abstract class MomentumState extends Equatable {
  @override
  List<Object> get props => [];
}

class MomentumInitial extends MomentumState {}

class MomentumLoading extends MomentumState {}


class MomentumLoaded extends MomentumState {
  final MomentumModel momentum;

  MomentumLoaded(this.momentum);

  @override
  // TODO: implement props
  List<Object> get props => [momentum];
}


class MomentumError extends MomentumState {
  final String message;

  MomentumError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
