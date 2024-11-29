import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:scorers/Models/BestPlayerModel.dart';

part 'best_player_event.dart';
part 'best_player_state.dart';


class BestPlayerBloc extends Bloc<BestPlayerEvent, BestPlayerState> {
  BestPlayerBloc() : super(BestPlayerInitial()) {
    // Register the event handler for LoadMatchEvent
    on<LoadBestPlayerEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(BestPlayerEvent event, Emitter<BestPlayerState> emit) async {
    emit(BestPlayerLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/bestPlayer.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the MatchModel
      final match = Bestplayermodel.fromJson(json);
      emit(BestPlayerLoaded(match));
    } on PlatformException catch (e) {
      emit(BestPlayerError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(BestPlayerError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(BestPlayerError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}