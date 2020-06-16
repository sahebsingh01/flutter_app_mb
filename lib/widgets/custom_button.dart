import 'package:flutter/material.dart';
import 'package:muski_bday/utils/constants.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Function onPressAction;
  CustomButton({
    this.title,
    @required this.onPressAction,
  });
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressAction();
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.15,
        width: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                (MediaQuery.of(context).size.width * 0.15) / 2),
            gradient: LinearGradient(
              colors: [
                ColorConstants.primaryGradientColor.withAlpha(200),
                ColorConstants.secondaryGradientColor.withAlpha(200),
              ],
            )),
        child: Center(
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: (MediaQuery.of(context).size.width * 0.15) / 2,
          ),
        ),
      ),
    );
  }
}
