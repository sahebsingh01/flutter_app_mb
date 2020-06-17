import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:muski_bday/utils/preference_utils.dart';
import 'package:muski_bday/widgets/custom_button.dart';

class UploadInformation extends StatefulWidget {
  Uint8List signature;
  UploadInformation({this.signature});
  @override
  _UploadInformationState createState() => _UploadInformationState();
}

class _UploadInformationState extends State<UploadInformation> {
  String _name;
  @override
  void initState() {
    super.initState();
    _name = getString(PreferencesConst.userName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              NavigationUtils.pop(context);
            }),
        title: Text("Details"),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryGradientColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getTitle("Name"),
              _getName(),
              _getTitle("Profile Picture"),
              _getProfilePicture(),
              _getTitle("Picture with Muskan"),
              _getPictureWithMuskan(),
              widget.signature != null ? _getTitle("Signature") : Container(),
              widget.signature != null ? _getSignature() : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(isTitleButton: true,isUploadButton: true,onPressAction: (){}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 8.0,),
    child: Text("$title:",style: TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    ),),
  );

  Widget _getProfilePicture() => Padding(
    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
    child: CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.12,
          backgroundColor: ColorConstants.primaryGradientColor,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.height * 0.4,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      "", //"https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  fit: BoxFit.cover,
                  errorWidget: (context, value, error) =>
                      Image.asset(ImageConstants.userDefaultImage),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
        ),
  );

  Widget _getName() => Padding(
    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.primaryGradientColor,),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _name,
              style: TextStyle(
                color: ColorConstants.primaryGradientColor,
                fontSize: 18.0,

              ),
            ),
          ),
        ),
  );

  Widget _getPictureWithMuskan() => Padding(
        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          color: ColorConstants.primaryGradientColor,
          child: CachedNetworkImage(
            imageUrl: "",
            fit: BoxFit.cover,
            errorWidget: (context, value, error) => Container(
              child: Image.asset(
                ImageConstants.defaultGroupPhoto,
                fit: BoxFit.cover,
              ),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
          ),
        ),
      );

  Widget _getSignature() => Padding(
    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
    child: Container(
          height: MediaQuery.of(context).size.width * 0.25,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Image.memory(
            widget.signature,
          ),
        ),
  );
}
