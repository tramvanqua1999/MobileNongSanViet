import 'dart:convert';

// import 'package:flutter_session/flutter_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/profileShop.dart';

import '../constants.dart';
import 'Customer.dart';

Future<List<Product>> downloadJSONProduct() async {
  final jsonEndpoint = url + "product";

  final response = await http.get(jsonEndpoint);
  // print(json.decode(response.body));
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    return products.map((product) => new Product.fromJson(product)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Shop>> downloadJSONListFollow() async {
  final jsonEndpoint = url + "shopfollow";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final username = prefs?.getString("username");

  final response = await http.post(jsonEndpoint, body: {
    "username": json.encode(username),
  });

  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    return products.map((product) => new Shop.fromJson(product)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Product>> downloadJSONListProductFollow() async {
  final jsonEndpoint = url + "productfavorite";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final username = prefs?.getString("username");

  final response = await http.post(jsonEndpoint, body: {
    "username": json.encode(username),
  });

  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    return products.map((product) => new Product.fromJson(product)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Product>> downloadJSONHighestDiscount() async {
  final jsonEndpoint = url + "highestdiscount";

  final response = await http.get(jsonEndpoint);
  print(response.body);
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    return products.map((product) => new Product.fromJson(product)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Product>> downloadJSONHasdiscount() async {
  final jsonEndpoint = url + "hasdiscount";

  final response = await http.get(jsonEndpoint);
  print(response.body);
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    return products.map((product) => new Product.fromJson(product)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Product>> downloadJSONLimited() async {
  final jsonEndpoint = url + "limited";

  final response = await http.get(jsonEndpoint);
  print(response.body);
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    return products.map((product) => new Product.fromJson(product)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Product>> downloadProductShopSale(int shopCode) async {
  final jsonEndpoint = url + "ProductShopSale";
  var shopcode = json.encode(shopCode);

  final response = await http.post(jsonEndpoint, body: {
    "shopCode": shopcode,
  });
  // print(json.decode(response.body));
  if (response.statusCode == 200) {
    List productsale = json.decode(response.body);
    return productsale.map((sale) => new Product.fromJson(sale)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Product>> downloadProductShop(int shopCode) async {
  final jsonEndpoint = url + "ProductShop";
  var shopcode = json.encode(shopCode);

  final response = await http.post(jsonEndpoint, body: {
    "shopCode": shopcode,
  });
  if (response.statusCode == 200) {
    List productsale = json.decode(response.body);
    return productsale.map((sale) => new Product.fromJson(sale)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<int> downloadCountFollow(int shopcode) async {
  final jsonEndpoint = url + "countFollow";
  var id = json.encode(shopcode);
  final response = await http.post(jsonEndpoint, body: {
    "shopCode": id,
  });
  if (response.statusCode == 200) {
    int countFollow = json.decode(response.body);
    return countFollow;
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<Shop> downloadJSONShop(int shopCode) async {
  final jsonEndpoint = url + "shop";
  var shopcode = json.encode(shopCode);

  final response = await http.post(jsonEndpoint, body: {
    "shopCode": shopcode,
  });
  // print(json.decode(response.body)[0]);
  if (response.statusCode == 200) {
    var shop = json.decode(response.body)[0];
    return Shop.fromJson(shop);
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<Customer> downloadJSONGetProfile() async {
  final jsonEndpoint = url + "getprofile";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final username = prefs?.getString("username");

  final response = await http.post(jsonEndpoint, body: {
    "username": json.encode(username),
  });
  // print(json.decode(response.body)[0]);
  if (response.statusCode == 200) {
    var shop = json.decode(response.body)[0];
    return Customer.fromJson(shop);
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<bool> downloadFavorite(int productCode) async {
  final jsonEndpoint = url + "favorite";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final username = prefs?.getString("username");
  var id = json.encode(productCode);
  final response = await http.post(jsonEndpoint, body: {
    "productCode": id,
    "username": username,
  });
  print(response.body);
  if (response.body == "true") {
    return true;
  } else {
    return false;
  }
}

Future<bool> downloadFollow(int shopCode) async {
  final jsonEndpoint = url + "follow";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final username = prefs?.getString("username");
  var id = json.encode(shopCode);
  final response = await http.post(jsonEndpoint, body: {
    "shopCode": id,
    "username": username,
  });
  print(response.body);
  if (response.body == "true") {
    return true;
  } else {
    return false;
  }
}

Future<void> downloadCheckFollow(int shopCode) async {
  final jsonEndpoint = url + "checkFollow";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final username = prefs?.getString("username");
  var id = json.encode(shopCode);
  await http.post(jsonEndpoint, body: {
    "shopCode": id,
    "username": username,
  });
}

Future<void> downloadCheckFavorite(int productCode, bool check) async {
  final jsonEndpoint = url + "checkFavorite";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final username = prefs?.getString("username");
  var id = json.encode(productCode);
  await http.post(jsonEndpoint, body: {
    "check": json.encode(check),
    "productCode": id,
    "username": username,
  });
}

Future<bool> downloadcheckdiscount(int productCode) async {
  final jsonEndpoint = url + "checkdiscount";
  var id = json.encode(productCode);
  final response = await http.post(jsonEndpoint);
  if (response.body == "true") {
    return true;
  } else {
    return false;
  }
}

// Future<List<ServiceModel>> downloadJSONMyService(
//     List<int> typeArr, double range, String lat, String long) async {
//   final jsonEndpoint = url + "getservice";

//   var rangepost = json.encode(range);
//   var type = json.encode(typeArr);

//   print(rangepost);
//   print(type);
//   print(lat);
//   print(long);
//   final response = await http.post(jsonEndpoint, body: {
//     "long": long,
//     "lat": lat,
//     "type": type,
//     "range": rangepost,
//   });
//   print(long);
//   print(lat);
//   print(response.body);
//   if (response.statusCode == 200) {
//     List services = json.decode(response.body);
//     return services
//         .map((service) => new ServiceModel.fromJson(service))
//         .toList();
//   } else
//     throw Exception('We were not able to successfully download the json data.');
// }

// Future<List<PostModel>> downloadJSONPost(int username) async {
//   final jsonEndpoint = url + "getpost";

//   var usernameId = json.encode(username);

//   final response = await http.post(jsonEndpoint, body: {
//     "username": usernameId,
//   });
//   print(response.body);
//   if (response.statusCode == 200) {
//     List postModels = json.decode(response.body);
//     return postModels
//         .map((postModel) => new PostModel.fromJson(postModel))
//         .toList();
//   } else
//     throw Exception('We were not able to successfully download the json data.');
// }

// Future<ServiceModel> downloadJsonUserService() async {
//   final jsonEndpoint = url + "serviceretrive";
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   var user = prefs?.getString("username");

//   final response = await http.post(jsonEndpoint, body: {
//     "username": user,
//   });
//   if (response.statusCode == 200) {
//     return ServiceModel.fromJson(json.decode(response.body)[0]);
//   } else
//     throw Exception('We were not able to successfully download the json data.');
// }

// Future<UserModel> downloadJsonUser() async {
//   final jsonEndpoint = url + "retrieve";
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   var user = prefs?.getString("username");

//   final response = await http.post(jsonEndpoint, headers: {
//     "Connection": "keep-alive"
//   }, body: {
//     "username": user,
//   });
//   if (response.statusCode == 200) {
//     return UserModel.fromJson(json.decode(response.body)[0]);
//   } else
//     throw Exception('We were not able to successfully download the json data.');
// }

// Future<ServiceModelLogin> downloadJsonService() async {
//   final jsonEndpoint = url + "retrieve";
//   var session = FlutterSession();

//   var user = await session.get("username");

//   final response = await http.post(jsonEndpoint, body: {
//     "username": user,
//   });

//   if (response.statusCode == 200) {
//     return ServiceModelLogin.fromJson(json.decode(response.body));
//   } else
//     throw Exception('We were not able to successfully download the json data.');
// }
