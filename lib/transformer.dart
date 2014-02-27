library tekartik_scss_transformer;

import 'dart:async';

import 'package:barback/barback.dart';
import 'package:path/path.dart';

import 'scss_compiler.dart';

class CompileScssTransformer extends Transformer with ScssCompiler {

  // A constructor named "asPlugin" is required. It can be empty, but
  // it must be present. It is how pub determines that you want this
  // class to be publicly available as a loadable transformer plugin.
  CompileScssTransformer.asPlugin();

  // Any markdown file with one of the following extensions is
  // converted to HTML.
  String get allowedExtensions => ".scss";

  Future apply(Transform transform) {
    //print(transform.primaryInput.id.path);
    // The extension of the output is changed to "xxxx_gen.css".
    AssetId inputId = transform.primaryInput.id;

    // For file starting with _ we build the file name style.scss in the same folder
    if (basename(inputId.path).startsWith('_')) {
      return compileScss(join(dirname(transform.primaryInput.id.path),
          STYLE_SCSS));
    } else {
      AssetId id = transform.primaryInput.id.changeExtension(
          SUFFIX_AND_EXTENSION);
      return compileScss(transform.primaryInput.id.path, id.path);
    }

  }
}
