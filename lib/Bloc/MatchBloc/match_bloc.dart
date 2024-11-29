import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../Models/MatchModel.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc() : super(MatchInitial()) {
    // Register the event handler for LoadMatchEvent
    on<LoadMatchEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(LoadMatchEvent event, Emitter<MatchState> emit) async {
    emit(MatchLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/match.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the MatchModel
      final match = MatchModel.fromJson(json);
      emit(MatchLoaded(match));
    } on PlatformException catch (e) {
      emit(MatchError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(MatchError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(MatchError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}

