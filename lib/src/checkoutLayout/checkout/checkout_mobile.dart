// ignore_for_file: library_private_types_in_public_api

import 'package:easy_stepper/src/colors.dart';
import 'package:easy_stepper/src/components/shared_widgets.dart';
import 'package:easy_stepper/src/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

class CheckoutMobile extends StatefulWidget {
  const CheckoutMobile({Key? key}) : super(key: key);

  @override
  _CheckoutMobileState createState() => _CheckoutMobileState();
}

class _CheckoutMobileState extends State<CheckoutMobile> {
  int activeStep = 1;
  bool isShippingAvailable = false;
  bool payWithWallet = false;
  double cartTotal = 0.0;
  double oldWalletBalance = 150.0;
  double currentWalletBalance = 150.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            ScreenUtil().screenWidth > 800 ? hLargePadding : hMediumPadding,
        vertical: vMediumPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: vLargePadding),
          const MainHeadline(title: 'Address information'),
          SizedBox(height: vMediumPadding),
          const MyDottedLine(color: iconGreyColor),
          SizedBox(height: vMediumPadding),
          const SmallHeadline(title: 'Addresses'),
          SizedBox(height: vMediumPadding),
          const AddressMiniView(),
          SizedBox(height: vMediumPadding),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Edit'),
            ),
          ),
          SizedBox(height: vMediumPadding),
          const MyDottedLine(color: iconGreyColor),
          SizedBox(height: vMediumPadding),
          const SmallHeadline(title: 'Shipping Address'),
          SizedBox(height: vMediumPadding),
          const AddressMiniView(shippingFee: '10'),
          SizedBox(height: vMediumPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping Policy',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
              ),
              const Spacer(),
              const OutlinedButton(
                onPressed: null,
                child: Text(
                  'Edit',
                ),
              ),
            ],
          ),
          SizedBox(height: vMediumPadding),
          const MyDottedLine(color: iconGreyColor),
          SizedBox(height: vMediumPadding),
          buildTotalPriceView(
            context,
          ),
          SizedBox(height: vLargePadding),
          buildPlaceOrderButton(),
          SizedBox(height: vVeryLargeMargin),
        ],
      ),
    );
  }

  Widget buildTotalPriceView(
    BuildContext context,
  ) {
    const subtotal = 100;
    const shipping = 10;
    const tax = 14;
    const discount = 10;
    const total = 114;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmallHeadline(title: 'Cart Total'),
        SizedBox(height: vMediumPadding),
        buildCartInfoRow(
          context,
          title: 'Subtotal',
          value: CartPriceRichText(
            price: intl.NumberFormat.decimalPattern().format(subtotal),
            currency: '\$',
            priceSize: 20.sp,
            currencySize: 14.sp,
          ),
          size: 20.w,
        ),
        const MyDottedLine(color: iconGreyColor),
        SizedBox(height: vMediumPadding),
        if (isShippingAvailable) ...[
          buildCartInfoRow(
            context,
            title: 'Shipping',
            value: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CartPriceRichText(
                    price: intl.NumberFormat.decimalPattern().format(shipping),
                    currency: '\$',
                  ),
                  SizedBox(height: vVerySmallPadding),
                  Text(
                    'Shipping to USA',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    softWrap: true,
                  ),
                  SizedBox(height: vSmallPadding),
                ],
              ),
            ),
          ),
          const MyDottedLine(color: iconGreyColor),
          SizedBox(height: vMediumPadding),
        ],
        buildCartInfoRow(
          context,
          title: 'VAT',
          subtitle: ' (Estimated for USA)',
          value: CartPriceRichText(
            price: intl.NumberFormat.decimalPattern().format(tax),
            currency: '\$',
          ),
        ),
        const MyDottedLine(color: iconGreyColor),
        SizedBox(height: vMediumPadding),
        buildCartInfoRow(
          context,
          title: 'Coupon',
          subtitle: 'Free Shipping',
          value: CartPriceRichText(
            price: '- ${intl.NumberFormat.decimalPattern().format(discount)}',
            currency: '\$',
          ),
        ),
        const MyDottedLine(color: iconGreyColor),
        SizedBox(height: vVeryLargePadding),
        buildCartInfoRow(
          context,
          size: 24.sp,
          bold: true,
          title: 'Total',
          value: CartPriceRichText(
            price: intl.NumberFormat.decimalPattern().format(total),
            currency: '\$',
            priceSize: 22.sp,
            // lineThrough: payWithWallet,
            currencySize: 16.sp,
          ),
        ),
        if (payWithWallet)
          buildCartInfoRow(
            context,
            size: 24.sp,
            bold: true,
            title: '',
            value: CartPriceRichText(
              price: intl.NumberFormat.decimalPattern().format(cartTotal),
              currency: '\$',
              priceSize: 22.sp,
              currencySize: 16.sp,
            ),
          ),
        SizedBox(height: vMediumPadding),
      ],
    );
  }

  Row buildCartInfoRow(BuildContext context,
      {required String title,
      String? subtitle,
      required Widget value,
      double? size,
      bool bold = false,
      bool twoLines = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: vVerySmallPadding),
          child: RichText(
            text: TextSpan(
              text: title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: bold ? FontWeight.w500 : FontWeight.normal,
                    fontSize: size,
                  ),
              children: [
                TextSpan(
                  text: subtitle,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        value,
      ],
    );
  }

  Widget buildPlaceOrderButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            ScreenUtil().screenWidth > 800 ? hLargePadding : hMediumPadding,
      ),
      child: DefaultButton(
        width: 300.w,
        text: '',
        height: 58.h,
        buttonColor: kPrimaryColor,
        onPressed: _submit,
        child: Text(
          'Continue To Payment Method',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    // orderCubit.changeCheckoutStep(2);
  }
}
