// Copyright (c) 2020, the MTFlutter Team.

library reflectable.organize_builder;

import 'dart:async';
import 'package:build/build.dart';
import 'package:reflectable/src/extra/organize_builder_implementation.dart';

class OrganizeBuilder implements Builder {
  String _packageName;

  BuilderOptions builderOptions;

  OrganizeBuilder(this.builderOptions);

  @override
  Future<void> build(BuildStep buildStep) async {
    var inputId = buildStep.inputId;
    var implementation = OrganizeBuilderImplementation(inputId);
    if (_packageName == null) {
      _packageName = implementation.packageName;
      implementation.organizeProxyPackage();
    }
    assert(_packageName == implementation.packageName);
    await implementation.organizeProxyFile();
  }

  Map<String, List<String>> get buildExtensions => const {
        '_proxy.dart': ['_mirror.dart']
      };
}

OrganizeBuilder organizeBuilder(BuilderOptions options) {
  var config = Map<String, Object>.from(options.config);
  config.putIfAbsent('entry_points', () => ['**_proxy.dart']);
  return OrganizeBuilder(options);
}
