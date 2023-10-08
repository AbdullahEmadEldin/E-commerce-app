import 'package:dio/dio.dart';
import 'package:e_commerce_app/data_layer/Services/stripe_payment/stripe_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

///we will singleton design pattern in this service
abstract class PaymentService {
  static Future<void> makePayment(int amount, String currency) async {
    String clientSecret =
        await _getClientSecret((amount * 100).toString(), currency);
    await _initPaymentSheet(clientSecret);
    // await Stripe.instance.presentPaymentSheet();
    await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: const PaymentMethodParams.card(
            paymentMethodData:
                PaymentMethodData(billingDetails: BillingDetails())));
  }

  ///First step in payment process: this method will send post request to Stripe to get payment intent
  ///payment intent is payment request
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

  static Future<void> _initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Company name '));
  }
}
