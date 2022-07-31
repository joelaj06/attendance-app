import 'package:attendance_system/core/presentation/themes/app_theme.dart';
import 'package:attendance_system/core/presentation/widgets/animation_column.dart';
import 'package:attendance_system/core/presentation/widgets/app_loading_box.dart';
import 'package:attendance_system/core/presentation/widgets/app_text_field.dart';
import 'package:attendance_system/core/presentation/widgets/exceptionIndicators/no_content_found.dart';
import 'package:attendance_system/feature/attendant_management/presentation/profile/getx/profile_controller.dart';
import 'package:attendance_system/feature/authentication/data/model/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
          child: AppAnimatedColumn(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  PopupMenuButton(
                      onSelected: (String value){
                        debugPrint('sign out');
                      },
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                         PopupMenuItem(
                          child: TextButton(
                            onPressed: () {
                              controller.signOut();
                            },
                            child: const Text('Sign Out',
                            style: TextStyle(
                              fontSize: 22,
                            ),),
                          ),
                        ),
                      ]),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: primaryColorSA,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              FutureBuilder(
                future: controller.getUserDetails(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    debugPrint(snapshot.error.toString());
                    debugPrint(snapshot.error.toString());
                    return const Text(
                        'An Error Occurred, Kindly Restart The Application');
                  } else if (snapshot.hasData) {
                    final user = snapshot.data;
                    return user == null
                        ? const NoContentFound()
                        : _buildUserDetails(context, user);
                  } else {
                    return const AppLoadingBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context, UserModel user) {
    return AppAnimatedColumn(
      children: <Widget>[
        AppTextField(
          text: user.firstName ?? 'No Name Found',
          icon: Icons.drive_file_rename_outline,
        ),
        AppTextField(
          text: user.lastName ?? 'No Name Found',
          icon: Icons.drive_file_rename_outline,
        ),
        _buildCurrentUserEmail(context),
        AppTextField(
          text: user.gender ?? 'No Gender Found',
          icon: FontAwesomeIcons.marsAndVenus,
        ),
        AppTextField(
          text: user.phoneNumber ?? 'No Phone Number Found',
          icon: Icons.phone,
        ),
        AppTextField(
          text: user.userId ?? 'No Id Found',
          icon: Icons.badge,
        )
      ],
    );
  }

  Widget _buildCurrentUserEmail(BuildContext context){
    return FutureBuilder(
      future: controller.getCurrentUserEmail(),
        builder: (context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        final String? email = snapshot.data;
        return email != null ? AppTextField(text: email, icon: Icons.email)
        : AppTextField(text: 'No Email Found', icon: Icons.email);
      }else if(snapshot.hasError){
        debugPrint(snapshot.error.toString());
        return const Text('An Error Has Occurred Kindly Restart the Application');
      }else{
        return const SizedBox.shrink();
      }
    });

  }
}
