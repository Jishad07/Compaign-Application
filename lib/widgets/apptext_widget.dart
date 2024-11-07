import 'package:flutter/widgets.dart';

class AppText extends StatelessWidget {
  String?text;
  double? textsize;
  Color?textcolor;
   AppText({
    this.text,
    this.textsize,
    this.textcolor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("$text", style:  TextStyle(fontSize: textsize));
  }
}