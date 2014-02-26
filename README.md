scss-transfomer.dart
====================

Simple Dart Scss transformer.
Need local install of Sass compiler (through Ruby)

The transformer logic is the following:
* convert xxxx.scss file to xxxx.css
* file starting with _xxxx.scss are not compiled however the style.scss in the same directoy is when changed

## Usage

Add the following lines to your pubspec.yaml

```
dependencies:
  ...
  tekartik_scss_transformer:
    git: https://github.com/alextekartik/scss-transfomer.dart.git
  ...
transformers:
- tekartik_scss_transformer
```

## Requirements

Sass compiler must be installed, follow the instructions here http://sass-lang.com/install which are Ruby based

### Ubuntu install

follow instructions here http://sass-lang.com/install

(as of 2014-02-26 - Ubuntu 13.10)

```sh
sudo apt-get install ruby1.9.1
sudo gem install sass
```

### Windows install

follow instructions here http://sass-lang.com/install

```sh
gem install sass
```

Make sure Ruby is added to the PATH variable and restart Darteditor after installation

### Mac install

follow instructions here http://sass-lang.com/install

```sh
sudo gem install sass
```