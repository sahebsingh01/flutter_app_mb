import 'package:flutter/material.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:muski_bday/utils/preference_utils.dart';
import 'package:muski_bday/utils/validation_utils.dart';
import 'package:muski_bday/widgets/custom_button.dart';

class NameInfo extends StatefulWidget {
  @override
  _NameInfoState createState() => _NameInfoState();
}

class _NameInfoState extends State<NameInfo> {
  final GlobalKey<FormState> _key = GlobalKey();
  var _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.primaryGradientColor,
                        ColorConstants.secondaryGradientColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 25.0,
                    right: 16.0,
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello There.",
                      style: TextStyle(
                        fontSize: 55.0,
                        color: Colors.white.withAlpha(200),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Please enter your name that muskan is most familiar with to proceed:",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 40.0,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Please enter your name that muskan is most familiar with to proceed:",
                            //   style: TextStyle(
                            //     color: Colors.deepPurple,
                            //     fontSize: 16.0,
                            //   ),
                            // ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Form(
                                key: _key,
                                child: TextFormField(
                                  cursorColor:
                                      ColorConstants.primaryGradientColor,
                                  style: TextStyle(
                                      color:
                                          ColorConstants.primaryGradientColor,
                                      fontSize:
                                          (MediaQuery.of(context).size.height *
                                                  0.065) /
                                              3),
                                  validator: (value) {
                                    return isValidName(context, value);
                                  },
                                  onFieldSubmitted: (value) {
                                    if (_key.currentState.validate()) {
                                      setString(PreferencesConst.userName,
                                          _nameController.text);
                                    }
                                  },
                                  textInputAction: TextInputAction.done,
                                  maxLength: 25,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 16.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            ColorConstants.primaryGradientColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            ColorConstants.primaryGradientColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: CustomButton(onPressAction: () {
                                NavigationUtils.push(context,
                                    NavigationConstants.routeUploadProfileInfo);
                              }),
                            ),
                          ],
                        ),
                      ),
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
