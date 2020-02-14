// Copyright (c) 2020, the MTFlutter Team - lixin79.

library reflectable.src.organize_builder_implementation;

import 'dart:io' as io;
import 'dart:async';
import 'dart:convert';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;
import 'package:build/build.dart';

class OrganizeBuilderImplementation {
  OrganizeBuilderImplementation(this._inputId);

  void organizeProxyPackage() {
    // output
    String currentPath = path.current;
    String outputPath = path.join(currentPath, 'output');
    if (io.Directory(outputPath).existsSync()) {
      io.Directory(outputPath).deleteSync(recursive: true);
    }
    io.Directory(outputPath).createSync(recursive: true);

    // package
    String proxyPackagePath = path.join(outputPath, proxyPackageName);
    io.Directory(proxyPackageName).createSync(recursive: true);
    String proxyLibPath = path.join(proxyPackagePath, 'lib');
    io.Directory(proxyLibPath).createSync(recursive: true);

    // pubspec.yaml
  }

  Future<void> organizeProxyFile() async {
    // 得益于 proxy 文件在前面被一波搞定了，这里不用分析和修改文件内容
    String inputFilePath = path.join(path.current, _inputId.path);
    String contents = await io.File(inputFilePath).readAsString();
    List<String> inputFilePathSegments = path.split(inputFilePath);
    assert(inputFilePathSegments.contains(packageName));
    assert(inputFilePathSegments.last != packageName);
    var temp = inputFilePathSegments
        .sublist(inputFilePathSegments.indexOf(packageName) + 1);
    String tempPath = path.joinAll(temp);
    String outputFilePath =
        path.join(path.current, 'output', proxyPackageName, tempPath);
    if (await io.File(outputFilePath).exists()) {
      await io.File(outputFilePath).delete(recursive: true);
    }
    await io.File(outputFilePath).create(recursive: true);
    await io.File(outputFilePath).writeAsString(contents);
  }

  final AssetId _inputId;

  // source package name
  String _packageName;
  String get packageName {
    if (_packageName == null) {
      List<String> temp = path.split(_inputId.uri.path);
      assert(temp.contains('lib'));
      assert(temp.indexOf('lib') > 0);
      _packageName = temp[temp.indexOf('lib') - 1];
    }
    return _packageName;
  }

  // proxy package name
  String _proxyPackageName;
  String get proxyPackageName {
    if (_proxyPackageName == null) {
      _proxyPackageName = '${packageName}_proxy';
    }
    return _proxyPackageName;
  }
}
