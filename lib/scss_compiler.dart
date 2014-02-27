library scss_compiler;

import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:logging/logging.dart';

final String SUFFIX_AND_EXTENSION = '_gen.css';
final String STYLE_SCSS = 'style.scss';

Future _run(String executable, List<String> arguments, {String
    workingDirectory, bool throwException: true}) {
  if (arguments == null) {
    arguments = [];
  }
  return Process.run(executable, arguments, workingDirectory: workingDirectory);
}

class ScssCompiler {
  bool noPrint = false;
  Logger _log = new Logger('ScssCompiler');

  static sccFilenameToCssFilename(String src) => withoutExtension(src) +
      SUFFIX_AND_EXTENSION;

  Future compileScss(String src, [String dst]) {
    if (dst == null) {
      dst = sccFilenameToCssFilename(src);
    } else {
      new Directory(dirname(dst)).createSync(recursive: true);
    }
    if (Platform.isWindows) {
      // Look for ruby in the path
      String path = Platform.environment['PATH'];
      String rubyPath;
      path.split(';').forEach((String pathElement) {
        if (pathElement.toLowerCase().contains('ruby')) {
          rubyPath = pathElement;
        }
      });
      if (rubyPath == null) {
        throw 'ruby not installed - needed on windows';
      }
      return _run(join(rubyPath, "ruby"), [join(rubyPath, "sass"), src, dst]
          ).then((ProcessResult result) {
        var exitCode = result.exitCode;

        if (exitCode != 0) {
          String out = result.stdout.trim();
          String err = result.stderr.trim();

          if (!noPrint) {
            print(
                'exitCode:${exitCode}\nERR:\n$err\nOUT:\n$out\ncompiling $src to $dst');
          }
          throw new Exception(
              'exitCode:${exitCode}\nERR:\n$err\nOUT:\n$out\ncompiling $src to $dst');
        }
      });
    } else {
      return _run("sass", [src, dst]).then((ProcessResult result) {
        var exitCode = result.exitCode;

        if (exitCode != 0) {
          String out = result.stdout.trim();
          String err = result.stderr.trim();

          if (!noPrint) {
            print('exitCode:${exitCode}\nERR:\n$err\nOUT:\n$out');
          }
          throw new Exception(
              'exitCode:${exitCode}\nERR:\n$err\nOUT:\n$out\ncompiling $src to $dst');
        }
      });
    }
  }
}
