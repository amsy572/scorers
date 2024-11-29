part of 'best_player_bloc.dart';


abstract class BestPlayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BestPlayerInitial extends BestPlayerState {}

class BestPlayerLoading extends BestPlayerState {}

class BestPlayerLoaded extends BestPlayerState {
  final Bestplayermodel player;

  BestPlayerLoaded(this.player);

  @override
  List<Object?> get props => [player];
}

class BestPlayerError extends BestPlayerState {
  final String message;

  BestPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}

