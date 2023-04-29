import 'package:fake_store/model/rating_model.dart';

class ProductModel{

  String? title;
  double? price;
   String? description;
  String? image;
  RatingModel? ratingModel;

  ProductModel({this.title,this.price,this.description,this.image,this.ratingModel});
  
  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      image: json['image'],
      ratingModel: RatingModel.fromJson(json['rating']),
    );
  }

}