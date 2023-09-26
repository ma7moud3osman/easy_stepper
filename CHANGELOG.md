## 0.8.0

### Tuesday,  26th Sept, 2023

* feat: Support Different line type for reached & unreached steps. Thanks to [ARASHz4](https://github.com/ma7moud3osman/easy_stepper/issues/27) 
* feat: Add Line `progress` & `progressColor` for `LineStyle`. Thanks to [lx8s8](https://github.com/ma7moud3osman/easy_stepper/issues/28) 
* feat: `LineType` now support new `dashed` type, you can access it via `LineType.dashed`.
* __Breaking Change:__ 
    All properties related to the line style moved to `LineStyle` class.
        [`lineType`
        , `defaultLineColor`
        , `unreachedLineColor`
        , `activeLineColor`
        , `finishedLineColor`
        , `lineLength`
        , `lineWidth`
        , `lineThickness`
        , `lineSpace`
        , `unreachedLineType`].
* Update example app.
* Update CHANGELOG.

## 0.7.3

### Saturday,  22th Jul, 2023

* [Specific reached steps] With this change, the user could disable certain steps in the stepper. Thanks to [thfr69](https://github.com/ma7moud3osman/easy_stepper/pull/24) 
* Update example with external navigation (forward and back button) in the main.dart file.

## 0.7.2

### Monday,  19th Jun, 2023

* Minor fix.  

## 0.7.1

### Monday,  19th Jun, 2023

* Fix minor bugs in Stepper Scrolling.  


## 0.7.0

### Sunday,  18th Jun, 2023

* Add `showScrollbar` to `easy_stepper` to Show or Hide `Scrollbar` in Web or Desktop.  
Thanks to [Francesco Bussolino](https://github.com/ma7moud3osman/easy_stepper/issues/23)
* Remove blank space when showTitle is false during vertical direction . Thanks to [Martin Jablečník](https://github.com/ma7moud3osman/easy_stepper/pull/22) 
* Update Example App
* Update README.md

## 0.6.0

### Friday,  26th May, 2023

* Add `fitWidth` to `easy_stepper` to fill the full width of the screen when the `disableScroll = true`.  
Thanks to [Maclaon](https://github.com/ma7moud3osman/easy_stepper/issues/18) & [Seamoon Pandey](https://github.com/ma7moud3osman/easy_stepper/issues/20)
* Fix large title not showing correctly in the vertical stepper . Thanks to [Basem Osama](https://github.com/ma7moud3osman/easy_stepper/issues/19) 
* Remove unnecessary `export` of `flutter/material.dart` from the package. Thanks to [ryanc16](https://github.com/ma7moud3osman/easy_stepper/issues/21) 
* Update README.md

## 0.5.2+1

### Thursday,  4th May, 2023

* Update README.md

## 0.5.2

### Thursday,  4th May, 2023

* Add `maxReachedStep` & `isAlreadyReached` to the Stepper in order to navigate only between already reached steps by step tapping. Thanks to [
Thorsten Fritzsche](https://github.com/ma7moud3osman/easy_stepper/pull/16)
* Add `lineThickness` instead of `lineDotRadius` (Deprecated).
* Update Example App 

## 0.5.1

### Sunday,  30th April, 2023

* Added `enabled` property for `EasyStep` to enable/disable specific step despite `steppingEnabled = true`. Thanks to [thfr69](https://github.com/ma7moud3osman/easy_stepper/issues/12) 
* Update Example App
* Update README.md

## 0.5.0

### Tuesday,  4th April, 2023

* __Breaking Change:__ `lineColor` replaced by `defaultLineColor`, 
    and now you can add more customization for line colors `unreachedLineColor`, `activeLineColor` & `finishedLineColor`.
    Thanks to [adar2378](https://github.com/ma7moud3osman/easy_stepper/pull/8) 
* Added `topTitle` property to setting the title above or below the step icon. Thanks to [AbdulazizAlnahhas](https://github.com/ma7moud3osman/easy_stepper/issues/9) 
* Fix minor bugs.
* Update Example App
* Update README.md

## 0.4.0

### Friday, 24th March, 2023

* Adding `customStep`, `customTitle` & `customLineWidget` : Now you can create your own step widget with all customizations . Thanks to [darshanjain64](https://github.com/ma7moud3osman/easy_stepper/pull/7) 
* Update Example App
* Update README.md


## 0.3.2

### Friday, 17th February, 2023

* Adding `showLoadingAnimation` : show or hide the loading animation inside the step . Thanks to [OmarYehiaDev](https://github.com/ma7moud3osman/easy_stepper/pull/6) 

## 0.3.1

### Friday, 27th January, 2023

* Added options to customize step border type for different states.
* Show or hide the step border. Thanks to [Seth-Pharès Gnavo](https://github.com/ma7moud3osman/easy_stepper/issues/3)

## 0.3.0

### Saturday, 31th December, 2022

* Add New Rect & RRect Shapes To Stepper.
* Now We Can Control The line padding.
* Update example App.
* Fix Minor Bugs.
* Update README.md file.

## 0.2.1

### Saturday, 24th December, 2022

* Upgrade to lottie 2.1.0
* Update example
* Match the dart formatter
* Update README.md file

## 0.2.0

### Friday, 23th December, 2022

* Add loading animation to customize the loading animation icon from lottie package.
* Update stepper default colors to match theme colors.
* Fix normal line with large width bug.
* Add active border width.
* Update example app with new steppers.
* Change the minimum Dart-Sdk Version from v.2.17.5 to v.2.16.0.

## 0.1.4+1

### Tuesday, 6th December, 2022

* Match the Dart formatter.

## 0.1.4

### Tuesday, 6th December, 2022

* Fix: Unable to load asset.

## 0.1.3

### Tuesday, 6th December, 2022

* Fix: Active Step radius

## 0.1.2

### Monday, 5th December, 2022

* Fix: Fix Normal line bug.

## 0.1.1

### Sunday, 4th December, 2022

* Feature: Add text for step line.
* Feature: Add line types [Normal , Dotted].
* Feature: Add Active & Finished Icons.
* Remove dotted_border Package.


## 0.1.0

### Sunday, 4th December, 2022

* Minor Fixes.

## 0.0.2+2

### Sunday, 4th December, 2022

* Minor Fixes.

## 0.0.1+1

### Sunday, 4th December, 2022

* Initial release.

* Added IconStepper.