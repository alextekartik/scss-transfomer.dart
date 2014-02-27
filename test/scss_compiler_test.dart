library scss_compiler_test;

import 'package:unittest/vm_config.dart';
import 'package:unittest/unittest.dart';
import 'dart:io';
import 'package:tekartik_scss_transformer/scss_compiler.dart';

void _deleteFile(File file) {
  if (file.existsSync()) {
    file.deleteSync();
  }
  ;
}

main() {
  useVMConfiguration();
  // xxx.main();
  ScssCompiler compiler = new ScssCompiler();

  test('filename generation', () {
    expect(ScssCompiler.sccFilenameToCssFilename('path/test.scss'),
        'path/test_gen.css');
  });

  test('ok test file', () {
    String inputFilename = 'data/test_ok.scss';
    File outFile = new File(ScssCompiler.sccFilenameToCssFilename(inputFilename)
        );
    _deleteFile(outFile);
    expect(outFile.existsSync(), isFalse);
    return compiler.compileScss(inputFilename).then((_) {
      expect(outFile.existsSync(), isTrue);
    });
  });

  test('file not found file', () {
    String inputFilename = 'file_not_found';
    File outFile = new File(ScssCompiler.sccFilenameToCssFilename(inputFilename)
        );
    _deleteFile(outFile);
    expect(outFile.existsSync(), isFalse);
    compiler.noPrint = true;
    return compiler.compileScss(inputFilename).then((_) {
      fail("nope");

    }).catchError((e) {
      expect(outFile.existsSync(), isFalse);
    });
  });
  test('bad file', () {
    String inputFilename = 'data/test_bad_scss.txt';
    File outFile = new File(ScssCompiler.sccFilenameToCssFilename(inputFilename)
        );
    _deleteFile(outFile);
    expect(outFile.existsSync(), isFalse);
    compiler.noPrint = true;
    return compiler.compileScss(inputFilename).then((_) {
      fail("nope");

    }).catchError((e) {
      expect(outFile.existsSync(), isFalse);
    });
  });

}
