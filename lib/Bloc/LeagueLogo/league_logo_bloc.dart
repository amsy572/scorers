import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:scorers/Models/LeagueLogoModel.dart';

part 'league_logo_event.dart';
part 'league_logo_state.dart';

class LeagueLogoBloc extends Bloc<LeagueLogoEvent, LeagueLogoState> {
  LeagueLogoBloc() : super(LeagueLogoInitial()) {
    // Register the event handler for LoadMatchEvent
    on<LoadLeagueLogoEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(LeagueLogoEvent event, Emitter<LeagueLogoState> emit) async {
    emit(LeagueLogoLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/sampleLeagueLogo.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the LeagueLogoModel
      final match = LeagueLogoModel.fromJson(json);
      emit(LeagueLogoLoaded(match));
    } on PlatformException catch (e) {
      emit(LeagueLogoError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(LeagueLogoError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(LeagueLogoError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
