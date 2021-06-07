import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:stripe_payment/stripe_payment.dart';

import '../../../constants.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51IqZMuKjUU3cWHwKUQocf1aYBr9tZrEyY7fNAUWyoeFirotxGXYMNg3VN1HTtADlARo9ti64UItbFmqo9eTONWLV00Po3tRqAK';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IqZMuKjUU3cWHwKXkhEFOYS8kuCOLeBp7vEvxT9cukURsRPIMZIqY6rqYdrvUdbuUNp8tHQ30WDm3gpm1TkMX6900SgNOb8FZ",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payViaExistingCard(
      {String amount, String currency, CreditCard card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        _order();
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        _order();
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }

  static Future<void> _order() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs?.getString("username");

    var arrproductcode = new List();
    var arramount = new List();
    var price = new List();
    var priceship = new List();
    var type = 1;

    for (var s in demoCarts) {
      arrproductcode.add(s.product.id);
      arramount.add(s.numOfItem);
      priceship.add(s.priceship);
      print(s.priceship);
      if (s.product.lastday.difference(DateTime.now()).inDays < 1) {
        price.add(double.parse(s.product.price.replaceAll(' ₫', '')));
        // print(double.parse(s.product.price.replaceAll(' ₫', '')));
      } else {
        price.add(double.parse(s.product.priceDiscount.replaceAll(' ₫', '')));
        // print(double.parse(s.product.priceDiscount.replaceAll(' ₫', '')));
      }
    }
    try {
      final response = await http.post(url + "ordercard", body: {
        "username": username,
        "arrproductcode": json.encode(arrproductcode),
        "arramount": json.encode(arramount),
        "price": json.encode(price),
        "priceship": json.encode(priceship),
        "type": json.encode(type),
      });
      demoCarts.clear();
    } catch (e) {}
  }
}
