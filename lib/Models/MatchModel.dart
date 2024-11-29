import 'package:equatable/equatable.dart';

class MatchModel extends Equatable {
  final bool success;
  final EventData data;

  MatchModel({required this.success, required this.data});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == null || json['data'] == null) {
      throw FormatException("Missing required fields in MatchModel JSON.");
    }
    return MatchModel(
      success: json['success'] as bool,
      data: EventData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [success, data];
}

class EventData extends Equatable {
  final Event event;

  EventData({required this.event});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      event: Event.fromJson(json['event']),
    );
  }

  @override
  List<Object?> get props => [event];
}

class Event extends Equatable {
  final Tournament tournament;
  final Team homeTeam;
  final Team awayTeam;
  final ATeamScore aTeamScore;
  final HTeamScore hTeamScore;
  final Referee referee;
  final Venue venue;
  final Season season;

  Event( {
    required this.tournament,
    required this.homeTeam,
    required this.awayTeam,
    required this.aTeamScore, 
    required this.hTeamScore, 
    required this.referee,
    required this.venue,
    required this.season
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      tournament: Tournament.fromJson(json['tournament']),
      homeTeam: Team.fromJson(json['homeTeam']),
      awayTeam: Team.fromJson(json['awayTeam']),
      aTeamScore: ATeamScore.fromJson(json["awayScore"]),
      hTeamScore: HTeamScore.fromJson(json["homeScore"]),
      referee: Referee.fromJson(json["referee"]),
      venue: Venue.fromJson(json['venue']),
      season: Season.fromJson(json["season"]),
    );
  }

  @override
  List<Object?> get props => [tournament, homeTeam,
    // awayTeam
  ];
}

class Tournament extends Equatable {
  final String name;
  final String slug;


  Tournament({
    required this.name,
    required this.slug,

  });

  factory Tournament.fromJson(Map<String, dynamic> json) {

    return Tournament(
      name: json['name'],
      slug: json['slug'],

    );
  }

  @override
  List<Object?> get props => [name, slug];
}

class Season {
  final String name;
  final String year;
  final bool editor;
  final int id;

  Season({
    required this.name,
    required this.year,
    required this.editor,
    required this.id,
  });

  // Factory method to create a Season instance from a JSON map
  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      name: json['name'] ?? '',
      year: json['year'] ?? '',
      editor: json['editor'] ?? false,
      id: json['id'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [name,year,editor,id];
}


class ATeamScore extends Equatable {
  final int current;
  final int display;
  final int period1;
  final int period2;
  final int normaltime;
  final int extra1;
  final int extra2;
  final int overtime;
  final int penalties;
  final int aggregated;

  ATeamScore({required this.current,
    required this.display,
    required this.period1,
    required this.period2,
    required this.normaltime,
    required this.extra1,
    required this.extra2,
    required this.overtime,
    required this.penalties,
    required this.aggregated,

  });

  factory ATeamScore.fromJson(Map<String, dynamic> json) {
    return ATeamScore(
        current: json['current'],
        display: json['display'],
        period1: json['period1'],
        period2: json['period2'],
        normaltime: json['normaltime'],
        extra1: json['extra1'],
        extra2: json['extra2'],
        overtime: json['overtime'],
        penalties: json['penalties'],
        aggregated: json['aggregated']

    );
  }

  @override
  List<Object?> get props => [current,display,period1,period2,normaltime,extra1,extra2,overtime,penalties,aggregated];
}

class Referee extends Equatable {
  final String name;
  final String slug;

  Referee({
    required this.name,
    required this.slug,
  });

  factory Referee.fromJson(Map<String, dynamic> json) {
    return Referee(
      name: json['name'],
      slug: json['slug'],
    );
  }

  @override
  List<Object?> get props => [name, slug];
}

class HTeamScore extends Equatable {
  final int current;
  final int display;
  final int period1;
  final int period2;
  final int normaltime;
  final int extra1;
  final int extra2;
  final int overtime;
  final int penalties;
  final int aggregated;

  HTeamScore({required this.current, 
    required this.display, 
    required this.period1, 
    required this.period2, 
    required this.normaltime, 
    required this.extra1, 
    required this.extra2, 
    required this.overtime, 
    required this.penalties, 
    required this.aggregated,
 
  });

  factory HTeamScore.fromJson(Map<String, dynamic> json) {
    return HTeamScore(
        current: json['current'],
        display: json['display'], 
        period1: json['period1'], 
        period2: json['period2'], 
        normaltime: json['normaltime'], 
        extra1: json['extra1'],
        extra2: json['extra2'], 
        overtime: json['overtime'], 
        penalties: json['penalties'], 
        aggregated: json['aggregated']
     
    );
  }

  @override
  List<Object?> get props => [current,display,period1,period2,normaltime,extra1,extra2,overtime,penalties,aggregated];
}

class Team extends Equatable {
  final String name;
  final String slug;
  final String shortName;
  final Country country;
  final TeamColors teamColors;
  final DateTime foundationDate;
  final Manager manager;
  final Venue venue;
  final int userCount;
  final Sport sport;
  final String teamLogo;

  Team({
    required this.name,
    required this.slug,
    required this.shortName,
    required this.country,
    required this.teamColors,
    required this.foundationDate,
    required this.manager,
    required this.venue,
    required this.userCount,
    required this.sport,
    required this.teamLogo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      slug: json['slug'],
      shortName: json['shortName'],
      country: Country.fromJson(json['country']),
      teamColors: TeamColors.fromJson(json['teamColors']),
      foundationDate: DateTime.fromMillisecondsSinceEpoch(json['foundationDateTimestamp'] * 1000),
      manager: Manager.fromJson(json['manager']),
      venue: Venue.fromJson(json['venue']),
      userCount: json['userCount'],
      sport: Sport.fromJson(json['sport']),
      teamLogo: json['logo'],
    );
  }

  @override
  List<Object?> get props => [
    name,
    slug,
    shortName,
    country,
    teamColors,
    foundationDate,
    manager,
    venue,
    userCount,
    sport,
    teamLogo,
  ];
}

class Country extends Equatable {
  final String name;
  final String alpha2;
  final String alpha3;

  Country({required this.name, required this.alpha2, required this.alpha3});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      alpha2: json['alpha2'],
      alpha3: json['alpha3'],
    );
  }

  @override
  List<Object?> get props => [name, alpha2, alpha3];
}

class TeamColors extends Equatable {
  final String primary;
  final String secondary;
  final String text;

  TeamColors({
    required this.primary,
    required this.secondary,
    required this.text,
  });

  factory TeamColors.fromJson(Map<String, dynamic> json) {
    return TeamColors(
      primary: json['primary'],
      secondary: json['secondary'],
      text: json['text'],
    );
  }

  @override
  List<Object?> get props => [primary, secondary, text];
}

class Manager extends Equatable {
  final String name;
  final String shortName;
  final Country country;

  Manager({
    required this.name,
    required this.shortName,
    required this.country,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      name: json['name'],
      shortName: json['shortName'],
      country: Country.fromJson(json['country']),
    );
  }

  @override
  List<Object?> get props => [name, shortName, country];
}

class Venue extends Equatable {
  final String name;
  final String slug;
  final City city;
  final Country country;
  final int capacity;
  final Coordinates coordinates;

  Venue({
    required this.name,
    required this.slug,
    required this.city,
    required this.country,
    required this.capacity,
    required this.coordinates,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      name: json['name'],
      slug: json['slug'],
      city: City.fromJson(json['city']),
      country: Country.fromJson(json['country']),
      capacity: json['capacity'],
      coordinates: Coordinates.fromJson(json['venueCoordinates']),
    );
  }

  @override
  List<Object?> get props => [name, slug, country,city, capacity, coordinates];
}

class Coordinates extends Equatable {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  @override
  List<Object?> get props => [latitude, longitude];
}

class Sport extends Equatable {
  final String name;
  final int id;

  Sport({required this.name, required this.id});

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  List<Object?> get props => [name, id];
}

class City extends Equatable {
  final String name;


  City({required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
    
    );
  }

  @override
  List<Object?> get props => [name];
}










// import 'package:equatable/equatable.dart';
//
// class MatchModel extends Equatable {
//   final bool success;
//   final EventData data;
//
//   MatchModel({required this.success, required this.data});
//
//   factory MatchModel.fromJson(Map<String, dynamic> json) {
//     if (json['success'] == null || json['data'] == null) {
//       throw FormatException("Missing required fields in MatchModel JSON.");
//     }
//     return MatchModel(
//       success: json['success'] as bool,
//       data: EventData.fromJson(json['data']),
//     );
//   }
//
//   @override
//   List<Object?> get props => [success, data];
// }
//
// class EventData extends Equatable {
//   final Event event;
//
//   EventData({required this.event});
//
//   factory EventData.fromJson(Map<String, dynamic> json) {
//     return EventData(
//       event: Event.fromJson(json['event']),
//     );
//   }
//
//   @override
//   List<Object?> get props => [event];
// }
//
// class Event extends Equatable {
//   final Tournament tournament;
//   final Team homeTeam;
//   final Team awayTeam;
//
//   Event({
//     required this.tournament,
//     required this.homeTeam,
//     required this.awayTeam,
//   });
//
//   /// Factory constructor for creating an instance of Event from a JSON map.
//   factory Event.fromJson(Map<String, dynamic> json) {
//     return Event(
//       tournament: Tournament.fromJson(json['tournament']),
//       homeTeam: Team.fromJson(json['home_team']),
//       awayTeam: Team.fromJson(json['away_team']),
//     );
//   }
//
//   /// Converts the Event instance back to a JSON map.
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'tournament': tournament.toJson(),
//   //     'home_team': homeTeam.toJson(),
//   //     'away_team': awayTeam.toJson(),
//   //   };
//   // }
//
//   @override
//   List<Object?> get props => [tournament, homeTeam, awayTeam];
// }
//
//
//
//
// class Tournament extends Equatable {
//   final String name;
//   final String slug;
//
//   Tournament({
//     required this.name,
//     required this.slug,
//   });
//
//   /// Factory constructor for creating an instance of Tournament from a JSON map.
//   factory Tournament.fromJson(Map<String, dynamic> json) {
//     return Tournament(
//       name: json['name'],
//       slug: json['slug'],
//     );
//   }
//
//   /// Converts the Tournament instance back to a JSON map.
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'slug': slug,
//     };
//   }
//
//   @override
//   List<Object?> get props => [name, slug];
// }
//
//
// class Team extends Equatable {
//   final String name;
//   final String slug;
//   final String shortName;
//   final Country country;
//   final TeamColors teamColors;
//   final DateTime foundationDate;
//   final Manager manager;
//   final Venue venue;
//   final int userCount;
//   final Sport sport;
//   final String teamLogo;
//
//   Team({
//     required this.name,
//     required this.slug,
//     required this.shortName,
//     required this.country,
//     required this.teamColors,
//     required this.foundationDate,
//     required this.manager,
//     required this.venue,
//     required this.userCount,
//     required this.sport,
//     required this.teamLogo,
//   });
//
//   factory Team.fromJson(Map<String, dynamic> json) {
//     return Team(
//       name: json['name'],
//       slug: json['slug'],
//       shortName: json['short_name'],
//       country: Country.fromJson(json['country']),
//       teamColors: TeamColors.fromJson(json['team_colors']),
//       foundationDate: DateTime.fromMillisecondsSinceEpoch(json['foundation_date_timestamp'] * 1000),
//       manager: Manager.fromJson(json['management']),
//       venue: Venue.fromJson(json['venue']),
//       userCount: json['user_count'],
//       sport: Sport.fromJson(json['sport']),
//       teamLogo: json['team_logo'],
//     );
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'name': name,
//   //     'slug': slug,
//   //     'short_name': shortName,
//   //     'country': country.toJson(),
//   //     'team_colors': teamColors.toJson(),
//   //     'foundation_date_timestamp': foundationDate.millisecondsSinceEpoch ~/ 1000,
//   //     'management': manager.toJson(),
//   //     'venue': venue.toJson(),
//   //     'user_count': userCount,
//   //     'sport': sport.toJson(),
//   //     'team_logo': teamLogo,
//   //   };
//   // }
//
//   @override
//   List<Object?> get props => [
//     name,
//     slug,
//     shortName,
//     country,
//     teamColors,
//     foundationDate,
//     manager,
//     venue,
//     userCount,
//     sport,
//     teamLogo,
//   ];
// }
//
// class Country extends Equatable {
//   final String name;
//   final String alpha2;
//   final String alpha3;
//
//   Country({required this.name, required this.alpha2, required this.alpha3});
//
//   factory Country.fromJson(Map<String, dynamic> json) {
//     return Country(
//       name: json['name'],
//       alpha2: json['alpha2'],
//       alpha3: json['alpha3'],
//     );
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   return {'name': name, 'alpha2': alpha2, 'alpha3': alpha3};
//   // }
//
//   @override
//   List<Object?> get props => [name, alpha2, alpha3];
// }
//
// class TeamColors extends Equatable {
//   final String primary;
//   final String secondary;
//   final String text;
//
//   TeamColors({required this.primary, required this.secondary, required this.text});
//
//   factory TeamColors.fromJson(Map<String, dynamic> json) {
//     return TeamColors(
//       primary: json['primary'],
//       secondary: json['secondary'],
//       text: json['text'],
//     );
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   return {'primary': primary, 'secondary': secondary, 'text': text};
//   // }
//
//   @override
//   List<Object?> get props => [primary, secondary, text];
// }
//
// class Manager extends Equatable {
//   final String name;
//   final String shortName;
//   final Country country;
//   final Map<String, Translation> translations;
//
//   Manager({
//     required this.name,
//     required this.shortName,
//     required this.country,
//     required this.translations,
//   });
//
//   factory Manager.fromJson(Map<String, dynamic> json) {
//     return Manager(
//       name: json['name'],
//       shortName: json['short_name'],
//       country: Country.fromJson(json['country']),
//       translations: (json['translations'] as Map<String, dynamic>).map(
//             (key, value) => MapEntry(key, Translation.fromJson(value)),
//       ),
//     );
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'name': name,
//   //     'short_name': shortName,
//   //     'country': country.toJson(),
//   //     'translations': translations.map((key, value) => MapEntry(key, value.toJson())),
//   //   };
//   // }
//
//   @override
//   List<Object?> get props => [name, shortName, country, translations];
// }
//
// class Translation extends Equatable {
//   final String name;
//   final String shortName;
//
//   Translation({required this.name, required this.shortName});
//
//   factory Translation.fromJson(Map<String, dynamic> json) {
//     return Translation(name: json['name'], shortName: json['short_name']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'name': name, 'short_name': shortName};
//   }
//
//   @override
//   List<Object?> get props => [name, shortName];
// }
//
// class Venue extends Equatable {
//   final String name;
//   final String slug;
//   final String city;
//   final Country country;
//   final int capacity;
//   final Coordinates coordinates;
//   final String arabicTranslation;
//
//   Venue({
//     required this.name,
//     required this.slug,
//     required this.city,
//     required this.country,
//     required this.capacity,
//     required this.coordinates,
//     required this.arabicTranslation,
//   });
//
//   factory Venue.fromJson(Map<String, dynamic> json) {
//     return Venue(
//       name: json['name'],
//       slug: json['slug'],
//       city: json['city'],
//       country: Country.fromJson(json['country']),
//       capacity: json['capacity'],
//       coordinates: Coordinates.fromJson(json['coordinates']),
//       arabicTranslation: json['arabic_translation'],
//     );
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'name': name,
//   //     'slug': slug,
//   //     'city': city,
//   //     'country': country.toJson(),
//   //     'capacity': capacity,
//   //     'coordinates': coordinates.toJson(),
//   //     'arabic_translation': arabicTranslation,
//   //   };
//   // }
//
//   @override
//   List<Object?> get props => [name, slug, city, country, capacity, coordinates, arabicTranslation];
// }
//
// class Coordinates extends Equatable {
//   final double latitude;
//   final double longitude;
//
//   Coordinates({required this.latitude, required this.longitude});
//
//   factory Coordinates.fromJson(Map<String, dynamic> json) {
//     return Coordinates(
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//     );
//   }
//   //
//   // Map<String, dynamic> toJson() {
//   //   return {'latitude': latitude, 'longitude': longitude};
//   // }
//
//   @override
//   List<Object?> get props => [latitude, longitude];
// }
//
// class Sport extends Equatable {
//   final String name;
//   final int id;
//
//   Sport({required this.name, required this.id});
//
//   factory Sport.fromJson(Map<String, dynamic> json) {
//     return Sport(name: json['name'], id: json['id']);
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   return {'name': name, 'id': id};
//   // }
//
//   @override
//   List<Object?> get props => [name, id];
// }
//
//
//
//
//
//
// // class Event extends Equatable {
// //   final Tournament tournament;
// //   final Team homeTeam;
// //   final Team awayTeam;
// //
// //   Event({
// //     required this.tournament,
// //     required this.homeTeam,
// //     required this.awayTeam,
// //   });
// //
// //   factory Event.fromJson(Map<String, dynamic> json) {
// //     return Event(
// //       tournament: Tournament.fromJson(json['tournament']),
// //       homeTeam: Team.fromJson(json['homeTeam']),
// //       awayTeam: Team.fromJson(json['awayTeam']),
// //     );
// //   }
// //
// //   @override
// //   List<Object?> get props => [tournament, homeTeam, awayTeam];
// // }
//
//
//
//
// // class Team extends Equatable {
// //   final String name;
// //
// //   Team({required this.name});
// //
// //   factory Team.fromJson(Map<String, dynamic> json) {
// //     return Team(name: json['name']);
// //   }
// //
// //   @override
// //   List<Object?> get props => [name];
// // }
//
//
