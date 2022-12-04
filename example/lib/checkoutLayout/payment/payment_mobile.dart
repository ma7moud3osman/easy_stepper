import 'package:example/components/shared_widgets.dart';
import 'package:example/components/text_field_with_label.dart';
import 'package:example/constants/colors.dart';
import 'package:example/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMobile extends StatefulWidget {
  const PaymentMobile({Key? key}) : super(key: key);

  @override
  State<PaymentMobile> createState() => _PaymentMobileState();
}

class _PaymentMobileState extends State<PaymentMobile> {
  final Map<String, String> cardDetails = {};
  bool showAddNewCardButton = false;
  bool showNewCardView = false;
  // double totalCost = 0;
  int paymentMethodIndex = 0;
  bool isAgree = false;
  bool paymentWithPayTabsDone = false;
  late bool isArabic;

  @override
  Widget build(BuildContext context) {
    // totalCost = calculateTotal();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hMediumPadding,
        vertical: vMediumPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainHeadline(title: 'Payment Method'),
          SizedBox(height: vSmallPadding),
          const Text('All Transactions are secure'),
          SizedBox(height: vSmallPadding),
          const MyDottedLine(color: iconGreyColor),
          SizedBox(height: vMediumPadding),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return PaymentMethodCard(
                paymentMethod: 'Cash on delivery',
                description: 'Pay with cash upon delivery',
                onChange: (value) => setState(() {
                  paymentMethodIndex = value as int;
                  if (!showAddNewCardButton) {
                    showNewCardView = false;
                  }
                }),
                selectedMethod: paymentMethodIndex,
                value: index,
              );
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: vMediumPadding),
          ),
          SizedBox(height: vMediumPadding),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: OutlinedButton(
              onPressed: () => setState(() => showNewCardView = true),
              child: const Text('Add New Card'),
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
                    text: 'I have read and agree to the ',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () async {},
                          child: Text(
                            'Return Policy *',
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
          DefaultButton(
            text: 'Place Order',
            width: double.infinity,
            buttonColor: kPrimaryColor,
            onPressed: _placeOrder,
          ),
          SizedBox(height: vVeryLargeMargin),
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    if (isAgree) {
      //TODO: change current step...
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'You Must Agree to the Return Policy to Continue',
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }
}

class CardViewItem extends StatelessWidget {
  const CardViewItem({
    Key? key,
    required this.cardType,
    required this.cardDetails,
    required this.onCardSaved,
  }) : super(key: key);
  final String cardType;
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
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: hSmallPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: vSmallPadding),
                      FilledTextFieldWithLabel(
                        labelText: 'Card Number',
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
                            return 'Required Fields';
                          } else if (value.length < 16) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: vMediumPadding),
                      Text(
                        'Expire Date',
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
                                  return 'Required Fields';
                                } else if (value.length < 2) {
                                  return 'Enter a valid Month';
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
                                  return 'Required Fields';
                                } else if (value.length < 2) {
                                  return 'Enter a valid Year';
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
                                  return 'Required Fields';
                                } else if (value.length < 3) {
                                  return 'Enter a valid CVV';
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
                            text: 'Save Card',
                            smallSize: true,
                            width: 130.w,
                            height: 43.h,
                            onPressed: () {},
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
        onTap: points != null && points! < num.parse('10')
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
                onChanged: onChange,
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
