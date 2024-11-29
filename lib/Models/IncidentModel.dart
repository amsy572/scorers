import 'package:equatable/equatable.dart';

class IncidentModel extends Equatable {
  final bool success;
  final MatchData data;

  IncidentModel({required this.success,
    required this.data
  });

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == null || json['data'] == null) {
      throw FormatException("Missing required fields in MatchModel JSON.");
    }
    return IncidentModel(
      success: json['success'] as bool,
      data: MatchData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [success,data];
}

// class MatchResponse {
//   final bool success;
//   final MatchData data;
//
//   MatchResponse({required this.success, required this.data});
//
//   factory MatchResponse.fromJson(Map<String, dynamic> json) {
//     return MatchResponse(
//       success: json['success'],
//       data: MatchData.fromJson(json['data']),
//     );
//   }
// }
//
// class MatchData {
//   final List<Incident> incidents;
//
//   MatchData({required this.incidents});
//
//   factory MatchData.fromJson(Map<String, dynamic> json) {
//     var incidentsList = json['incidents'] as List;
//     List<Incident> incidents = incidentsList.map((i) => Incident.fromJson(i)).toList();
//     return MatchData(incidents: incidents);
//   }
// }
class MatchData extends Equatable {
  final List<Incident> incidents;

  MatchData({required this.incidents});

  factory MatchData.fromJson(Map<String, dynamic> json) {
    var incidentsList = (json['incidents'] as List)
        .map((incidentJson) => Incident.fromJson(incidentJson))
        .toList();

    return MatchData(incidents: incidentsList);
  }

  @override
  List<Object?> get props => [incidents];
}

class Incident {
  final String? text;
  final int? homeScore;
  final int? awayScore;
  final bool? isLive;
  final int? time;
  final int? addedTime;
  final int? timeSeconds;
  final int? reversedPeriodTime;
  final int? reversedPeriodTimeSeconds;
  final String? incidentType;
  final PlayerIn? playerIn;
  final PlayerOut? playerOut;
  final Player? player;
  final int? sequence;
  final String? description;
  final int? id;
  final bool? isHome;
  final String? incidentClass;
  final String? reason;

  Incident({
    this.text,
    this.homeScore,
     this.awayScore,
     this.isLive,
     this.time,
     this.addedTime,
     this.timeSeconds,
    this.reversedPeriodTime,
     this.reversedPeriodTimeSeconds,
     this.incidentType,
    this.player,
    this.playerIn,
    this.playerOut,
     this.sequence,
    this.description,
    this.id,
     this.isHome,
     this.incidentClass,
     this.reason,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    // print("player: ${json['player']}");
    // print("playerIn: ${json['playerIn']}");
    // print("playerOut: ${json['playerOut']}");
    return Incident(
      text: json['text'],
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
      isLive: json['isLive'],
      time: json['time'],
      addedTime: json['addedTime'],
      timeSeconds: json['timeSeconds'],
      reversedPeriodTime: json['reversedPeriodTime'],
      reversedPeriodTimeSeconds: json['reversedPeriodTimeSeconds'],
      incidentType: json['incidentType'],
      player: json.containsKey('player') && json['player'] != null
          ? Player.fromJson(json['player'])
          : null,
      playerIn: json.containsKey('playerIn') && json['playerIn'] != null
          ? PlayerIn.fromJson(json['playerIn'])
          : null,
      playerOut: json.containsKey('playerOut') && json['playerOut'] != null
          ? PlayerOut.fromJson(json['playerOut'])
          : null,
      // penaltyPlayer:  PenaltyPlayer.fromJson(json['player'])  ,
      sequence: json['sequence'],
      description: json['description'],
      id: json['id'],
      isHome: json['isHome'],
      incidentClass: json['incidentClass'],
      reason: json['reason'],
    );
  }
}

class Player {
  final String? name;
  final String? slug;
  final String? shortName;
  final String? position;
  final String? jerseyNumber;
  final int? height;
  final int? userCount;
  final int? id;
  final String? marketValueCurrency;
  final int? dateOfBirthTimestamp;
  // final MarketValue proposedMarketValueRaw;
  // final FieldTranslations fieldTranslations;

  Player({
     this.name,
    this.slug,
    this.shortName,
     this.position,
    this.jerseyNumber,
    this.height,
     this.userCount,
     this.id,
    this.marketValueCurrency,
    this.dateOfBirthTimestamp,
    // required this.proposedMarketValueRaw,
    // required this.fieldTranslations,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    // print('Player data: ${json['player']}');
    return Player(
      name: json['name'],
      slug: json['slug'],
      shortName: json['shortName'],
      position: json['position'],
      jerseyNumber: json['jerseyNumber'],
      height: json['height'],
      userCount: json['userCount'],
      id: json['id'],
      marketValueCurrency: json['marketValueCurrency'],
      dateOfBirthTimestamp: json['dateOfBirthTimestamp'],
      // proposedMarketValueRaw: MarketValue.fromJson(json['proposedMarketValueRaw']),
      // fieldTranslations: FieldTranslations.fromJson(json['fieldTranslations']),
    );
  }
}



class PlayerOut {
  final String? name;
  final String? slug;
  final String? shortName;
  final String? position;
  final String? jerseyNumber;
  final int? height;
  final int? userCount;
  final int? id;
  final String? marketValueCurrency;
  final int? dateOfBirthTimestamp;
  // final MarketValue proposedMarketValueRaw;
  // final FieldTranslations fieldTranslations;

  PlayerOut({
    this.name,
    this.slug,
    this.shortName,
    this.position,
    this.jerseyNumber,
    this.height,
    this.userCount,
    this.id,
    this.marketValueCurrency,
    this.dateOfBirthTimestamp,
    // required this.proposedMarketValueRaw,
    // required this.fieldTranslations,
  });

  factory PlayerOut.fromJson(Map<String, dynamic> json) {
    // print('Player data: ${json['player']}');
    return PlayerOut(
      name: json['name'],
      slug: json['slug'],
      shortName: json['shortName'],
      position: json['position'],
      jerseyNumber: json['jerseyNumber'],
      height: json['height'],
      userCount: json['userCount'],
      id: json['id'],
      marketValueCurrency: json['marketValueCurrency'],
      dateOfBirthTimestamp: json['dateOfBirthTimestamp'],
      // proposedMarketValueRaw: MarketValue.fromJson(json['proposedMarketValueRaw']),
      // fieldTranslations: FieldTranslations.fromJson(json['fieldTranslations']),
    );
  }
}


class PlayerIn {
  final String? name;
  final String? slug;
  final String? shortName;
  final String? position;
  final String? jerseyNumber;
  final int? height;
  final int? userCount;
  final int? id;
  final String? marketValueCurrency;
  final int? dateOfBirthTimestamp;
  // final MarketValue proposedMarketValueRaw;
  // final FieldTranslations fieldTranslations;

  PlayerIn({
    this.name,
    this.slug,
    this.shortName,
    this.position,
    this.jerseyNumber,
    this.height,
    this.userCount,
    this.id,
    this.marketValueCurrency,
    this.dateOfBirthTimestamp,
    // required this.proposedMarketValueRaw,
    // required this.fieldTranslations,
  });

  factory PlayerIn.fromJson(Map<String, dynamic> json) {
    // print('Player data: ${json['player']}');
    return PlayerIn(
      name: json['name'],
      slug: json['slug'],
      shortName: json['shortName'],
      position: json['position'],
      jerseyNumber: json['jerseyNumber'],
      height: json['height'],
      userCount: json['userCount'],
      id: json['id'],
      marketValueCurrency: json['marketValueCurrency'],
      dateOfBirthTimestamp: json['dateOfBirthTimestamp'],
      // proposedMarketValueRaw: MarketValue.fromJson(json['proposedMarketValueRaw']),
      // fieldTranslations: FieldTranslations.fromJson(json['fieldTranslations']),
    );
  }
}

class MarketValue {
  final int value;
  final String currency;

  MarketValue({required this.value, required this.currency});

  factory MarketValue.fromJson(Map<String, dynamic> json) {
    return MarketValue(
      value: json['value'],
      currency: json['currency'],
    );
  }
}

class FieldTranslations {
  final NameTranslation nameTranslation;
  final NameTranslation shortNameTranslation;

  FieldTranslations({required this.nameTranslation, required this.shortNameTranslation});

  factory FieldTranslations.fromJson(Map<String, dynamic> json) {
    return FieldTranslations(
      nameTranslation: NameTranslation.fromJson(json['nameTranslation']),
      shortNameTranslation: NameTranslation.fromJson(json['shortNameTranslation']),
    );
  }
}

class NameTranslation {
  final String ar;

  NameTranslation({required this.ar});

  factory NameTranslation.fromJson(Map<String, dynamic> json) {
    return NameTranslation(
      ar: json['ar'],
    );
  }
}

class PenaltyPlayer {
  String name;
  String slug;
  String shortName;
  String position;
  int jerseyNumber;
  int height;
  int userCount;
  int id;
  String marketValueCurrency;
  int dateOfBirthTimestamp;
  MarketValue proposedMarketValueRaw;
  FieldTranslations fieldTranslations;
  int homeScore;
  int awayScore;
  int sequence;
  String description;
  int incidentId;
  String incidentType;
  bool isHome;
  String incidentClass;
  String reason;

  PenaltyPlayer({
    required this.name,
    required this.slug,
    required this.shortName,
    required this.position,
    required this.jerseyNumber,
    required this.height,
    required this.userCount,
    required this.id,
    required this.marketValueCurrency,
    required this.dateOfBirthTimestamp,
    required this.proposedMarketValueRaw,
    required this.fieldTranslations,
    required this.homeScore,
    required this.awayScore,
    required this.sequence,
    required this.description,
    required this.incidentId,
    required this.incidentType,
    required this.isHome,
    required this.incidentClass,
    required this.reason,
  });

  factory PenaltyPlayer.fromJson(Map<String, dynamic> json) {
    return PenaltyPlayer(
      name: json['player']['name'],
      slug: json['player']['slug'],
      shortName: json['player']['shortName'],
      position: json['player']['position'],
      jerseyNumber: json['player']['jerseyNumber'],
      height: json['player']['height'],
      userCount: json['player']['userCount'],
      id: json['player']['id'],
      marketValueCurrency: json['player']['marketValueCurrency'],
      dateOfBirthTimestamp: json['player']['dateOfBirthTimestamp'],
      proposedMarketValueRaw: MarketValue.fromJson(json['player']['proposedMarketValueRaw']),
      fieldTranslations: FieldTranslations.fromJson(json['player']['fieldTranslations']),
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
      sequence: json['sequence'],
      description: json['description'],
      incidentId: json['id'],
      incidentType: json['incidentType'],
      isHome: json['isHome'],
      incidentClass: json['incidentClass'],
      reason: json['reason'],
    );
  }
}






