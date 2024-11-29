import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:scorers/Models/IncidentModel.dart';

part 'incidents_event.dart';
part 'incidents_state.dart';


class IncidentsBloc extends Bloc<IncidentsEvent, IncidentsState> {
  IncidentsBloc() : super(IncidentsInitial()) {
    // Register the event handler for LoadMatchEvent
    on<IncidentsEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(IncidentsEvent event, Emitter<IncidentsState> emit) async {
    emit(IncidentsLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/incidents.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the  IncidentModel
      final match = IncidentModel.fromJson(json);
      emit(IncidentsLoaded(match));
    } on PlatformException catch (e) {
      emit(IncidentsError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(IncidentsError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(IncidentsError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
