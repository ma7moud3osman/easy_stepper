# easy_stepper

![Pub Version (including pre-releases)](https://img.shields.io/pub/v/easy_stepper?include_prereleases)
![GitHub issues](https://img.shields.io/github/issues-raw/ma7moud3osman/easy_stepper)
![GitHub closed issues](https://img.shields.io/github/issues-closed/ma7moud3osman/easy_stepper)
![GitHub last commit](https://img.shields.io/github/last-commit/ma7moud3osman/easy_stepper)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/ma7moud3osman/easy_stepper)
[BuyMeACoffee](https://www.buymeacoffee.com/ma7moud3osman)

## About

A fully customizable, beautiful and easy to use stepper.

## Description

The stepper widgets help you to show or collect information from users using organized steps.

## Install

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  easy_stepper: <latest_version>
```

In your library add the following import:

```dart
import 'package:easy_stepper/easy_stepper.dart';
```

## Getting started

* Simply import `package:easy_stepper/easy_stepper.dart`.

* __Important:__ The `direction` argument controls whether the stepper is displayed horizontally or vertically. A horizontal Stepper can be wrapped within a Column with no issues. However, if wrapped within a row, it _must also be_ wrapped within the built-in _Expanded_ widget. The same applies to the vertical Stepper.

* __Validation:__ To enable validation before the next step is reached, set the `steppingEnabled` property to an appropriate value in a `StatefulWidget`.

* __Controlling Steppers:__ All steppers are controlled using the `activeStep` property. You can control a stepper by tapping individual steps.

    * See examples __[here](https://pub.dev/packages/easy_stepper/example)__.

* To customize the color, border, etc., wrap a stepper widget inside a `Container` and specify it's `decoration` argument.

Example:

```dart
    EasyStepper(
         activeStep: activeStep,
         lineLength: 90,
         lineType: LineType.normal,
         steps: const [
           EasyStep(
             icon: Icon(CupertinoIcons.cart),
             activeIcon: Icon(CupertinoIcons.cart),
             title: 'Cart',
             finishIcon: Icon(Icons.check_circle_outline_rounded),
           ),
           EasyStep(
             icon: Icon(CupertinoIcons.info),
             activeIcon: Icon(CupertinoIcons.info),
             title: 'Address',
           ),
           EasyStep(
             icon: Icon(CupertinoIcons.cart_fill_badge_plus),
             activeIcon: Icon(CupertinoIcons.cart_fill_badge_plus),
             title: 'Checkout',
           ),
           EasyStep(
             icon: Icon(CupertinoIcons.money_dollar),
             activeIcon: Icon(CupertinoIcons.money_dollar),
             title: 'Payment',
           ),
           EasyStep(
             icon: Icon(Icons.file_present_rounded),
             activeIcon: Icon(Icons.file_present_rounded),
             title: 'Order Details',
           ),
           EasyStep(
             icon: Icon(Icons.check_circle_outline),
             activeIcon: Icon(Icons.check_circle_outline),
             title: 'Finish',
           ),
         ],
         onStepReached: (index) => setState(() => activeStep = index),
    ),
```


## Features

Simple to use icon stepper widget, wherein each icon defines a step. Hence, the total number of icons represents the total number of available steps. [See Example](https://pub.dev/packages/easy_stepper/example).

## Horizontal-Stepper

* __With Title:__  

![Horizontal-Stepper](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/stepper-horizontal.gif)



* __Without Title:__  

![Horizontal-Stepper-2](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/stepper_horizontal_2.gif)


* __Normal Line:__  

![Horizontal-Stepper-3](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/horizontal_line.gif)


* __With Line Text:__  

![Horizontal-Stepper-4](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/horizontal_text_line.gif)


## Vertical-Stepper

![Vertical-Stepper](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/stepper_vertical.gif)       ![Vertical-Stepper-2](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/stepper_vertical_2.gif)   ![Vertical-Stepper-3](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/vertical_3.gif)       ![Vertical-Stepper-4](https://github.com/ma7moud3osman/showcase/blob/main/easy_stepper/vertical_line.gif)



## Feedback

* Please file an issue __[here](https://github.com/ma7moud3osman/easy_stepper/issues).__

* For more information please send me an email or connect with me.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/ma7moud3osman/easy_stepper/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/ma7moud3osman/easy_stepper/pulls).

## Connect with me

[![GitHub](https://github.com/ma7moud3osman/showcase/blob/main/icons/github.png)](https://github.com/ma7moud3osman)  [![LinkedIn](https://github.com/ma7moud3osman/showcase/blob/main/icons/linkedin.png)](https://www.linkedin.com/in/ma7moud3osman/)  [![Facebook](https://github.com/ma7moud3osman/showcase/blob/main/icons/facebook.png)](https://www.facebook.com/ma7moud3osmn/) [![Twitter](https://github.com/ma7moud3osman/showcase/blob/main/icons/twitter.png)](https://twitter.com/MaHmOuD_A_OsMaN) 

## Please Support

* ![Like](https://github.com/ma7moud3osman/showcase/blob/main/icons/thumbs_up.png) Please __Like__ to __support__!

* [Buy me a Coffee](https://www.buymeacoffee.com/ma7moud3osman)