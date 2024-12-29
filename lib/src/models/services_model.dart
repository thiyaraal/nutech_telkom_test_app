// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromMap(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromMap(String str) => ServiceModel.fromMap(json.decode(str));

String serviceModelToMap(ServiceModel data) => json.encode(data.toMap());

class ServiceModel {
    int? status;
    String? message;
    List<DataService>? data;

    ServiceModel({
        this.status,
        this.message,
        this.data,
    });

    factory ServiceModel.fromMap(Map<String, dynamic> json) => ServiceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<DataService>.from(json["data"]!.map((x) => DataService.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class DataService {
    String? serviceCode;
    String? serviceName;
    String? serviceIcon;
    int? serviceTariff;

    DataService({
        this.serviceCode,
        this.serviceName,
        this.serviceIcon,
        this.serviceTariff,
    });

    factory DataService.fromMap(Map<String, dynamic> json) => DataService(
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceTariff: json["service_tariff"],
    );

    Map<String, dynamic> toMap() => {
        "service_code": serviceCode,
        "service_name": serviceName,
        "service_icon": serviceIcon,
        "service_tariff": serviceTariff,
    };
}
