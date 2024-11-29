import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:scorers/Models/MomentumModel.dart';

part 'momentum_event.dart';
part 'momentum_state.dart';

class MomentumBloc extends Bloc<MomentumEvent, MomentumState> {
  MomentumBloc() : super(MomentumInitial()) {
    on<LoadMomentumEvent>(_onLoadMatchEvent);
  }

  Future<void> _onLoadMatchEvent(LoadMomentumEvent event, Emitter<MomentumState> emit) async {
    emit(MomentumLoading());

    try {
      // Load JSON from assets
      final String jsonString = await rootBundle.loadString('assets/momentum.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);

      // Deserialize JSON into the MomentumModel
      final match = MomentumModel.fromJson(json);
      emit(MomentumLoaded(match));
    } on PlatformException catch (e) {
      emit(MomentumError("Could not load match data from assets: ${e.message}"));
    } on FormatException catch (e) {
      emit(MomentumError("Data format is incorrect: ${e.message}"));
    } catch (e) {
      emit(MomentumError("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
