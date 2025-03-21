import '../models/user_model.dart';

abstract class BaseDatabaseRepo{
   Stream<User> getUser();
   Future<void> updateUserPicture(String imageName);
}