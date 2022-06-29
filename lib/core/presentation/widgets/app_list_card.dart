import 'package:flutter/material.dart';
class AppListCard extends StatelessWidget {
   const AppListCard({required this.imageUrl,
     required this.title,
     required this.description,
     Key? key}) : super(key: key);

  final String imageUrl;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
        child: IntrinsicHeight(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage.assetNetwork(
                  image: imageUrl.toString(),
                  placeholder: 'assets/images/image-load-failed.png',
                  // scale: 10,
                  fit: BoxFit.fill,
                  width: 100,
                  height: 60,
                  imageErrorBuilder: (BuildContext context, Object object,
                      StackTrace? stacktrace) =>
                     Image.network('assets/images/image-load-failed.png',
                    scale: 10,
                    fit: BoxFit.fill,
                    width: 100,
                    height: 60,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.left,
                      maxLines: 5,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.fade

                      ),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
