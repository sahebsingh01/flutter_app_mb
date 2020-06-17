import 'package:flutter/material.dart';
import 'package:muski_bday/utils/constants.dart';

class CustomButton extends StatefulWidget {
  final bool isTitleButton;
  bool isUploadButton;
  final Function onPressAction;
  CustomButton({
    this.isTitleButton,
    @required this.onPressAction,
    this.isUploadButton,
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
        height: widget.isTitleButton
            ? MediaQuery.of(context).size.width * 0.12
            : MediaQuery.of(context).size.width * 0.15,
        width: widget.isTitleButton
            ? MediaQuery.of(context).size.width * 0.36
            : MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((widget.isTitleButton
                    ? MediaQuery.of(context).size.width * 0.12
                    : MediaQuery.of(context).size.width * 0.15) /
                2),
            gradient: LinearGradient(
              colors: [
                ColorConstants.primaryGradientColor.withAlpha(200),
                ColorConstants.secondaryGradientColor.withAlpha(200),
              ],
            )),
        child: Center(
          child: !widget.isTitleButton
              ? Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: (MediaQuery.of(context).size.width * 0.15) / 2,
                )
              : Text(
                  widget.isUploadButton == null || !widget.isUploadButton ? "Go Back" : "Upload",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
