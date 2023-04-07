class RatingModel{

  double? rate;

  RatingModel({this.rate});

  factory RatingModel.fromJson(Map<String,dynamic> json){
    return RatingModel(
      rate: json['rate'].toDouble()
    );
  }

}