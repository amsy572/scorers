import 'package:equatable/equatable.dart';

class PlayerImageModel extends Equatable {
  final bool success;
  final String data;

  PlayerImageModel({required this.success, required this.data});

  factory PlayerImageModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == null || json['data'] == null) {
      throw FormatException("Missing required fields in MatchModel JSON.");
    }
    return PlayerImageModel(
      success: json['success'] as bool,
      data: json['data'],
    );
  }

  @override
  List<Object?> get props => [success, data];
}