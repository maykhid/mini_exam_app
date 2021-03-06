import 'package:dartz/dartz.dart';
import 'package:exam_cheat_detector/core/entities/auth_credentials.dart';
import 'package:exam_cheat_detector/core/errors/server_error.dart';
import 'package:exam_cheat_detector/core/failure/failure.dart';
import 'package:exam_cheat_detector/core/services/auth/firebase_auth_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepo {
  // Future<bool> isUserAuthenticated();
  Stream<User?>? get onAuthStateChanged;
  Future<Either<Failure, bool>> createUser(AuthCredentials credentials);
  Future<Either<Failure, bool>> signIn(AuthCredentials credentials);
  Future<User?>? userInfo();
}

class FirebaseAuthRepoImpl implements FirebaseAuthRepo {
  final FirebaseAuthSource firebaseAuthSource;
  FirebaseAuthRepoImpl({required this.firebaseAuthSource});

  @override
  Future<Either<Failure, bool>> createUser(AuthCredentials credentials) async {
    try {
      var result = await firebaseAuthSource.createUser(credentials);

      // var userData = UserData(
      //   userId: result.user!.uid,
      //   email: result.user!.email,
      //   fullname: credentials.fullname,
      // ); // This userData is to be uploaded to firestore when new user is created

      return Right(true);
    } on ServerError catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  // @override
  // Future<bool> isUserAuthenticated() async =>
  //     await firebaseAuthSource.isUserAuthenticated();

  @override
  Future<Either<Failure, bool>> signIn(AuthCredentials credentials) async {
    try {
      await firebaseAuthSource.signIn(credentials);
      return Right(true);
    } on ServerError catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  Stream<User?>? get onAuthStateChanged =>
      firebaseAuthSource.onAuthStateChanged;

  @override
  Future<User?>? userInfo() => firebaseAuthSource.userInfo();
}
