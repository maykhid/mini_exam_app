import 'package:dartz/dartz.dart';
import 'package:exam_cheat_detector/core/entities/auth_credentials.dart';
import 'package:exam_cheat_detector/core/failure/failure.dart';
import 'package:exam_cheat_detector/core/repositories/firebase_auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthUseCase {
  // Future<bool> isUserAuthenticated();
  Future<Either<Failure, bool>> login(AuthCredentials credentials);
  Future createUser(AuthCredentials credentials);
  Stream<User?>? get onAuthStateChanged;
  Future<User?>? userInfo();
}

class FirebaseAuthUseCaseImpl implements FirebaseAuthUseCase {
  final FirebaseAuthRepo firebaseAuthRepo;

  FirebaseAuthUseCaseImpl({required this.firebaseAuthRepo});

  @override
  Future createUser(AuthCredentials credentials) =>
      firebaseAuthRepo.createUser(credentials);

  // @override
  // Future<bool> isUserAuthenticated() => firebaseAuthRepo.isUserAuthenticated();

  @override
  Future<Either<Failure, bool>> login(AuthCredentials credentials) =>
      firebaseAuthRepo.signIn(credentials);

  @override
  Stream<User?>? get onAuthStateChanged => firebaseAuthRepo.onAuthStateChanged;

  @override
  Future<User?>? userInfo() =>
    firebaseAuthRepo.userInfo();
  
}
