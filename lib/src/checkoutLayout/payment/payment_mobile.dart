import 'dart:developer';
import 'dart:math' show Random;

import 'package:bring/core/constants/app_config.dart';
import 'package:bring/core/constants/dimensions.dart';
import 'package:bring/core/languages/language_ar.dart';
import 'package:bring/core/languages/languages.dart';
import 'package:bring/core/theme/colors.dart';
import 'package:bring/data/models/payment_model.dart';
import 'package:bring/logic/cubit/cart/cart_cubit.dart';
import 'package:bring/presentation/routers/import_helper.dart';
import 'package:bring/presentation/widgets/components/components.dart';
import 'package:bring/presentation/widgets/defaultButton/default_button.dart';
import 'package:bring/presentation/widgets/textFieldWithLabel/text_field_with_label.dart';
import 'package:bring/presentation/widgets/widgetsClasses/widgets.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

class PaymentMobile extends StatefulWidget {
  const PaymentMobile({Key? key}) : super(key: key);

  @override
  State<PaymentMobile> createState() => _PaymentMobileState();
}

class _PaymentMobileState extends State<PaymentMobile> {
  final formKey = GlobalKey<FormState>();
  final Map<String, String> cardDetails = {};
  PaymentModel? selectedPaymentModel;
  late final OrdersCubit ordersCubit;
  late final CartCubit cartCubit;
  bool showAddNewCardButton = false;
  bool showNewCardView = false;
  // double totalCost = 0;
  int paymentMethodIndex = 0;
  bool isAgree = false;
  bool _isInit = false;
  bool paymentWithPayTabsDone = false;
  late final BillingDetails billingDetails;
  late final ShippingDetails? shippingDetails;
  late final PaymentModel pointPaymentModel;
  late final PaymentModel payTabsModel;
  late bool isArabic;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      cartCubit = CartCubit.get(context);
      isArabic = Languages.of(context) is LanguageAr;
      final cartModel = cartCubit.cartModel!;
      billingDetails = BillingDetails(
        '${cartModel.billingAddress.firstName} ${cartModel.billingAddress.lastName}',
        cartModel.billingAddress.email!,
        cartModel.billingAddress.phone,
        cartModel.billingAddress.address1,
        cartModel.billingAddress.country,
        cartModel.billingAddress.city,
        cartModel.billingAddress.state,
        cartModel.billingAddress.postcode,
      );
      shippingDetails = cartModel.shippingAddress.address1.isNotEmpty
          ? ShippingDetails(
              '${cartModel.shippingAddress.firstName} ${cartModel.shippingAddress.lastName}',
              '',
              cartModel.shippingAddress.phone,
              cartModel.shippingAddress.address1,
              cartModel.shippingAddress.country,
              cartModel.shippingAddress.city,
              cartModel.shippingAddress.state,
              cartModel.shippingAddress.postcode,
            )
          : null;
      ordersCubit = OrdersCubit.get(context);
      if (ordersCubit.paymentGateways.isNotEmpty) {
        pointPaymentModel = PaymentModel(
          id: 'ppm',
          title: isArabic ? 'النقاط' : 'Points',
          description:
              isArabic ? 'ادفع باستخدام نقاط الخصم' : 'Pay with your points',
          isPoints: true,
          points: cartCubit.points,
          enabled: true,
        );

        payTabsModel = PaymentModel(
          id: 'paytabs_creditcard',
          title: CategoryCubit.appText!.paytabs,
          enabled: true,
          description: CategoryCubit.appText!.paytabsDescription,
        );
        ordersCubit.paymentGateways.add(pointPaymentModel);
        // ordersCubit.paymentGateways.add(payTabsModel);
        selectedPaymentModel = ordersCubit.paymentGateways.first;
        showAddNewCardButton =
            selectedPaymentModel!.id == 'woocommerce_payments';
      }
      _isInit = true;
    }
  }

  Future<void> getUserBalance() async {
    await cartCubit.getPointsBalance(id: FirebaseAuthBloc.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    // totalCost = calculateTotal();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            ScreenUtil().screenWidth > 800 ? hLargePadding : hMediumPadding,
        vertical: vMediumPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainHeadline(title: CategoryCubit.appText!.paymentMethod),
          SizedBox(height: vSmallPadding),
          Text(CategoryCubit.appText!.allTransactionsSecure),
          SizedBox(height: vSmallPadding),
          const MyDottedLine(color: iconGreyColor),
          SizedBox(height: vMediumPadding),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: OrdersCubit.get(context).paymentGateways.length,
            itemBuilder: (context, index) {
              final payment = OrdersCubit.get(context).paymentGateways[index];
              return PaymentMethodCard(
                paymentMethod: payment.title,
                description: payment.description,
                points: payment.points,
                onChange: (value) => setState(() {
                  paymentMethodIndex = value as int;
                  selectedPaymentModel = ordersCubit.paymentGateways[value];
                  showAddNewCardButton =
                      selectedPaymentModel!.id == 'woocommerce_payments';
                  if (!showAddNewCardButton) {
                    showNewCardView = false;
                  }
                }),
                selectedMethod: paymentMethodIndex,
                value: index,
                trailing: payment.id == 'ppcp-gateway' ||
                        payment.id == 'woocommerce_payments'
                    ? Image.asset(
                        'assets/images/payment_methods.png',
                        height: 40.h,
                        width: 120.w,
                      )
                    : null,
              );
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: vMediumPadding),
          ),
          if (showAddNewCardButton) ...[
            SizedBox(height: vMediumPadding),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: OutlinedButton(
                onPressed: () => setState(() => showNewCardView = true),
                child: Text(CategoryCubit.appText!.addNewCard),
              ),
            ),
          ],
          if (showNewCardView) addNewCardView(),
          SizedBox(height: vLargePadding),
          Text(
            CategoryCubit.appText!.yourPersonalDataSentence,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  height: 1.8,
                ),
          ),
          SizedBox(height: vMediumPadding),
          Divider(
            color: Theme.of(context).colorScheme.primary,
          ),
          Row(
            children: [
              Checkbox(
                value: isAgree,
                fillColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
                activeColor: Theme.of(context).colorScheme.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
                onChanged: (value) => setState(() => isAgree = value!),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: RichText(
                  text: TextSpan(
                    text: '${CategoryCubit.appText!.iHaveReadAndAgree} ',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () async {
                            final customerCubit = CustomerCubit.get(context);
                            showLoadingDialog(context);
                            await customerCubit.getReturnPolicy();
                            Navigator.pop(context);
                            if (customerCubit.returnPolicy != null) {
                              buildPolicyBottomSheet(
                                context,
                                title: CategoryCubit.appText!.returnPolicy,
                                policyModel: customerCubit.returnPolicy!,
                              );
                            }
                          },
                          child: Text(
                            '${CategoryCubit.appText!.returnPolicy} *',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: vVeryLargeMargin),
          BlocConsumer<OrdersCubit, OrdersState>(
            listener: (context, state) async {
              final cartCubit = CartCubit.get(context);
              if (state is OrdersCreateSuccess) {
                if (selectedPaymentModel != null &&
                    selectedPaymentModel!.id == 'ppm') {
                  await cartCubit.payWithPoints(
                      userId: FirebaseAuthBloc.user!.id,
                      amount: double.parse(ordersCubit.createdOrder!.total),
                      referenceId: ordersCubit.createdOrder!.orderId);
                  await cartCubit.orderPayout(
                      id: ordersCubit.createdOrder!.orderId);
                }
                cartCubit.cartItems.addAll([...cartCubit.cartModel!.items]);
                await cartCubit.clearCartItems();
                ordersCubit.sendOrderID(state.order.orderId);
                OrdersCubit.get(context).changeCheckoutStep(3);
              } else if (state is OrdersCreateFailed) {
                customSnackBar(
                  context: context,
                  message: CategoryCubit.appText!.failedToCreateOrder,
                );
              }
            },
            builder: (context, orderState) {
              return BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return DefaultButton(
                    text: Languages.of(context).placeOrder,
                    width: double.infinity,
                    buttonColor: kPrimaryColor,
                    isLoading: orderState is OrdersCreateLoading ||
                        state is CartRemoveItemLoading ||
                        state is CartClearItemsLoading,
                    onPressed: _placeOrder,
                  );
                },
              );
            },
          ),
          SizedBox(height: vVeryLargeMargin),
        ],
      ),
    );
  }

  Column addNewCardView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: vMediumPadding),
        SmallHeadline(title: CategoryCubit.appText!.addNewCard),
        SizedBox(height: vMediumPadding),
        CardViewItem(
          cardType: CategoryCubit.appText!.bankCards,
          cardDetails: cardDetails,
          formKey: formKey,
          onCardSaved: () {
            setState(() => showNewCardView = false);
            log('Card Details : $cardDetails ');
          },
        ),
      ],
    );
  }

  Future<void> _placeOrder() async {
    if (isAgree) {
      final ordersCubit = OrdersCubit.get(context);
      final cartCubit = CartCubit.get(context);
      final cartModel = cartCubit.cartModel!;
      if (selectedPaymentModel!.id == 'paytabs_creditcard' ||
          selectedPaymentModel!.id.contains('paytabs')) {
        await payWithPayTabs();
        if (paymentWithPayTabsDone) {
          await ordersCubit.createOrder(
            cartModel,
            selectedPaymentModel!,
            partnerId: cartCubit.partnerId ?? 0,
          );
        }
      } else {
        await ordersCubit.createOrder(
          cartModel,
          selectedPaymentModel ??
              const PaymentModel(
                  id: 'cod',
                  title: 'Cash on delivery',
                  enabled: true,
                  description: 'description'),
          partnerId: cartCubit.partnerId ?? 0,
        );
      }
    } else {
      customSnackBar(
        context: context,
        message: CategoryCubit.appText!.youMustAgreesToReturn,
      );
    }
  }

  Future<void> payWithPayTabs() async {
    final configuration = _configurePayTabs(billingDetails, shippingDetails);
    await _startPayment(configuration);
  }

  PaymentSdkConfigurationDetails _configurePayTabs(
      BillingDetails billingDetails, ShippingDetails? shippingDetails) {
    final cartModel = CartCubit.get(context).cartModel!;
    final isAr = Languages.of(context) is LanguageAr;
    final configuration = PaymentSdkConfigurationDetails(
      profileId: CategoryCubit.payTabsModel.profileId,
      serverKey: CategoryCubit.payTabsModel.serverKey,
      clientKey: CategoryCubit.payTabsModel.clientKey,
      cartId: Random().nextInt(999999).toString(),
      merchantName: appNameEng,
      screentTitle: isAr ? "ادفع بالبطاقة" : "Pay with Card",
      billingDetails: billingDetails,
      shippingDetails: shippingDetails,
      locale: isAr
          ? PaymentSdkLocale.AR
          : PaymentSdkLocale
              .EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
      amount: double.parse(cartModel.totals.totalPrice),
      currencyCode: 'EGP',
      merchantCountryCode: "EG",
      hideCardScanner: false,
      // showBillingInfo: true,
    );
    final theme = IOSThemeConfigurations(
      backgroundColor: 'F9FAFD',
      primaryColor: 'ffffff',
      secondaryColor: 'F9FAFD',
      buttonColor: '0070E0',
      titleFontColor: '000000',
      secondaryFontColor: '1e272e',
      primaryFontColor: '000000',
      strokeColor: '1e272e',
      buttonFontColor: 'ffffff',
    );
    theme.logoImage = 'assets/images/logo.png';
    theme.secondaryColor = '0070E0';
    configuration.iOSThemeConfigurations = theme;
    return configuration;
  }

  Future<void> _startPayment(
      PaymentSdkConfigurationDetails configuration) async {
    await FlutterPaytabsBridge.startCardPayment(configuration, (event) async {
      if (event["status"] == "success") {
        // Handle transaction details here.
        final transactionDetails = event["data"];
        log('Success: ${transactionDetails.toString()}');
        if (mounted) setState(() => paymentWithPayTabsDone = true);
        await createOrder();
      } else if (event["status"] == "error") {
        // Handle error here.
        customSnackBar(context: context, message: '${event['message']}');
        log('Error: ${event["message"]}');
      } else if (event["status"] == "event") {
        // Handle events here.
        log('Event??');
      }
    });
  }

  Future<void> createOrder() async {
    final cartModel = cartCubit.cartModel!;
    await ordersCubit.createOrder(cartModel, selectedPaymentModel!,
        partnerId: cartCubit.partnerId ?? 0);
  }

  // double calculateTotal() {
  //   double totalCost;
  //   try {
  //     totalCost = double.parse(widget.orderModel.price) +
  //         double.parse(widget.orderModel.serviceFee == ''
  //             ? '0'
  //             : widget.orderModel.serviceFee) +
  //         double.parse(widget.orderModel.area!.deliveryPrice) -
  //         discount;
  //   } catch (e) {
  //     totalCost = 0;
  //     log(e.toString());
  //   }
  //   return totalCost;
  // }
}

class CardViewItem extends StatelessWidget {
  const CardViewItem({
    Key? key,
    required this.cardType,
    required this.formKey,
    required this.cardDetails,
    required this.onCardSaved,
  }) : super(key: key);
  final String cardType;
  final GlobalKey<FormState> formKey;
  final Map<String, String> cardDetails;
  final VoidCallback onCardSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hVerySmallPadding * 0.5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(verySmallRadius),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor2.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        // onTap: () => onChange(value),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: hVerySmallPadding,
            end: hMediumPadding,
            top: vVerySmallPadding,
            bottom: vMediumPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Radio(
                    value: true,
                    groupValue: true,
                    fillColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {},
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: vSmallPadding),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cardType,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/images/payment_methods.png',
                              height: 40.h,
                              width: 120.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: hSmallPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: vSmallPadding),
                      FilledTextFieldWithLabel(
                        labelText: CategoryCubit.appText!.cardNumber,
                        hintText: '1234  5678  9125  1235',
                        style: Theme.of(context).textTheme.subtitle1,
                        keyboardType: TextInputType.number,
                        maxLength: 16,
                        counterText: '',
                        onChange: (value) {
                          if (value.length == 16) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        onSaved: (value) => cardDetails['cardNumber'] = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return CategoryCubit.appText!.filedIsRequired;
                          } else if (value.length < 16) {
                            return CategoryCubit.appText!.enterValidCardNumber;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: vMediumPadding),
                      Text(
                        CategoryCubit.appText!.expireDate,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: vSmallPadding),
                      Row(
                        children: [
                          Expanded(
                            child: FilledTextFieldWithLabel(
                              hintText: 'MM',
                              style: Theme.of(context).textTheme.subtitle1,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              counterText: '',
                              onChange: (value) {
                                if (value.length == 2) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (value) => cardDetails['mm'] = value!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return CategoryCubit.appText!.filedIsRequired;
                                } else if (value.length < 2) {
                                  return CategoryCubit.appText!.enterValidMonth;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: hMediumPadding),
                          Expanded(
                            child: FilledTextFieldWithLabel(
                              hintText: 'YY',
                              style: Theme.of(context).textTheme.subtitle1,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              counterText: '',
                              onChange: (value) {
                                if (value.length == 2) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (value) => cardDetails['yy'] = value!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return CategoryCubit.appText!.filedIsRequired;
                                } else if (value.length < 2) {
                                  return CategoryCubit.appText!.enterValidYear;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: hMediumPadding),
                          Expanded(
                            child: FilledTextFieldWithLabel(
                              hintText: 'CVV',
                              style: Theme.of(context).textTheme.subtitle1,
                              keyboardType: TextInputType.number,
                              inputAction: TextInputAction.done,
                              maxLength: 3,
                              counterText: '',
                              onChange: (value) {
                                if (value.length == 3) {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              onSaved: (value) => cardDetails['cvv'] = value!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return CategoryCubit.appText!.filedIsRequired;
                                } else if (value.length < 3) {
                                  return CategoryCubit.appText!.enterValidCVV;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: vLargePadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DefaultButton(
                            text: CategoryCubit.appText!.saveCard,
                            smallSize: true,
                            width: 130.w,
                            height: 43.h,
                            onPressed: () => saveCard(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveCard() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      onCardSaved();
    }
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    Key? key,
    required this.paymentMethod,
    required this.description,
    this.trailing,
    this.points,
    required this.onChange,
    required this.selectedMethod,
    required this.value,
  }) : super(key: key);
  final String paymentMethod;
  final String description;
  final Widget? trailing;
  final ValueSetter onChange;
  final int selectedMethod;
  final int value;
  final num? points;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hVerySmallPadding * 0.5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(verySmallRadius),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor2.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: points != null &&
                points! <
                    num.parse(
                        CartCubit.get(context).cartModel!.totals.totalPrice)
            ? null
            : () => onChange(value),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: hVerySmallPadding,
            end: hMediumPadding,
            top: vVerySmallPadding,
            bottom: vMediumPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Radio(
                value: value,
                groupValue: selectedMethod,
                fillColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: points != null &&
                        points! <
                            num.parse(CartCubit.get(context)
                                .cartModel!
                                .totals
                                .totalPrice)
                    ? (_) {
                        customSnackBar(
                            context: context, message: 'Insufficient Points');
                      }
                    : onChange,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: vSmallPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentMethod,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Spacer(),
                        if (trailing != null)
                          trailing!
                        else if (points != null)
                          Container(
                            width: 80.w + (5.w * points.toString().length),
                            height: 35.w,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(veryLargeRadius),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            alignment: Alignment.center,
                            child: Text('$points ${CategoryCubit.currency}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                    )),
                          )
                        else
                          SizedBox(height: vMediumPadding),
                      ],
                    ),
                    SizedBox(height: vSmallPadding),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            height: 1.8,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
