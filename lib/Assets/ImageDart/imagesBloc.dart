import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimony_admin/Storage/databaseRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'imagesBloc.dart';
// import 'imagesBloc.dart';

part 'imagesEvent.dart';
part 'imageState.dart';

// import 'package:matrimony_admin/Assets/ImageDart/imageState.dart';
// import 'package:matrimony_admin/Assets/ImageDart/imagesEvent.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImageState> {
  final DatabaseRepo _databaseRepo;
  StreamSubscription? _databaseSubscriction;
  var imageUrls;
  ImagesBloc({required DatabaseRepo databaseRepo})
      : _databaseRepo = databaseRepo,
        super(ImageLoading());
  //     super(ImageLoading()){
  // on<LoadImages>(_onLoadImages);
  // on<UpdateImages>(_onUpdateImages);
  // }

  // void _onLoadImages(
  //     LoadImages event,
  //     Emitter<ImageState> emit,
  //     ) {
  //   _databaseSubscriction?.cancel();
  //
  //   _databaseRepo(
  //         (user) => add(
  //       UpdateImages(imageUrls),
  //     ),
  //   );
  // }

  // void _onUpdateImages(
  //     UpdateImages event,
  //     Emitter<ImageState> emit,
  //     ) {
  //   emit(
  //     ImageLoaded(imageUrls: event.imageUrls),
  //   );
  // }

  @override
  Stream<ImageState> mapEventToState(ImagesEvent event) async* {
    if (event is LoadImages) {
      yield* _mapLoadImagestoState();
    }
    if (event is UpdateImages) {
      yield* _mapUpdateImagesToState(event);
    }
  }

  Stream<ImageState> _mapLoadImagestoState() async* {
    print("hello");
    _databaseSubscriction?.cancel();

    _databaseRepo.getUser().listen((user) => add(
          UpdateImages(user.imageUrls!),
        ));
    // final prefs = await SharedPreferences.getInstance();

    // FirebaseFirestore.instance
    //           .collection('user_data')
    //           .doc(prefs.getString('uid'))
    //           .get()
    //           .then((DocumentSnapshot doc) {
    //         imageUrls = doc.get('imageurls');

    //           }
    //       );

    //   UpdateImages(imageUrls);
    // });
  }

  Stream<ImageState> _mapUpdateImagesToState(UpdateImages event) async* {
    yield ImageLoaded(imagesUrls: event.imagesUrls);
  }
}

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc(super.initialState);
}
