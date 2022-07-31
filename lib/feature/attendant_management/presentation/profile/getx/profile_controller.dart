import 'package:attendance_system/feature/attendant_management/data/data_source/database_service/database_repository_impl.dart';
import 'package:attendance_system/feature/authentication/data/data_source/auth_controller.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString gender = ''.obs;
  RxString userId = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString imageUrl = ''.obs;

  AuthController authController = Get.find();
  
  DatabaseRepositoryImpl databaseRepositoryImpl = DatabaseRepositoryImpl(uid: '');
  
  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
  
  Future<UserModel?> getUserDetails() {
    return  databaseRepositoryImpl.getUserDetail();
  }

  Future<String> getCurrentUserEmail() async =>
      await authController.getCurrentUserEmail();



  void signOut() {
    authController.signOut();
  }
}
