part of 'imagesBloc.dart';
// import 'package:equatable/equatable.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class LoadImages extends ImagesEvent {}

class UpdateImages extends ImagesEvent {
  final List<dynamic> imagesUrls;

  UpdateImages(this.imagesUrls);

  @override
  List<Object> get props => [imagesUrls];
}

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideo extends VideoEvent {}

class UpdateVideo extends ImagesEvent {
  final List<dynamic> videoUrls;

  UpdateVideo(this.videoUrls);

  @override
  List<Object> get props => [videoUrls];
}
