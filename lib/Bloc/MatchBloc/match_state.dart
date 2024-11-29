part of 'match_bloc.dart';

abstract class MatchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MatchInitial extends MatchState {}

class MatchLoading extends MatchState {}

class MatchLoaded extends MatchState {
  final MatchModel match;

  MatchLoaded(this.match);

  @override
  List<Object?> get props => [match];
}

class MatchError extends MatchState {
  final String message;

  MatchError(this.message);

  @override
  List<Object?> get props => [message];
}