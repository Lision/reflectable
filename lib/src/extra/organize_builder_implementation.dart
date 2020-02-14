// Copyright (c) 2020, the MTFlutter Team - lixin79.

library reflectable.src.organize_builder_implementation;

import 'dart:io' as io;
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
    String proxySrcPath = path.join(proxyLibPath, 'src');
    io.Directory(proxySrcPath).createSync(recursive: true);

    // pubspec.yaml
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
