import 'dart:developer';

import 'package:attendance_system/core/presentation/routes/app_route.dart';
import 'package:attendance_system/core/presentation/widgets/exceptionIndicators/exception_indicator.dart';
import 'package:attendance_system/feature/attendant_management/data/data_source/database_service/database_repository_impl.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../presentation/signup/screens/user_details_screen.dart';

class AuthController extends GetxController {


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ExceptionIndicator _exceptionIndicator = ExceptionIndicator();


  late Rx<User?> _firebaseUser;

  @override
  void onInit() {
    _firebaseUser = Rx<User?>(_firebaseAuth.currentUser);
    _firebaseUser.bindStream(_firebaseAuth.authStateChanges());
    super.onInit();
  }


  String? get user => _firebaseUser.value?.email;

  //creating user object based on firebase User

  UserModel? _userModelFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Future signUp({required String email, required String password}) async {
    debugPrint('{email: $email, password: $password}');
    try {

      UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password,);
      User? user = userCredential.user;

      await DatabaseRepositoryImpl(uid: user?.uid).updateUserDetails(
        'First Name', 'Last Name', 'Male', null, null, null,);
      _exceptionIndicator.showSuccess(title: 'Sign up',
          message: 'User Account Created');
      print('==================================');
    //  Get.offAll(UserDetailScreen());
     Get.offAllNamed(AppRoutes.userDetail);
    //  debugPrint('navigating to user detail...');
      return _userModelFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak');
        _exceptionIndicator.showInfo(title: 'Sign Up',
            message: 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        _exceptionIndicator.showError(title: 'Sign Up',
            message: 'Account email already exist');
      }
    } catch (e) {
      debugPrint('error');
      debugPrint(e.toString());
    }
  }

  Future signIn({required email, required password}) async {
    debugPrint('{email: $email, password: $password}');
    try {
     // debugPrint('======================');
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('======================');

      User? user = userCredential.user;
      _exceptionIndicator.showSuccess(title: 'Log In',
          message: 'Account logged in successful');
      Get.offAllNamed<dynamic>(AppRoutes.base);
      return _userModelFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('======================');
        _exceptionIndicator.showError(title: 'Log In',
            message: 'No user found for this email');
        debugPrint('No user found for this email');
      } else if (e.code == 'wrong-password') {
        _exceptionIndicator.showError(title: 'Log In',
            message: 'Incorrect password');
        debugPrint('Incorrect Password');
      }
    }
  }


  Future<String> getCurrentUserEmail() async {
    User? user = _firebaseAuth.currentUser;
    String email = user!.email.toString();
    return email;
  }

  Future<String?> getCurrentUserUid() async {
    User? user = _firebaseAuth.currentUser;
    String? uid = user?.uid;
    return uid;
  }

  void signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      _exceptionIndicator.showError(title: 'Sign Out',
          message: 'An error occurred Signing Out');
      debugPrint(e.toString());
    }
  }
}