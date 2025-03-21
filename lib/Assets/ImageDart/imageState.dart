part of 'imagesBloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<dynamic> imagesUrls;

  ImageLoaded({this.imagesUrls = const []});

  List<Object> get props => [imagesUrls];
}

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<dynamic> videoUrls;

  VideoLoaded({this.videoUrls = const []});

  List<Object> get props => [videoUrls];
}
