// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromMap(jsonString);

import 'dart:convert';

BannerModel bannerModelFromMap(String str) => BannerModel.fromMap(json.decode(str));

String bannerModelToMap(BannerModel data) => json.encode(data.toMap());

class BannerModel {
    int? status;
    String? message;
    List<DataBanner>? data;

    BannerModel({
        this.status,
        this.message,
        this.data,
    });

    factory BannerModel.fromMap(Map<String, dynamic> json) => BannerModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<DataBanner>.from(json["data"]!.map((x) => DataBanner.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class DataBanner {
    String? bannerName;
    String? bannerImage;
    String? description;

    DataBanner({
        this.bannerName,
        this.bannerImage,
        this.description,
    });

    factory DataBanner.fromMap(Map<String, dynamic> json) => DataBanner(
        bannerName: json["banner_name"],
        bannerImage: json["banner_image"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "banner_name": bannerName,
        "banner_image": bannerImage,
        "description": description,
    };
}
