import 'package:attendance_system/core/presentation/routes/app_route.dart';
import 'package:attendance_system/feature/attendant_management/data/data_source/database_service/database_repository_impl.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/user_details_screen.dart';

class SignUpController extends GetxController {
  // Reactive variables
  RxBool isObscure = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString gender = 'Male'.obs;
  RxString phoneNumber = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString imgUrl = ''.obs;
  RxString userId = ''.obs;
  RxBool onChangeGender = false.obs;
  RxBool isValidForm = false.obs;


  // auth controller
  final AuthController _authController = AuthController();

  // database repository
  final DatabaseRepositoryImpl _databaseRepositoryImpl =
      DatabaseRepositoryImpl(uid: '');

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  final formKey = GlobalKey<FormState>();

  List<String> genderL = ['Male', 'Female'];


  void navigateToUserDetail(){
    Get.toNamed<dynamic>(AppRoutes.userDetail);
  }

  void signUp() async {
    bool isValid = formKey.currentState!.validate();
    if (isValid) {
      _authController.signUp(
        email: email.value.trim(),
        password: password.value.trim(),
      );
    //  Get.offAll(UserDetailScreen());
   // Get.offAllNamed(AppRoutes.userDetail);

    debugPrint('routing to user detail');
    }
  }

  Future<UserModel?> getUserDetails() async {
    return await _databaseRepositoryImpl.getUserDetail();
  }



  void updateUserData(UserModel user) async {

  //  bool isValid = formKey.currentState!.validate();
    //bool isValid = checkFormValidation;
      final uid = await _authController.getCurrentUserUid();
      debugPrint(uid);
      DatabaseRepositoryImpl(uid: uid).updateUserDetails(
        firstName.value == '' ? user.firstName : firstName.value,
        lastName.value == '' ? user.lastName : lastName.value,
        gender.value == '' ? user.gender : gender.value,
        phoneNumber.value == '' ? user.phoneNumber : phoneNumber.value,
        imgUrl.value == '' ? user.imgUrl : imgUrl.value,
        userId.value == '' ? user.userId : userId.value,
      );
      debugPrint(firstName.value);
      debugPrint(lastName.value);
      debugPrint(gender.value);
      debugPrint(phoneNumber.value);
      debugPrint(userId.value);
      Get.offAllNamed(AppRoutes.base);

  }

  void onFirstNameInputChange(String value) {
    firstName(value);
  }

  void onLastNameInputChange(String value) {
    lastName(value);
  }

  void onPhoneNumberInputChange(String value) {
    phoneNumber(value);
  }

  void onUserIdInputChange(String value) {
    userId(value);
    debugPrint(userId.value);
  }

  void onEmailInputChange(String value) {
    email(value);
  }

  void onPasswordInputChange(String value) {
    password(value);
  }

  void onGenderInputChange(String value) {
    gender(value);
    debugPrint(gender.value);
  }

  String? validateName(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      return errorMessage = 'Field is required';
    } else if (!nameRegExp.hasMatch(value)) {
      return errorMessage = 'Please enter correct name';
    } else {
      return errorMessage;
    }
  }



  String? validateEmail(String? value) {
    String? errorMessage;
    if (value!.isEmpty || !value.contains('@')) {
      return errorMessage = 'Please enter a correct email';
    } else {
      return errorMessage;
    }
  }

  String? passwordValidator(String value) {
    String? errorMessage;
    if (value.isEmpty || value.length < 6) {
      return errorMessage = 'Password must be at least 6 characters long.';
    }
    return errorMessage;
  }

  String? validatePhoneNumber(String value) {
    String? errorMessage;
    if (value.isEmpty) {
      return errorMessage = 'Field required';
    } else if (value.length < 10 || value.length > 10) {
      return errorMessage = 'Phone Number must be up to 10 digits';
    } else {
      return errorMessage;
    }
  }

  bool get checkFormValidation => validateName(firstName.value) == null &&
  validateName(lastName.value) == null && validateEmail(email.value) == null &&
  validatePhoneNumber(phoneNumber.value) ==null && validateName(userId.value) == null;
}

