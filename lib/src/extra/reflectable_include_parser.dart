// Copyright (c) 2020, the MTFlutter Team - lixin79.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:path/path.dart' as Path show current;

class ReflectableIncludeParser {
  static Future<List<LibraryElement>> parseReflectableLibrary() async {
    List<LibraryElement> result = <LibraryElement>[];
    String projectPath = Path.current;
    List<String> includedPaths = <String>[
      "$projectPath/lib/reflectable.dart",
      "$projectPath/lib/capability.dart"
    ];
    AnalysisContextCollection collection =
        new AnalysisContextCollection(includedPaths: includedPaths);
    for (String path in includedPaths) {
      AnalysisContext context = collection.contextFor(path);
      AnalysisSession session = context.currentSession;
      UnitElementResult elementResult = await session.getUnitElement(path);
      result.add(elementResult.element.enclosingElement);
    }
    return result;
  }
}
