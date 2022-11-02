import 'dart:developer';

import 'package:bring/core/constants/dimensions.dart';
import 'package:bring/core/languages/language_ar.dart';
import 'package:bring/core/languages/languages.dart';
import 'package:bring/core/theme/colors.dart';
import 'package:bring/data/models/address_model.dart';
import 'package:bring/logic/cubit/cart/cart_cubit.dart';
import 'package:bring/presentation/routers/import_helper.dart';
import 'package:bring/presentation/widgets/components/components.dart';
import 'package:bring/presentation/widgets/e_tager_icons_icons.dart';
import 'package:bring/presentation/widgets/widgetsClasses/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckoutLayoutMobile extends StatefulWidget {
  const CheckoutLayoutMobile({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutLayoutMobileState createState() => _CheckoutLayoutMobileState();
}

class _CheckoutLayoutMobileState extends State<CheckoutLayoutMobile> {
  late final OrdersCubit ordersCubit;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      ordersCubit = OrdersCubit.get(context);
      _isInit = true;
    }
  }

  @override
  void dispose() {
    ordersCubit.activeStep = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final activeStep = ordersCubit.activeStep;
        final title = ordersCubit.activeStep == 1
            ? CategoryCubit.appText!.checkout
            : ordersCubit.activeStep == 2
                ? CategoryCubit.appText!.paymentDetails
                : CategoryCubit.appText!.finish;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().screenWidth > 800
                        ? hLargePadding
                        : hMediumPadding,
                    vertical: vMediumPadding,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: hSmallPadding),
                      MyStep(
                        icon: ETagerIcons.cart_arrow_down,
                        title: CategoryCubit.appText!.cart,
                        isActive: activeStep == 0,
                        isFinished: activeStep > 0,
                        onStepSelected: () {
                          if (activeStep != 3) {
                            Navigator.pop(context);
                          }
                        },
                        shiftLeft: true,
                      ),
                      MyStepLine(isFinished: activeStep >= 1),
                      MyStep(
                        icon: ETagerIcons.ballot_check,
                        title: CategoryCubit.appText!.checkout,
                        isActive: activeStep == 1,
                        isFinished: activeStep > 1,
                        onStepSelected: () {
                          if (activeStep != 3) {
                            ordersCubit.changeCheckoutStep(1);
                          }
                        },
                      ),
                      MyStepLine(isFinished: activeStep >= 2),
                      MyStep(
                        icon: ETagerIcons.hand_holding_usd,
                        title: CategoryCubit.appText!.payment,
                        isActive: activeStep == 2,
                        isFinished: activeStep > 2,
                        onStepSelected: () async {
                          if (activeStep != 3) {
                            bool isShippingAvailable = false;
                            final cartCubit = CartCubit.get(context);
                            if (cartCubit.cartModel != null &&
                                cartCubit.cartModel!.shippingRates.isNotEmpty &&
                                cartCubit.cartModel!.shippingRates.first.rates
                                    .isNotEmpty) {
                              isShippingAvailable = cartCubit
                                  .cartModel!
                                  .shippingRates
                                  .first
                                  .rates
                                  .first
                                  .methodId
                                  .isNotEmpty;
                            }
                            if (validAddress(
                                  FirebaseAuthBloc.customer!.billing,
                                ) &&
                                isShippingAvailable) {
                              await ordersCubit.getPaymentGateways();
                              ordersCubit.changeCheckoutStep(2);
                            } else {
                              customSnackBar(
                                context: context,
                                message:
                                    CategoryCubit.appText!.shippingNotAvailable,
                                durationBySeconds: 8,
                              );
                            }
                          }
                        },
                      ),
                      MyStepLine(isFinished: activeStep >= 3),
                      MyStep(
                        icon: ETagerIcons.check_circle,
                        shiftLeft: Languages.of(context) is LanguageAr,
                        title: CategoryCubit.appText!.finish,
                        isActive: activeStep > 3,
                        isFinished: activeStep == 3,
                        onStepSelected: () {},
                      ),
                      SizedBox(width: hSmallPadding),
                    ],
                  ),
                ),
                ordersCubit.checkoutTabs[activeStep],
              ],
            ),
          ),
        );
      },
    );
  }

  bool validAddress(AddressModel address, {bool isShipping = false}) {
    log(address.address1);
    log(address.city);
    log(address.firstName);
    log(address.lastName);
    log(address.country);
    log(address.phone);
    log(address.postcode);
    log(address.state);

    if (address.address1.isNotEmpty &&
        address.city.isNotEmpty &&
        address.firstName.isNotEmpty &&
        address.lastName.isNotEmpty &&
        address.country.isNotEmpty &&
        (address.phone.isNotEmpty || isShipping) &&
        address.postcode.isNotEmpty &&
        address.state.isNotEmpty) {
      return true;
    }
    return false;
  }
}

class MyStepLine extends StatelessWidget {
  const MyStepLine({
    Key? key,
    required this.isFinished,
  }) : super(key: key);

  final bool isFinished;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          MyDottedLine(
            color: isFinished ? kSecondaryColor : iconGreyColor,
          ),
          SizedBox(height: vMediumPadding),
        ],
      ),
    );
  }
}

class MyStep extends StatelessWidget {
  const MyStep({
    Key? key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.isFinished,
    required this.onStepSelected,
    this.shiftLeft = false,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final bool isActive;
  final bool isFinished;
  final VoidCallback onStepSelected;
  final bool shiftLeft;

  @override
  Widget build(BuildContext context) {
    final isArabic = Languages.of(context) is LanguageAr;

    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(largeRadius),
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onStepSelected,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFinished ? kSecondaryColor : Colors.transparent,
              ),
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: isActive
                    ? kSecondaryColor
                    : isFinished
                        ? Colors.transparent
                        : iconGreyColor,
                strokeWidth: 0.8,
                padding: isActive && title != CategoryCubit.appText!.finish
                    ? EdgeInsets.symmetric(
                        horizontal: hVerySmallPadding,
                        vertical: vVerySmallPadding,
                      )
                    : EdgeInsets.symmetric(
                        horizontal: hVerySmallMargin,
                        vertical: vVerySmallMargin,
                      ).copyWith(
                        left: shiftLeft
                            ? isArabic
                                ? hVerySmallMargin * 1.1
                                : hVerySmallMargin * 0.8
                            : hVerySmallMargin * 1.2,
                        right: shiftLeft
                            ? isArabic
                                ? hVerySmallMargin * 0.95
                                : hVerySmallMargin * 1.2
                            : hVerySmallMargin * 1.2,
                      ),
                child: isActive && title != CategoryCubit.appText!.finish
                    ? Center(
                        child: LottieBuilder.asset(
                          'assets/animations/stepper_loading.json',
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Icon(
                        icon,
                        size: 30.w,
                        color: isActive
                            ? kSecondaryColor
                            : isFinished
                                ? Colors.white
                                : iconGreyColor,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: vSmallPadding),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: isActive
                    ? kSecondaryColor
                    : isFinished
                        ? kSecondaryColor
                        : iconGreyColor,
              ),
        ),
      ],
    );
  }
}
