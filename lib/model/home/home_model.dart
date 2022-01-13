class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
    List<BannersModel> banners = [];
     List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(element);
    });

    json['products'].forEach((element)
    {
      products.add(element);
    });
  }
}

 class BannersModel
{
  late int id;
  late String image;
  BannersModel.fromJson(Map<String, dynamic>? json)
  {
    id = json!['id'];
    image = json['image'];
  }
}

class ProductModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late  String image;
  late  String name;
  late bool inFavorites;
  late bool inCart;




  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
