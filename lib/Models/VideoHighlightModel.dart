import 'package:equatable/equatable.dart';

class VideoHLModel extends Equatable {
  final bool success;
  final HighlightsData data;

  VideoHLModel({required this.success,
    required this.data
  });

  factory VideoHLModel.fromJson(Map<String, dynamic> json) {
    if (json['success'] == null || json['data'] == null) {
      throw FormatException("Missing required fields in MatchModel JSON.");
    }
    return VideoHLModel(
      success: json['success'] as bool,
      data: HighlightsData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [success,];
}


class HighlightsData {
  final List<Highlight> highlights;

  HighlightsData({
    required this.highlights,
  });

  factory HighlightsData.fromJson(Map<String, dynamic> json) {
    return HighlightsData(
      highlights: (json['highlights'] as List)
          .map((highlight) => Highlight.fromJson(highlight))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'highlights': highlights.map((highlight) => highlight.toJson()).toList(),
    };
  }
}

// Individual highlight model
class Highlight {
  final String title;
  final String subtitle;
  final String url;
  final String thumbnailUrl;
  final int mediaType;
  final bool doFollow;
  final bool keyHighlight;
  final int id;
  final int createdAtTimestamp;
  final String sourceUrl;

  Highlight({
    required this.title,
    required this.subtitle,
    required this.url,
    required this.thumbnailUrl,
    required this.mediaType,
    required this.doFollow,
    required this.keyHighlight,
    required this.id,
    required this.createdAtTimestamp,
    required this.sourceUrl,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) {
    return Highlight(
      title: json['title'],
      subtitle: json['subtitle'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
      mediaType: json['mediaType'],
      doFollow: json['doFollow'],
      keyHighlight: json['keyHighlight'],
      id: json['id'],
      createdAtTimestamp: json['createdAtTimestamp'],
      sourceUrl: json['sourceUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'mediaType': mediaType,
      'doFollow': doFollow,
      'keyHighlight': keyHighlight,
      'id': id,
      'createdAtTimestamp': createdAtTimestamp,
      'sourceUrl': sourceUrl,
    };
  }
}
