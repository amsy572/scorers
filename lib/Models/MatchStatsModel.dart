import 'package:equatable/equatable.dart';

class MatchStatsModel {
  final bool success;
  final StatisticsData data;

  MatchStatsModel({required this.success, required this.data});

  factory MatchStatsModel.fromJson(Map<String, dynamic> json) {
    return MatchStatsModel(
      success: json['success'],
      data: StatisticsData.fromJson(json['data']),
    );
  }
}

class StatisticsData {
  final List<StatisticGroup> statistics;

  StatisticsData({required this.statistics});

  factory StatisticsData.fromJson(Map<String, dynamic> json) {
    var list = json['statistics'] as List;
    List<StatisticGroup> statisticsList = list.map((i) => StatisticGroup.fromJson(i)).toList();
    return StatisticsData(statistics: statisticsList);
  }
}

class StatisticGroup {
  final String groupName;
  final List<StatisticItem> statisticsItems;

  StatisticGroup({required this.groupName, required this.statisticsItems});

  factory StatisticGroup.fromJson(Map<String, dynamic> json) {
    var list = json['statisticsItems'] as List;
    List<StatisticItem> itemsList = list.map((i) => StatisticItem.fromJson(i)).toList();
    return StatisticGroup(
      groupName: json['groupName'],
      statisticsItems: itemsList,
    );
  }
}

class StatisticItem {
  final String name;
  final String home;
  final String away;
  final int compareCode;
  final String statisticsType;
  final String valueType;
  final double homeValue;
  final double awayValue;
  final int renderType;
  final String key;

  StatisticItem({
    required this.name,
    required this.home,
    required this.away,
    required this.compareCode,
    required this.statisticsType,
    required this.valueType,
    required this.homeValue,
    required this.awayValue,
    required this.renderType,
    required this.key,
  });

  factory StatisticItem.fromJson(Map<String, dynamic> json) {
    return StatisticItem(
      name: json['name'],
      home: json['home'],
      away: json['away'],
      compareCode: json['compareCode'],
      statisticsType: json['statisticsType'],
      valueType: json['valueType'],
      homeValue: (json['homeValue'] as num).toDouble(),
      awayValue: (json['awayValue'] as num).toDouble(),
      renderType: json['renderType'],
      key: json['key'],
    );
  }
}
