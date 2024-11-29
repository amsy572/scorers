import 'package:equatable/equatable.dart';

class LeagueLogoModel extends Equatable {
  final bool success;
  final String data;

  LeagueLogoModel({required this.success,
    required this.data
  }

      );

  factory LeagueLogoModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == null || json['data'] == null) {
      throw FormatException("Missing required fields in MatchModel JSON.");
    }
    return LeagueLogoModel(
      success: json['success'] as bool,
      data: json['data'],
    );
  }

  @override
  List<Object?> get props => [success,data];
}