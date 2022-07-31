import 'package:attendance_system/core/presentation/widgets/animation_column.dart';
import 'package:attendance_system/core/presentation/widgets/app_dropdown_input.dart';
import 'package:attendance_system/core/presentation/widgets/app_linear_button.dart';
import 'package:attendance_system/core/presentation/widgets/app_text_input.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:attendance_system/feature/authentication/presentation/signup/getx/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailScreen extends GetView<SignUpController> {
  UserDetailScreen({Key? key}) : super(key: key);

  final TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 48),
        child: AppAnimatedColumn(
          children: [
            const Text('Hey Welcome',style: TextStyle(
              fontSize: 18,
            ),),
            const SizedBox(height: 10,),
            const Text('Please tell us more about you.'),
            const SizedBox(height: 20,),
            Form(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FutureBuilder<UserModel?>(
                       future: controller.getUserDetails(),
                        builder: (context, snapshot){
                          if(snapshot.hasError){
                            debugPrint('${snapshot.error}');
                            return const Text('Something went wrong');
                          }else if(snapshot.hasData){
                            final user = snapshot.data;
                            return user == null ?
                            const Center(child: Text('No user found'))
                                :_buildUserDetail(user);
                          }else {
                            return const SizedBox();
                          }
            }),


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetail(UserModel user){
    return Column(
      children: [
        AppTextInput(
          onChanged: (value) =>
              controller.onFirstNameInputChange(value!),
          validator: (value) => controller.validateName(value),
          hintText: user.firstName,
        ),
        const SizedBox(height: 28),
        AppTextInput(
          onChanged: (value) =>
              controller.onLastNameInputChange(value!),
          validator: (value) => controller.validateName(value),
          hintText: user.lastName,
        ),
        const SizedBox(height: 28),
        Obx(() => AppDropdownInput(
            controller: _genderController,
            items: controller.genderL,
            hintText: controller.gender.value,
            onSelected: (value) => controller.onGenderInputChange(value),

          ),
        ),
        const SizedBox(height: 28),
        AppTextInput(
          onChanged: (value) =>
              controller.onUserIdInputChange(value!),
          validator: (value) => controller.validateName(value!),
          hintText: 'Id Number',
         // keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 28),
        AppTextInput(
          onChanged: (value) =>
              controller.onPhoneNumberInputChange(value!),
          validator: (value) => controller.validatePhoneNumber(value!),
          hintText: 'Phone Number',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 28),
        AppLinearButton(text: 'Submit',
            onPressed: () {
              controller.updateUserData(user);
            })
      ],
    );
  }
}
