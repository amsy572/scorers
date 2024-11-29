part of 'video_hl_bloc.dart';

abstract class VideoHlState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class VideoHlInitial extends VideoHlState {}

final class VideoHlLoading extends VideoHlState {}

final class VideoHlLoaded extends VideoHlState {
  final VideoHLModel videoHL;

  VideoHlLoaded(this.videoHL);

  @override
  // TODO: implement props
  List<Object?> get props => [videoHL];
}

final class VideoHlError extends VideoHlState {
  final String message;
  VideoHlError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

