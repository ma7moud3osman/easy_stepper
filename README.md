![Easy Stepper](https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/logo.png)

## About

[![Pub Version](https://img.shields.io/pub/v/easy_stepper.svg?label=pub&color=blue)](https://pub.dev/packages/easy_stepper/versions)
[![GitHub Stars](https://img.shields.io/github/stars/ma7moud3osman/easy_stepper?color=yellow&label=Stars)](https://github.com/ma7moud3osman/easy_stepper/stargazers)
[![GitHub opened issues](https://img.shields.io/github/issues/ma7moud3osman/easy_stepper?color=red)](https://github.com/ma7moud3osman/easy_stepper/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/ma7moud3osman/easy_stepper)](https://github.com/ma7moud3osman/easy_stepper/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub last commit](https://img.shields.io/github/last-commit/ma7moud3osman/easy_stepper)](https://github.com/ma7moud3osman/easy_stepper/commits/main)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/ma7moud3osman/easy_stepper?label=size)
[![GitHub forks](https://img.shields.io/github/forks/ma7moud3osman/easy_stepper)](https://github.com/ma7moud3osman/easy_stepper/network/members)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](https://github.com/ma7moud3osman/easy_stepper/blob/main/LICENSE)


**Guide users, step by step.** A fully customizable, beautiful and easy-to-use stepper widget with different variations.

## Description

Easy Stepper guides your users through a flow one step at a time — showing progress or collecting information in clear, organized steps.

<table>
  <tr>
    <td align="center"><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/mock_horizontal.gif" width="150" alt="Horizontal checkout" /></td>
    <td align="center"><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/mock_vertical.gif" width="150" alt="Vertical order tracking" /></td>
    <td align="center"><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/mock_delivery.gif" width="150" alt="Delivery status" /></td>
    <td align="center"><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/mock_onboarding.gif" width="150" alt="Onboarding" /></td>
  </tr>
</table>

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


## 🎬 Stepper types

`EasyStepper` is one widget with many looks. The app mockups above show these types inside real screens — below, each type lists the **variations** you can produce, with a collapsible code snippet.

---

### 🧭 Horizontal

Icons or custom content in a row, with titles above/below/none and dotted or solid connectors — the everyday wizard.

**Variations**

<table>
<tr>
<td align="center">

<b>Titles below · dotted</b><br/><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/h_titles_dotted.gif" width="340" alt="Titles below · dotted" />

</td>
<td align="center">

<b>No titles · solid</b><br/><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/h_notitle_solid.gif" width="340" alt="No titles · solid" />

</td>
</tr>
<tr>
<td align="center">

<b>Rounded rectangle</b><br/><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/h_rrect.gif" width="340" alt="Rounded rectangle" />

</td>
<td align="center">

<b>Line text</b><br/><img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/h_linetext.gif" width="340" alt="Line text" />

</td>
</tr>
</table>

<details>
<summary><b>View example code</b> &nbsp;·&nbsp; 25 lines</summary>

```dart
EasyStepper(
  activeStep: activeStep,
  stepRadius: 28,
  showLoadingAnimation: false,
  stepBorderRadius: 15,
  finishedStepBackgroundColor: const Color(0xFF7C3AED),
  activeStepBackgroundColor: const Color(0xFF7C3AED),
  finishedStepTextColor: const Color(0xFF7C3AED),
  lineStyle: const LineStyle(
    lineLength: 60,
    lineType: LineType.normal,
    lineThickness: 3,
    unreachedLineType: LineType.dashed,
    defaultLineColor: Color(0xFFDCD7E8),
    finishedLineColor: Color(0xFF7C3AED),
  ),
  steps: const [
    EasyStep(icon: Icon(Icons.shopping_cart), title: 'Cart'),
    EasyStep(icon: Icon(Icons.person), title: 'Address'),
    EasyStep(icon: Icon(Icons.receipt_long), title: 'Checkout'),
    EasyStep(icon: Icon(Icons.star), title: 'Review'),
    EasyStep(icon: Icon(Icons.check_circle), title: 'Done'),
  ],
  onStepReached: (index) => setState(() => activeStep = index),
)
```

</details>

---

### 🧵 Vertical

Set `direction: Axis.vertical` for timelines and tracking screens.

**Variation**

<img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/v_icons.gif" width="320" alt="Vertical icons with titles beside" />

<details>
<summary><b>View example code</b> &nbsp;·&nbsp; 20 lines</summary>

```dart
EasyStepper(
  activeStep: activeStep,
  direction: Axis.vertical,
  showTitle: true,
  stepRadius: 26,
  finishedStepBackgroundColor: const Color(0xFF7C3AED),
  activeStepBackgroundColor: const Color(0xFF7C3AED),
  lineStyle: const LineStyle(
    lineType: LineType.dotted,
    unreachedLineType: LineType.dashed,
  ),
  steps: const [
    EasyStep(icon: Icon(Icons.shopping_cart), title: 'Order placed'),
    EasyStep(icon: Icon(Icons.verified), title: 'Confirmed'),
    EasyStep(icon: Icon(Icons.inventory_2), title: 'Preparing'),
    EasyStep(icon: Icon(Icons.local_shipping), title: 'Shipped'),
    EasyStep(icon: Icon(Icons.home), title: 'Delivered'),
  ],
  onStepReached: (index) => setState(() => activeStep = index),
)
```

</details>

#### Title placement

For vertical steppers you can control where each step title is rendered using `verticalTitlePlacement`:

* `VerticalTitlePlacement.side` *(default)* — title beside the icon (left/right depending on text direction and `placeTitleAtStart`).
* `VerticalTitlePlacement.belowIcon` — title below the icon.

When using `VerticalTitlePlacement.belowIcon`, add extra spacing around the connecting line via `LineStyle.verticalLinePadding`:

```dart
EasyStepper(
  direction: Axis.vertical,
  verticalTitlePlacement: VerticalTitlePlacement.belowIcon,
  lineStyle: const LineStyle(
    verticalLinePadding: EdgeInsets.symmetric(vertical: 8),
  ),
  // ...
)
```

#### Horizontal alignment

Use `verticalAlignment` to align the steps to the leading edge, center, or
trailing edge of a vertical stepper (defaults to centered):

```dart
EasyStepper(
  direction: Axis.vertical,
  verticalAlignment: CrossAxisAlignment.start, // .center (default) / .end
  // ...
)
```

---

### ⚪ Dots · top &amp; bottom titles

Minimal dots with titles alternating above and below the line — great for compact status bars.

**Variation**

<img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/dots_topbottom.gif" width="680" alt="Alternating top and bottom titles" />

<details>
<summary><b>View example code</b> &nbsp;·&nbsp; 31 lines</summary>

```dart
EasyStepper(
  activeStep: activeStep,
  stepRadius: 8,
  showStepBorder: false,
  showLoadingAnimation: false,
  titlesAreLargerThanSteps: true,
  lineStyle: const LineStyle(
    lineLength: 70,
    lineType: LineType.normal,
    finishedLineColor: Color(0xFF7C3AED),
  ),
  steps: [
    EasyStep(
      customStep: CircleAvatar(
        radius: 8,
        backgroundColor: activeStep >= 0 ? violet : grey,
      ),
      title: 'Waiting',
    ),
    EasyStep(
      customStep: CircleAvatar(
        radius: 8,
        backgroundColor: activeStep >= 1 ? violet : grey,
      ),
      title: 'Received',
      placeTitleAtStart: true,
    ),
    // ...remaining steps
  ],
  onStepReached: (index) => setState(() => activeStep = index),
)
```

</details>

---

### 🖼️ Custom image

Any widget can be a step via `customStep` — here, images make an onboarding flow.

**Variation**

<img src="https://raw.githubusercontent.com/ma7moud3osman/easy_stepper/main/doc/demos/h_image.gif" width="680" alt="Circular image steps" />

<details>
<summary><b>View example code</b> &nbsp;·&nbsp; 28 lines</summary>

```dart
EasyStepper(
  activeStep: activeStep,
  stepShape: StepShape.rRectangle,
  stepBorderRadius: 15,
  stepRadius: 28,
  borderThickness: 2,
  finishedStepBackgroundColor: const Color(0xFF7C3AED),
  activeStepIconColor: const Color(0xFF7C3AED),
  lineStyle: const LineStyle(
    lineLength: 50,
    lineType: LineType.normal,
    unreachedLineType: LineType.dashed,
  ),
  steps: [
    for (int i = 0; i < 5; i++)
      EasyStep(
        customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Opacity(
            opacity: activeStep >= i ? 1 : 0.3,
            child: Image.asset('assets/${i + 1}.png'),
          ),
        ),
        customTitle: Text('Dash ${i + 1}', textAlign: TextAlign.center),
      ),
  ],
  onStepReached: (index) => setState(() => activeStep = index),
)
```

</details>


## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/ma7moud3osman/easy_stepper/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/ma7moud3osman/easy_stepper/pulls).

<a href="https://github.com/ma7moud3osman/easy_stepper/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ma7moud3osman/easy_stepper" />
</a>

Made with [contrib.rocks](https://contrib.rocks).

## Connect with me

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ma7moud3osman)  [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ma7moud3osman/)  [![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/MaHmOuD_A_OsMaN) 


## Support

* Please __Like__ to __support__!

* [![Buy Me A Coffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/ma7moud3osman)

## Built with

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

![Love](https://ForTheBadge.com/images/badges/built-with-love.svg)
