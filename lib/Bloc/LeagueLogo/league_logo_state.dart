part of 'league_logo_bloc.dart';


abstract class LeagueLogoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeagueLogoInitial extends LeagueLogoState {}

class LeagueLogoLoading extends LeagueLogoState {}

class LeagueLogoLoaded extends LeagueLogoState {
  final LeagueLogoModel leagueLogo;

  LeagueLogoLoaded(this.leagueLogo);

  @override
  List<Object?> get props => [leagueLogo];
}

class LeagueLogoError extends LeagueLogoState {
  final String message;

  LeagueLogoError(this.message);

  @override
  List<Object?> get props => [message];
}
