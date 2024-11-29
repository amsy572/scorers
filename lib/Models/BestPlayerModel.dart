import 'package:equatable/equatable.dart';




class Bestplayermodel extends Equatable {
  final bool success;
  final List<BEventData> data; // Always treat as a list

  Bestplayermodel({required this.success, required this.data});

  factory Bestplayermodel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == null || json['data'] == null) {
      throw FormatException("Missing required fields in Bestplayermodel JSON.");
    }

    // Handle both single and list cases
    var data = json['data'];
    List<BEventData> eventDataList;

    if (data is List) {
      eventDataList = data
          .map((item) => BEventData.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      eventDataList = [BEventData.fromJson(data as Map<String, dynamic>)];
    }

    return Bestplayermodel(
      success: json['success'] as bool,
      data: eventDataList,
    );
  }

  @override
  List<Object?> get props => [success, data];
}

class BEventData extends Equatable {
  final HBPlayer hbPlayer;
  final ABPlayer abPlayer;

  BEventData({required this.hbPlayer,required this.abPlayer});

  factory BEventData.fromJson(Map<String, dynamic> json) {
    return BEventData(
      hbPlayer: HBPlayer.fromJson(json['bestHomeTeamPlayer']),
      abPlayer: ABPlayer.fromJson(json['bestAwayTeamPlayer']),
    );
  }

  @override
  List<Object?> get props => [abPlayer,hbPlayer];
}


class HBPlayer extends Equatable {
  final String value;
  final BPlayer player;

  HBPlayer({
    required this.value,
    required this.player,
  });

  factory HBPlayer.fromJson(Map<String, dynamic> json) {
    return HBPlayer(
      value: json['value'],
      player: BPlayer.fromJson(json['player']),
    );
  }

  @override
  List<Object?> get props => [value, player];
}


class ABPlayer extends Equatable {
  final String value;
  final BPlayer player;

  ABPlayer({
    required this.value,
    required this.player,
  });

  factory ABPlayer.fromJson(Map<String, dynamic> json) {
    return ABPlayer(
      value: json['value'],
      player: BPlayer.fromJson(json['player']),
    );
  }

  @override
  List<Object?> get props => [value, player];
}


class BPlayer extends Equatable {
  final String shortName;
  final int id;

  BPlayer({
    required this.shortName,
    required this.id,
  });

  factory BPlayer.fromJson(Map<String, dynamic> json) {
    return BPlayer(
    shortName: json['shortName'],
      id: json['id'],
    );
  }

  @override
  List<Object?> get props => [shortName, id];
}

