// Copyright (c) 2020, the MTFlutter Team - lixin79.

library reflectable.src.organize_builder_implementation;

import 'dart:io' as io;
import 'dart:async';
import 'package:yaml/yaml.dart' as yaml;
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
    String pubspecBaseName = 'pubspec.yaml';
    String inputFilePath = path.join(path.current, _inputId.path);
    List<String> inputFilePathSegments = path.split(inputFilePath);
    assert(inputFilePathSegments.contains(packageName));
    var temp = inputFilePathSegments.sublist(
        0, inputFilePathSegments.indexOf(packageName));
    String sourcePubspecPath =
        path.join(path.joinAll(temp), packageName, pubspecBaseName);
    String contents = io.File(sourcePubspecPath).readAsStringSync();
    contents = _convertToProxyPubspecContents(contents);
    String pubspecPath = path.join(proxyPackagePath, pubspecBaseName);
    if (io.File(pubspecPath).existsSync()) {
      io.File(pubspecPath).deleteSync(recursive: true);
    }
    io.File(pubspecPath).createSync(recursive: true);
    io.File(pubspecPath).writeAsStringSync(contents);
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

  String _convertToProxyPubspecContents(String contents) {
    var doc = yaml.loadYamlDocument(contents);
    assert(doc.contents.value is Map);
    Map map = Map.of(doc.contents.value);
    map['name'] = proxyPackageName;
    map['author'] = 'lision <lixin79@meituan.com>';
    map['homepage'] = 'http://mtflutter.sankuai.com';
    map['dependencies'] = Map.of(map['dependencies']);
    assert(map['version'] != null);
    map['dependencies']['$packageName'] = '${map['version']}';
    map['dev_dependencies'] = Map.of(map['dev_dependencies']);
    map['dev_dependencies']['$packageName'] = '${map['version']}';
    String result = _convertToYamlString(map, '');
    return result;
  }

  String _convertToYamlString(dynamic target, String curTab) {
    // 没找到合适的 yaml 生成库，官方就给了个解析库，简单怼个递归解析
    if (target is Map) {
      curTab = '$curTab  ';
      List<String> temp = <String>[];
      for (var item in target.keys) {
        assert(item is String);
        String itemString =
            '$curTab$item: ${_convertToYamlString(target[item], curTab)}';
        temp.add(itemString);
      }
      return '\n${temp.join('\n')}';
    }

    if (target is List) {
      curTab = '$curTab  ';
      List<String> temp = <String>[];
      for (var item in target) {
        String itemString = '$curTab- ${_convertToYamlString(item, curTab)}';
        temp.add(itemString);
      }
      return '\n${temp.join('\n')}';
    }

    if (target is String &&
        target.contains(new RegExp(r'[0-9]+.[0-9]+.[0-9]+'))) {
      if (!target.startsWith(new RegExp(r'[\^0-9]'))) {
        return '"$target"';
      }
    }

    return target.toString();
  }
}
