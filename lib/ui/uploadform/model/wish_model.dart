class WishModel {
  String name;
  String message;
  String profilePic;
  String pictureUrl;
  String signatureUrl;

  WishModel({this.name, this.message, this.profilePic, this.pictureUrl,this.signatureUrl,});

  WishModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    profilePic = json['profilePic'];
    pictureUrl = json['pictureUrl'];
    signatureUrl = json['signatureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    data['profilePic'] = this.profilePic;
    data['pictureUrl'] = this.pictureUrl;
    data['signatureUrl'] = this.signatureUrl;
    return data;
  }
}