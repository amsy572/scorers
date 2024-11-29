part of 'incidents_bloc.dart';

abstract class IncidentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IncidentsInitial extends IncidentsState {}

class IncidentsLoading extends IncidentsState {}

class IncidentsLoaded extends IncidentsState {
  final IncidentModel incident;

  IncidentsLoaded(this.incident);

  @override
  List<Object?> get props => [incident];
}

class IncidentsError extends IncidentsState {
  final String message;

  IncidentsError(this.message);

  @override
  List<Object?> get props => [message];
}
