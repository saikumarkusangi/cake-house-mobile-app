// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel?>? productModelFromJson(String str) => json.decode(str) == null ? [] : List<ProductModel?>.from(json.decode(str)!.map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class ProductModel {
    ProductModel({
        this.caterory,
        this.name,
        this.image,
        this.price,
        this.price2,
        this.description,
        this.offer,
        this.banners,
        this.registration_ids
    });

    String? caterory;
    String? name;
    String? image;
    int? price;
    int? price2;
    String? description;
    String? offer;
    String? banners;
    String? registration_ids;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        caterory: json["caterory"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        price2: json["price2"],
        description: json["description"],
        offer:json["offer"],
        banners:json["banners"],
        registration_ids:json['registration_ids']
    );

    Map<String, dynamic> toJson() => {
        "caterory": caterory,
        "name": name,
        "image": image,
        "price": price,
        "price2": price2,
        "description": description,
        "offer":offer,
        "banners":banners,
        "registration_ids":registration_ids
    };
}
