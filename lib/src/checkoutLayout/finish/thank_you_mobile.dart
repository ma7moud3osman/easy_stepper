import 'dart:developer';

import 'package:easy_stepper/core/constants/dimensions.dart';
import 'package:easy_stepper/core/languages/languages.dart';
import 'package:easy_stepper/core/theme/colors.dart';
import 'package:easy_stepper/logic/cubit/cart/cart_cubit.dart';
import 'package:easy_stepper/presentation/routers/import_helper.dart';
import 'package:easy_stepper/presentation/screens/homeLayout/cart/cart_tab_mobile.dart';
import 'package:easy_stepper/presentation/widgets/loading_image_container.dart';
import 'package:easy_stepper/presentation/widgets/widgetsClasses/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrderThankYouMobile extends StatelessWidget {
  const OrderThankYouMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final createdOrder = OrdersCubit.get(context).createdOrder!;

        if (state is! OrdersThankYouLoading) {
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: vVeryLargeMargin),
              Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

Widget buildTotalPriceView(BuildContext context, OrderModel orderModel) {
  final total = double.parse(orderModel.total);
  final shipping = double.parse(orderModel.shippingTotal);
  final tax = double.parse(orderModel.totalTax);
  final discount = double.parse(orderModel.discountTotal);
  final subtotal = (total + discount) - (tax + shipping);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SmallHeadline(title: CategoryCubit.appText!.total),
      SizedBox(height: vMediumPadding),
      buildCartInfoRow(
        context,
        title: CategoryCubit.appText!.subtotal,
        value: CartPriceRichText(
          price: intl.NumberFormat.decimalPattern().format(subtotal),
          currency: orderModel.currency,
          priceSize: 20.sp,
          currencySize: 14.sp,
        ),
        size: 20.w,
      ),
      const MyDottedLine(color: iconGreyColor),
      SizedBox(height: vVerySmallPadding),
      buildCartInfoRow(
        context,
        title: CategoryCubit.appText!.shipping,
        value: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CartPriceRichText(
              price: intl.NumberFormat.decimalPattern().format(shipping),
              currency: orderModel.currency,
            ),
            SizedBox(height: vVerySmallPadding),
            Text(
              '${CategoryCubit.appText!.shippingTo} ${orderModel.shippingAddress.state}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: vSmallPadding),
          ],
        ),
      ),
      const MyDottedLine(color: iconGreyColor),
      // SizedBox(height: vVerySmallPadding),
      // buildCartInfoRow(
      //   context,
      //   title: CategoryCubit.appText!.vat,
      //   subtitle:
      //       ' (${CategoryCubit.appText!.estimatedFor} ${orderModel.shippingAddress.country})',
      //   value: CartPriceRichText(
      //     price: intl.NumberFormat.decimalPattern().format(tax),
      //     currency: orderModel.currency,
      //   ),
      // ),
      // const MyDottedLine(color: iconGreyColor),
      // SizedBox(height: vVerySmallPadding),
      // buildCartInfoRow(
      //   context,
      //   title: CategoryCubit.appText!.discount,
      //   value: CartPriceRichText(
      //     price: '- ${intl.NumberFormat.decimalPattern().format(discount)}',
      //     currency: orderModel.currency,
      //   ),
      // ),
      // const MyDottedLine(color: iconGreyColor),
      // SizedBox(height: vVerySmallPadding),
      // buildCartInfoRow(
      //   context,
      //   title: CategoryCubit.appText!.paymentMethod,
      //   value: Text(orderModel.paymentMethodTitle),
      // ),
      // const MyDottedLine(color: iconGreyColor),
      SizedBox(height: vVeryLargePadding),
      buildCartInfoRow(
        context,
        size: 24.sp,
        bold: true,
        title: CategoryCubit.appText!.total,
        value: CartPriceRichText(
          price: intl.NumberFormat.decimalPattern().format(total),
          currency: orderModel.currency,
          priceSize: 22.sp,
          currencySize: 16.sp,
          color: Theme.of(context).colorScheme.primary,
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

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.orderItem,
    required this.currency,
  }) : super(key: key);
  final OrderItemModel orderItem;
  final String currency;
  @override
  Widget build(BuildContext context) {
    String? image;
    try {
      final cartItem = CartCubit.get(context).cartItems.firstWhere((element) {
        log('Element Id: ${element.id}');
        log('orderItem Id: ${orderItem.productId}');
        return element.id == orderItem.productId;
      });
      image = cartItem.images.isNotEmpty ? cartItem.images.first.srcUrl : null;
    } catch (e) {
      log('Error during get cart item image $e');
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null)
          CachedNetworkImage(
            imageUrl: image,
            width: 60.w,
            height: 60.w,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                LoadingImageContainer(width: 60.w, height: 60.w),
            errorWidget: (context, url, error) => LoadingImageContainer(
              width: 60.w,
              height: 60.w,
              repeat: false,
            ),
          )
        else
          LoadingImageContainer(
            width: 60.w,
            height: 60.w,
            repeat: false,
          ),
        SizedBox(width: hSmallPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallHeadline(title: orderItem.name),
              SizedBox(height: vSmallPadding),
              PricesWidget(
                regularPrice: '${double.parse(orderItem.subtotal)}',
                currency: currency,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                ScreenUtil().screenWidth > 800 ? hLargePadding : hMediumPadding,
            vertical: vMediumPadding,
          ),
          child: Center(
            child: Text(
              orderItem.quantity.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ],
    );
  }
}
