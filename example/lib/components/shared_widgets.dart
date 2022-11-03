import 'package:dotted_line/dotted_line.dart';
import 'package:example/constants/colors.dart';
import 'package:example/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDottedLine extends StatelessWidget {
  const MyDottedLine({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      dashColor: color ?? Theme.of(context).colorScheme.primary,
      dashLength: 2,
      dashGapLength: 2,
    );
  }
}

class CartPriceRichText extends StatelessWidget {
  final String price;
  final String currency;
  final double? priceSize;
  final double? currencySize;
  final Color? color;
  const CartPriceRichText({
    Key? key,
    required this.price,
    required this.currency,
    this.priceSize,
    this.currencySize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: price,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: priceSize,
              color: color,
            ),
        children: [
          TextSpan(
            text: ' $currency ',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: currencySize,
                  fontWeight: currencySize != null
                      ? FontWeight.w500
                      : FontWeight.normal,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}

class SmallHeadline extends StatelessWidget {
  final String title;
  final Color? color;
  const SmallHeadline({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: color,
            ));
  }
}

class MainHeadline extends StatelessWidget {
  const MainHeadline({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w500,
            color: color,
          ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final bool isLoading;
  final Widget? child;
  final Color? disabledColor;
  final bool smallSize;
  final AlignmentDirectional alignment;
  final EdgeInsets? padding;

  const DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.buttonColor,
      this.borderRadius,
      this.height,
      this.width,
      this.textColor,
      this.isLoading = false,
      this.child,
      this.disabledColor,
      this.smallSize = false,
      this.alignment = AlignmentDirectional.center,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: alignment,
      child: Container(
        width: width ?? 300.w,
        height: height ?? (smallSize ? 50.w : 58.w),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius != null ? borderRadius!.r : verySmallRadius,
          ),
        ),
        child: MaterialButton(
          onPressed: isLoading ? null : onPressed,
          color: buttonColor ?? kSecondaryColor,
          disabledColor: disabledColor ?? buttonColor ?? kPrimaryColor,
          padding: padding,
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : child ??
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor ?? lightWhite,
                        fontWeight: FontWeight.normal,
                        fontSize: smallSize
                            ? Theme.of(context).textTheme.subtitle2!.fontSize
                            : Theme.of(context).textTheme.subtitle1!.fontSize,
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}

class AddressMiniView extends StatelessWidget {
  const AddressMiniView({
    Key? key,
    this.shippingFee,
  }) : super(key: key);
  final String? shippingFee;

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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: hVerySmallPadding,
          vertical: vVerySmallPadding,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: true,
                  fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    shippingFee != null
                        ? 'As billing address'
                        : 'USA, California',
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (shippingFee != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: hSmallPadding,
                  vertical: vSmallPadding,
                ).copyWith(top: 0),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: RichText(
                    text: TextSpan(
                      text: 'Shipping fees: ',
                      style: Theme.of(context).textTheme.bodyText2,
                      children: [
                        TextSpan(
                          text: shippingFee,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        TextSpan(
                          text: ' ${'\$'}',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
