import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:scorers/Models/MatchStatsModel.dart';

part 'match_stats_event.dart';
part 'match_stats_state.dart';

class MatchStatsBloc extends Bloc<MatchStatsEvent, MatchStatsState> {
  MatchStatsBloc() : super(MatchStatsInitial()) {
    on<LoadMatchStatsEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(LoadMatchStatsEvent event, Emitter<MatchStatsState> emit) async {
    emit(MatchStatsLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/matchstats.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the MatchStatsModel
      final match = MatchStatsModel.fromJson(json);
      emit(MatchStatsLoaded(match));
    } on PlatformException catch (e) {
      emit(MatchStatsError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(MatchStatsError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(MatchStatsError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
