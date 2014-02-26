scss-transfomer.dart
====================

Simple Dart Scss transformer
Need local install of Scss compiler.

The logic is the following:
* convert xxxx.scss file to xxxx.css
* file starting with _xxxx.scss are not compiled however the style.scss in the same directoy is when changed

=== Ubuntu install ===

as of 2014-02-26

    sudo apt-get install ruby1.9.1
    sudo gem install sass
