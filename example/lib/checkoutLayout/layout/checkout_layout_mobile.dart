// ignore_for_file: library_private_types_in_public_api

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: EasyStepper(
        physics: const NeverScrollableScrollPhysics(),
        steps: [
          EasyStep(
            icon: const Icon(Icons.shopping_cart_checkout),
            title: 'Cart',
            isActive: activeStep == 0,
            isFinished: activeStep > 0,
          ),
          EasyStep(
            icon: const Icon(Icons.dashboard_customize),
            title: 'Checkout',
            isActive: activeStep == 1,
            isFinished: activeStep > 1,
          ),
          EasyStep(
            icon: const Icon(Icons.money_rounded),
            title: 'Payment',
            isActive: activeStep == 2,
            isFinished: activeStep > 2,
          ),
          EasyStep(
            icon: const Icon(Icons.check_circle_outline),
            title: 'Finish',
            isActive: activeStep == 3,
            isFinished: activeStep > 3,
          ),
        ],
        onChangeStep: (index) => setState(() => activeStep = index),
      ),
    );
  }
}

// class MyStepLine extends StatelessWidget {
//   const MyStepLine({
//     Key? key,
//     required this.isFinished,
//   }) : super(key: key);

//   final bool isFinished;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           MyDottedLine(
//             color: isFinished ? kSecondaryColor : iconGreyColor,
//           ),
//           SizedBox(height: vMediumPadding),
//         ],
//       ),
//     );
//   }
// }

// class MyStep extends StatelessWidget {
//   const MyStep({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.isActive,
//     required this.isFinished,
//     required this.onStepSelected,
//     this.shiftLeft = false,
//   }) : super(key: key);
//   final IconData icon;
//   final String title;
//   final bool isActive;
//   final bool isFinished;
//   final VoidCallback onStepSelected;
//   final bool shiftLeft;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Material(
//           borderRadius: BorderRadius.circular(largeRadius),
//           color: Colors.transparent,
//           clipBehavior: Clip.antiAlias,
//           child: InkWell(
//             onTap: onStepSelected,
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: isFinished ? kSecondaryColor : Colors.transparent,
//               ),
//               child: DottedBorder(
//                 borderType: BorderType.Circle,
//                 color: isActive
//                     ? kSecondaryColor
//                     : isFinished
//                         ? Colors.transparent
//                         : iconGreyColor,
//                 strokeWidth: 0.8,
//                 padding: isActive && title != 'Finish'
//                     ? EdgeInsets.symmetric(
//                         horizontal: hVerySmallPadding,
//                         vertical: vVerySmallPadding,
//                       )
//                     : EdgeInsets.symmetric(
//                         horizontal: hVerySmallMargin,
//                         vertical: vVerySmallMargin,
//                       ).copyWith(
//                         left: shiftLeft
//                             ? hVerySmallMargin * 0.8
//                             : hVerySmallMargin * 1.2,
//                         right: shiftLeft
//                             ? hVerySmallMargin * 1.2
//                             : hVerySmallMargin * 1.2,
//                       ),
//                 child: isActive && title != 'Finish'
//                     ? Center(
//                         child: LottieBuilder.asset(
//                           'assets/animations/stepper_loading.json',
//                           width: 50.w,
//                           height: 50.h,
//                           fit: BoxFit.contain,
//                         ),
//                       )
//                     : Icon(
//                         icon,
//                         size: 30.w,
//                         color: isActive
//                             ? kSecondaryColor
//                             : isFinished
//                                 ? Colors.white
//                                 : iconGreyColor,
//                       ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: vSmallPadding),
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                 color: isActive
//                     ? kSecondaryColor
//                     : isFinished
//                         ? kSecondaryColor
//                         : iconGreyColor,
//               ),
//         ),
//       ],
//     );
//   }
// }
