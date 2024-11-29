import 'package:equatable/equatable.dart';

class MomentumModel extends Equatable {
  final bool success;
  final GraphData data; // Added GraphData as a property

  MomentumModel({required this.success, required this.data});

  factory MomentumModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == null || json['data'] == null) {
      throw FormatException("Missing required fields in MomentumModel JSON.");
    }
    return MomentumModel(
      success: json['success'] as bool,
      data: GraphData.fromJson(json['data']), // Parse the 'data' field as GraphData
    );
  }

  @override
  List<Object?> get props => [success, data];
}


class GraphPoint extends Equatable {
  final dynamic minute;
  final dynamic value;

  GraphPoint({required this.minute, required this.value});

  factory GraphPoint.fromJson(Map<String, dynamic> json) {
    return GraphPoint(
      minute: json['minute'],
      value: json['value'],
    );
  }

  @override
  List<Object?> get props => [minute, value];
}

class GraphData extends Equatable {
  final List<GraphPoint> graphPoints;

  GraphData({required this.graphPoints});

  factory GraphData.fromJson(Map<String, dynamic> json) {
    var list = json['graphPoints'] as List;
    List<GraphPoint> graphPointsList = list.map((i) => GraphPoint.fromJson(i)).toList();

    return GraphData(
      graphPoints: graphPointsList,
    );
  }

  @override
  List<Object?> get props => [graphPoints];
}


