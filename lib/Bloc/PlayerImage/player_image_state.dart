part of 'player_image_bloc.dart';


abstract class PlayerImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayerImageInitial extends PlayerImageState {}

class PlayerImageLoading extends PlayerImageState {}

class PlayerImageLoaded extends PlayerImageState {
  final PlayerImageModel playerImage;

  PlayerImageLoaded(this.playerImage);

  @override
  List<Object?> get props => [playerImage];
}

class PlayerImageError extends PlayerImageState {
  final String message;

  PlayerImageError(this.message);

  @override
  List<Object?> get props => [message];
}
