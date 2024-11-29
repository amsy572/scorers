import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:scorers/Models/VideoHighlightModel.dart';

part 'video_hl_event.dart';
part 'video_hl_state.dart';

class VideoHlBloc extends Bloc<VideoHlEvent, VideoHlState> {
  VideoHlBloc() : super(VideoHlInitial()) {
    on<LoadVideoHlEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(LoadVideoHlEvent event, Emitter<VideoHlState> emit) async {
    emit(VideoHlLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/videoHighlight.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the VideoHLModel
      final match = VideoHLModel.fromJson(json);
      emit(VideoHlLoaded(match));
    } on PlatformException catch (e) {
      emit(VideoHlError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(VideoHlError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(VideoHlError("An unexpected error occurred: ${e.toString()}"));
    }


  }
}
