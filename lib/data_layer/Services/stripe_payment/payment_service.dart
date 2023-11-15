import 'package:dio/dio.dart';
import 'package:e_commerce_app/data_layer/Services/stripe_payment/stripe_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

///we will use singleton design pattern in this service
abstract class PaymentService {
  static Future<void> makePayment(int amount, String currency) async {
    final instance = Stripe.instance;
    String clientSecret =
        await _getClientSecret((amount * 100).toString(), currency);
    await _initPaymentSheet(clientSecret);
    await instance.presentPaymentSheet();
  }

  ///this method aim to get clientSecret which will be used to make paymentIntent
  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      //TODO: search more for options
      options: Options(headers: {
        'Authorization': 'Bearer ${StripeApis.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      }),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );

    return response.data['client_secret'];
  }

  ///First step in payment process: this method will send post request to Stripe to get payment intent
  ///payment intent is payment request but you should get clientSecret first
  static Future<void> _initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Company name '));
  }
}
