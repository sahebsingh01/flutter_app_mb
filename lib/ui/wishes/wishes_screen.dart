import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muski_bday/ui/uploadform/model/wish_model.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/firebase_manager.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:shimmer/shimmer.dart';

class WishesScreen extends StatefulWidget {
  @override
  _WishesScreenState createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishes"),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryGradientColor,
      ),
      body: StreamBuilder(
          stream: FirebaseManager.getWishes(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    for (int i = 0; i < snapshot.data.documents.length; i++)
                      Container(
                        height: 20,
                        width: 20,
                        child: _getWishesCell(WishModel.fromJson(
                            snapshot.data.documents[i].data)),
                      )
                  ],
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text(
                    "No wishes found",
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _getWishesCell(WishModel wish) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          NavigationUtils.push(
              context, NavigationConstants.routeUploadInformation,
              arguments: {
                DicParams.wishModel: wish,
              });
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.height * 0.1,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: wish.profilePic,
                  fit: BoxFit.cover,
                  errorWidget: (context, value, error) =>
                      Image.asset(ImageConstants.userDefaultImage),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                wish.name.split(" ")[0],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ColorConstants.primaryGradientColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
}
