part of 'match_stats_bloc.dart';



abstract class MatchStatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MatchStatsInitial extends MatchStatsState {}

class MatchStatsLoading extends MatchStatsState {}

class MatchStatsLoaded extends MatchStatsState {
  final MatchStatsModel matchStats;

  MatchStatsLoaded(this.matchStats);

  @override
  List<Object?> get props => [matchStats];
}

class MatchStatsError extends MatchStatsState {
  final String message;

  MatchStatsError(this.message);

  @override
  List<Object?> get props => [message];
}
