// ignore_for_file: library_private_types_in_public_api

import 'package:easy_stepper/easy_stepper.dart';

class CheckoutLayoutMobile extends StatefulWidget {
  const CheckoutLayoutMobile({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutLayoutMobileState createState() => _CheckoutLayoutMobileState();
}

class _CheckoutLayoutMobileState extends State<CheckoutLayoutMobile> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: EasyStepper(
            activeStep: activeStep,
            steps: const [
              EasyStep(
                icon: Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.white,
                ),
                title: 'Cart',
              ),
              EasyStep(
                icon: Icon(
                  Icons.dashboard_customize,
                  color: Colors.white,
                ),
                title: 'Checkout',
              ),
              EasyStep(
                icon: Icon(
                  Icons.money_rounded,
                  color: Colors.white,
                ),
                title: 'Payment',
              ),
              EasyStep(
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                title: 'Finish',
              ),
            ],
            onStepReached: (index) => setState(() => activeStep = index),
          ),
        ),
      ),
    );
  }
}
