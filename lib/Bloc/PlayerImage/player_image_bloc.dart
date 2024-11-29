import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:scorers/Models/PlayerImageModel.dart';

part 'player_image_event.dart';
part 'player_image_state.dart';

class PlayerImageBloc extends Bloc<PlayerImageEvent, PlayerImageState> {
  PlayerImageBloc() : super(PlayerImageInitial()) {
    // Register the event handler for LoadMatchEvent
    on<LoadPlayerImageEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(LoadPlayerImageEvent event, Emitter<PlayerImageState> emit) async {
    emit(PlayerImageLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/samplePlayerImage.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the PlayerImageModel
      final match = PlayerImageModel.fromJson(json);
      emit(PlayerImageLoaded(match));
    } on PlatformException catch (e) {
      emit(PlayerImageError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(PlayerImageError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(PlayerImageError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
