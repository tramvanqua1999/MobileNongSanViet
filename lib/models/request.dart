import 'dart:convert';

// import 'package:flutter_session/flutter_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/Popular_product.dart';
import '../constants.dart';

Future<List<Product>> downloadJSONProduct() async {
  final jsonEndpoint = url + "product";

  final response = await http.get(jsonEndpoint);
  print(json.decode(response.body));
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    return products.map((product) => new Product.fromJson(product)).toList();
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
