import 'package:dotted_border/dotted_border.dart';
import 'package:easy_stepper/src/colors.dart';
import 'package:easy_stepper/src/components/shared_widgets.dart';
import 'package:easy_stepper/src/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

class OrderThankYouMobile extends StatelessWidget {
  const OrderThankYouMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: hMediumPadding,
            vertical: vMediumPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainHeadline(title: 'Finish'),
              SizedBox(height: vSmallPadding),
              const MyDottedLine(color: iconGreyColor),
              SizedBox(height: vLargeMargin),
              Center(
                child: Text(
                  'Thank You, Your order has been received',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        height: 1.5,
                      ),
                ),
              ),
              SizedBox(height: vLargePadding),
              DottedBorder(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().screenWidth > 800
                      ? hLargePadding
                      : hMediumPadding,
                  vertical: vLargePadding,
                ),
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 3,
                dashPattern: const [5, 5],
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Order No.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Date',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: vMediumPadding),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '#123',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            intl.DateFormat.yMMMMd().format(
                              DateTime.now(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: vVeryLargePadding),
                    Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Total',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Payment Method',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: vMediumPadding),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${intl.NumberFormat.decimalPattern().format(double.parse('200'))} ',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                '\$',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Cash on delivery',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: vVeryLargePadding),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: hMediumPadding,
            vertical: vMediumPadding,
          ),
          color: authBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // buildTotalPriceView(context, createdOrder),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildTotalPriceView(BuildContext context) {
  const subtotal = 100;
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
      SizedBox(height: vMediumPadding),
    ],
  );
}

Widget buildCartInfoRow(BuildContext context,
    {required String title,
    String? subtitle,
    required Widget value,
    bool bold = false,
    double? size}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: vSmallPadding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
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
        const Spacer(),
        value,
      ],
    ),
  );
}
