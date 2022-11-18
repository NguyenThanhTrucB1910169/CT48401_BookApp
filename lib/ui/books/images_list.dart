import 'package:flutter/material.dart';
import '../shared/screens.dart';

class ImagesList extends StatelessWidget {
  ImagesList();

  @override
  Widget build(BuildContext context) {
    final List<String> liste = [
      "assets/image/mot-thoang-ta-ruc-ro-o-nhan-gian.jpg",
      "assets/image/cay-cam-ngọt-của-toi.jpg",
      "assets/image/mai-mai-la-bao-xa.jpg",
      "assets/image/thientai.jpg",
    ];

    return ConstrainedBox(
        constraints: new BoxConstraints(minHeight: 150.0, maxHeight: 190.0),
        child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) => Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset(
                      liste[index],
                      width: 370,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))));
  }
}
