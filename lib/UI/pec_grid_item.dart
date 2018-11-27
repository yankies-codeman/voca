import 'package:flutter/material.dart';
import '../models/pec_word_image.dart';

class PecGridItem extends StatelessWidget {
  Function callback;
  PecWordImage wordImage;

  PecGridItem(this.wordImage, this.callback);

  returnPecValues() {
    callback(wordImage);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Image.asset(wordImage.image, width: 40.0, height: 40.0),
        onTap: returnPecValues,
      ),
    );
  }
}
