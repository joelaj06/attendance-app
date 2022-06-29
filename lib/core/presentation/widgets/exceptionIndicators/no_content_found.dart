import 'package:flutter/material.dart';
class NoContentFound extends StatelessWidget {
  const NoContentFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty-folder.png',
          scale: 5,),
          const Text('No Data Found'),
        ],
      ),);
  }
}
