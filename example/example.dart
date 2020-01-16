// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Tests some basic functionality of instance mirrors and class mirrors.

library test_reflectable.test.basic_test;

import 'package:reflectable/reflectable.dart' as r;
import 'package:reflectable/capability.dart';

class MyReflectable extends r.Reflectable {
  const MyReflectable()
      : super(
          instanceInvokeCapability,
          newInstanceCapability,
          declarationsCapability,
        );
}

// @MyReflectable()
// class Text extends StatelessWidget {
//   /// Creates a text widget.
//   ///
//   /// If the [style] argument is null, the text will use the style from the
//   /// closest enclosing [DefaultTextStyle].
//   ///
//   /// The [data] parameter must not be null.
//   const Text(
//     this.data, {
//     Key key,
//     this.style,
//     this.strutStyle,
//     this.textAlign,
//     this.textDirection,
//     this.locale,
//     this.softWrap,
//     this.overflow,
//     this.textScaleFactor,
//     this.maxLines,
//     this.semanticsLabel,
//   })  : assert(
//           data != null,
//           'A non-null String must be provided to a Text widget.',
//         ),
//         textSpan = null,
//         super(key: key);

//   /// Creates a text widget with a [TextSpan].
//   ///
//   /// The [textSpan] parameter must not be null.
//   const Text.rich(
//     this.textSpan, {
//     Key key,
//     this.style,
//     this.strutStyle,
//     this.textAlign,
//     this.textDirection,
//     this.locale,
//     this.softWrap,
//     this.overflow,
//     this.textScaleFactor,
//     this.maxLines,
//     this.semanticsLabel,
//   })  : assert(
//           textSpan != null,
//           'A non-null TextSpan must be provided to a Text.rich widget.',
//         ),
//         data = null,
//         super(key: key);

//   /// The text to display.
//   ///
//   /// This will be null if a [textSpan] is provided instead.
//   final String data;

//   /// The text to display as a [TextSpan].
//   ///
//   /// This will be null if [data] is provided instead.
//   final TextSpan textSpan;

//   /// If non-null, the style to use for this text.
//   ///
//   /// If the style's "inherit" property is true, the style will be merged with
//   /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
//   /// replace the closest enclosing [DefaultTextStyle].
//   final TextStyle style;

//   /// {@macro flutter.painting.textPainter.strutStyle}
//   final StrutStyle strutStyle;

//   /// How the text should be aligned horizontally.
//   final TextAlign textAlign;

//   /// The directionality of the text.
//   ///
//   /// This decides how [textAlign] values like [TextAlign.start] and
//   /// [TextAlign.end] are interpreted.
//   ///
//   /// This is also used to disambiguate how to render bidirectional text. For
//   /// example, if the [data] is an English phrase followed by a Hebrew phrase,
//   /// in a [TextDirection.ltr] context the English phrase will be on the left
//   /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
//   /// context, the English phrase will be on the right and the Hebrew phrase on
//   /// its left.
//   ///
//   /// Defaults to the ambient [Directionality], if any.
//   final TextDirection textDirection;

//   /// Used to select a font when the same Unicode character can
//   /// be rendered differently, depending on the locale.
//   ///
//   /// It's rarely necessary to set this property. By default its value
//   /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
//   ///
//   /// See [RenderParagraph.locale] for more information.
//   final Locale locale;

//   /// Whether the text should break at soft line breaks.
//   ///
//   /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
//   final bool softWrap;

//   /// How visual overflow should be handled.
//   final TextOverflow overflow;

//   /// The number of font pixels for each logical pixel.
//   ///
//   /// For example, if the text scale factor is 1.5, text will be 50% larger than
//   /// the specified font size.
//   ///
//   /// The value given to the constructor as textScaleFactor. If null, will
//   /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
//   /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
//   final double textScaleFactor;

//   /// An optional maximum number of lines for the text to span, wrapping if necessary.
//   /// If the text exceeds the given number of lines, it will be truncated according
//   /// to [overflow].
//   ///
//   /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
//   /// edge of the box.
//   ///
//   /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
//   /// an explicit number for its [DefaultTextStyle.maxLines], then the
//   /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
//   /// widget directly to entirely override the [DefaultTextStyle].
//   final int maxLines;

//   /// An alternative semantics label for this text.
//   ///
//   /// If present, the semantics of this widget will contain this value instead
//   /// of the actual text. This will overwrite any of the semantics labels applied
//   /// directly to the [TextSpan]s.
//   ///
//   /// This is useful for replacing abbreviations or shorthands with the full
//   /// text value:
//   ///
//   /// ```dart
//   /// Text(r'$$', semanticsLabel: 'Double dollars')
//   /// ```
//   final String semanticsLabel;

//   @override
//   Widget build(BuildContext context) {
//     final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
//     TextStyle effectiveTextStyle = style;
//     if (style == null || style.inherit)
//       effectiveTextStyle = defaultTextStyle.style.merge(style);
//     if (MediaQuery.boldTextOverride(context))
//       effectiveTextStyle = effectiveTextStyle
//           .merge(const TextStyle(fontWeight: FontWeight.bold));
//     Widget result = RichText(
//       textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
//       textDirection:
//           textDirection, // RichText uses Directionality.of to obtain a default if this is null.
//       locale:
//           locale, // RichText uses Localizations.localeOf to obtain a default if this is null
//       softWrap: softWrap ?? defaultTextStyle.softWrap,
//       overflow: overflow ?? defaultTextStyle.overflow,
//       textScaleFactor: textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
//       maxLines: maxLines ?? defaultTextStyle.maxLines,
//       strutStyle: strutStyle,
//       text: TextSpan(
//         style: effectiveTextStyle,
//         text: data,
//         children: textSpan != null ? <TextSpan>[textSpan] : null,
//       ),
//     );
//     if (semanticsLabel != null) {
//       result = Semantics(
//         textDirection: textDirection,
//         label: semanticsLabel,
//         child: ExcludeSemantics(
//           child: result,
//         ),
//       );
//     }
//     return result;
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(StringProperty('data', data, showName: false));
//     if (textSpan != null) {
//       properties.add(textSpan.toDiagnosticsNode(
//           name: 'textSpan', style: DiagnosticsTreeStyle.transition));
//     }
//     style?.debugFillProperties(properties);
//     properties.add(
//         EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: null));
//     properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
//         defaultValue: null));
//     properties
//         .add(DiagnosticsProperty<Locale>('locale', locale, defaultValue: null));
//     properties.add(FlagProperty('softWrap',
//         value: softWrap,
//         ifTrue: 'wrapping at box width',
//         ifFalse: 'no wrapping except at line break characters',
//         showName: true));
//     properties.add(
//         EnumProperty<TextOverflow>('overflow', overflow, defaultValue: null));
//     properties.add(
//         DoubleProperty('textScaleFactor', textScaleFactor, defaultValue: null));
//     properties.add(IntProperty('maxLines', maxLines, defaultValue: null));
//     if (semanticsLabel != null) {
//       properties.add(StringProperty('semanticsLabel', semanticsLabel));
//     }
//   }
// }

// @MyReflectable()
// class Opacity extends SingleChildRenderObjectWidget {
//   /// Creates a widget that makes its child partially transparent.
//   ///
//   /// The [opacity] argument must not be null and must be between 0.0 and 1.0
//   /// (inclusive).
//   const Opacity({
//     Key key,
//     @required this.opacity,
//     this.alwaysIncludeSemantics = false,
//     Widget child,
//   })  : assert(opacity != null && opacity >= 0.0 && opacity <= 1.0),
//         assert(alwaysIncludeSemantics != null),
//         super(key: key, child: child);

//   /// The fraction to scale the child's alpha value.
//   ///
//   /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
//   /// (i.e., invisible).
//   ///
//   /// The opacity must not be null.
//   ///
//   /// Values 1.0 and 0.0 are painted with a fast path. Other values
//   /// require painting the child into an intermediate buffer, which is
//   /// expensive.
//   final double opacity;

//   /// Whether the semantic information of the children is always included.
//   ///
//   /// Defaults to false.
//   ///
//   /// When true, regardless of the opacity settings the child semantic
//   /// information is exposed as if the widget were fully visible. This is
//   /// useful in cases where labels may be hidden during animations that
//   /// would otherwise contribute relevant semantics.
//   final bool alwaysIncludeSemantics;

//   @override
//   RenderOpacity createRenderObject(BuildContext context) {
//     return RenderOpacity(
//       opacity: opacity,
//       alwaysIncludeSemantics: alwaysIncludeSemantics,
//     );
//   }

//   @override
//   void updateRenderObject(BuildContext context, RenderOpacity renderObject) {
//     renderObject
//       ..opacity = opacity
//       ..alwaysIncludeSemantics = alwaysIncludeSemantics;
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(DoubleProperty('opacity', opacity));
//     properties.add(FlagProperty('alwaysIncludeSemantics',
//         value: alwaysIncludeSemantics, ifTrue: 'alwaysIncludeSemantics'));
//   }
// }

// @MyReflectable()
// class ClipRect extends SingleChildRenderObjectWidget {
//   /// Creates a rectangular clip.
//   ///
//   /// If [clipper] is null, the clip will match the layout size and position of
//   /// the child.
//   const ClipRect(
//       {Key key, this.clipper, this.clipBehavior = Clip.hardEdge, Widget child})
//       : super(key: key, child: child);

//   /// If non-null, determines which clip to use.
//   final CustomClipper<Rect> clipper;

//   /// {@macro flutter.clipper.clipBehavior}
//   final Clip clipBehavior;

//   @override
//   RenderClipRect createRenderObject(BuildContext context) =>
//       RenderClipRect(clipper: clipper, clipBehavior: clipBehavior);

//   @override
//   void updateRenderObject(BuildContext context, RenderClipRect renderObject) {
//     renderObject.clipper = clipper;
//   }

//   @override
//   void didUnmountRenderObject(RenderClipRect renderObject) {
//     renderObject.clipper = null;
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(DiagnosticsProperty<CustomClipper<Rect>>('clipper', clipper,
//         defaultValue: null));
//   }
// }

// @MyReflectable()
// class Transform extends SingleChildRenderObjectWidget {
//   /// Creates a widget that transforms its child.
//   ///
//   /// The [transform] argument must not be null.
//   const Transform({
//     Key key,
//     @required this.transform,
//     this.origin,
//     this.alignment,
//     this.transformHitTests = true,
//     Widget child,
//   })  : assert(transform != null),
//         super(key: key, child: child);

//   /// Creates a widget that transforms its child using a rotation around the
//   /// center.
//   ///
//   /// The `angle` argument must not be null. It gives the rotation in clockwise
//   /// radians.
//   ///
//   /// {@tool sample}
//   ///
//   /// This example rotates an orange box containing text around its center by
//   /// fifteen degrees.
//   ///
//   /// ```dart
//   /// Transform.rotate(
//   ///   angle: -math.pi / 12.0,
//   ///   child: Container(
//   ///     padding: const EdgeInsets.all(8.0),
//   ///     color: const Color(0xFFE8581C),
//   ///     child: const Text('Apartment for rent!'),
//   ///   ),
//   /// )
//   /// ```
//   /// {@end-tool}
//   Transform.rotate({
//     Key key,
//     @required double angle,
//     this.origin,
//     this.alignment = Alignment.center,
//     this.transformHitTests = true,
//     Widget child,
//   })  : transform = Matrix4.rotationZ(angle),
//         super(key: key, child: child);

//   /// Creates a widget that transforms its child using a translation.
//   ///
//   /// The `offset` argument must not be null. It specifies the translation.
//   ///
//   /// {@tool sample}
//   ///
//   /// This example shifts the silver-colored child down by fifteen pixels.
//   ///
//   /// ```dart
//   /// Transform.translate(
//   ///   offset: const Offset(0.0, 15.0),
//   ///   child: Container(
//   ///     padding: const EdgeInsets.all(8.0),
//   ///     color: const Color(0xFF7F7F7F),
//   ///     child: const Text('Quarter'),
//   ///   ),
//   /// )
//   /// ```
//   /// {@end-tool}
//   Transform.translate({
//     Key key,
//     @required Offset offset,
//     this.transformHitTests = true,
//     Widget child,
//   })  : transform = Matrix4.translationValues(offset.dx, offset.dy, 0.0),
//         origin = null,
//         alignment = null,
//         super(key: key, child: child);

//   /// Creates a widget that scales its child uniformly.
//   ///
//   /// The `scale` argument must not be null. It gives the scalar by which
//   /// to multiply the `x` and `y` axes.
//   ///
//   /// The [alignment] controls the origin of the scale; by default, this is
//   /// the center of the box.
//   ///
//   /// {@tool sample}
//   ///
//   /// This example shrinks an orange box containing text such that each dimension
//   /// is half the size it would otherwise be.
//   ///
//   /// ```dart
//   /// Transform.scale(
//   ///   scale: 0.5,
//   ///   child: Container(
//   ///     padding: const EdgeInsets.all(8.0),
//   ///     color: const Color(0xFFE8581C),
//   ///     child: const Text('Bad Ideas'),
//   ///   ),
//   /// )
//   /// ```
//   /// {@end-tool}
//   Transform.scale({
//     Key key,
//     @required double scale,
//     this.origin,
//     this.alignment = Alignment.center,
//     this.transformHitTests = true,
//     Widget child,
//   })  : transform = Matrix4.diagonal3Values(scale, scale, 1.0),
//         super(key: key, child: child);

//   /// The matrix to transform the child by during painting.
//   final Matrix4 transform;

//   /// The origin of the coordinate system (relative to the upper left corder of
//   /// this render object) in which to apply the matrix.
//   ///
//   /// Setting an origin is equivalent to conjugating the transform matrix by a
//   /// translation. This property is provided just for convenience.
//   final Offset origin;

//   /// The alignment of the origin, relative to the size of the box.
//   ///
//   /// This is equivalent to setting an origin based on the size of the box.
//   /// If it is specified at the same time as the [origin], both are applied.
//   ///
//   /// An [AlignmentDirectional.start] value is the same as an [Alignment]
//   /// whose [Alignment.x] value is `-1.0` if [textDirection] is
//   /// [TextDirection.ltr], and `1.0` if [textDirection] is [TextDirection.rtl].
//   /// Similarly [AlignmentDirectional.end] is the same as an [Alignment]
//   /// whose [Alignment.x] value is `1.0` if [textDirection] is
//   /// [TextDirection.ltr], and `-1.0` if [textDirection] is [TextDirection.rtl].
//   final AlignmentGeometry alignment;

//   /// Whether to apply the transformation when performing hit tests.
//   final bool transformHitTests;

//   @override
//   RenderTransform createRenderObject(BuildContext context) {
//     return RenderTransform(
//       transform: transform,
//       origin: origin,
//       alignment: alignment,
//       textDirection: Directionality.of(context),
//       transformHitTests: transformHitTests,
//     );
//   }

//   @override
//   void updateRenderObject(BuildContext context, RenderTransform renderObject) {
//     renderObject
//       ..transform = transform
//       ..origin = origin
//       ..alignment = alignment
//       ..textDirection = Directionality.of(context)
//       ..transformHitTests = transformHitTests;
//   }
// }

// @MyReflectable()
// class LimitedBox extends SingleChildRenderObjectWidget {
//   /// Creates a box that limits its size only when it's unconstrained.
//   ///
//   /// The [maxWidth] and [maxHeight] arguments must not be null and must not be
//   /// negative.
//   const LimitedBox({
//     Key key,
//     this.maxWidth = double.infinity,
//     this.maxHeight = double.infinity,
//     Widget child,
//   })  : assert(maxWidth != null && maxWidth >= 0.0),
//         assert(maxHeight != null && maxHeight >= 0.0),
//         super(key: key, child: child);

//   /// The maximum width limit to apply in the absence of a
//   /// [BoxConstraints.maxWidth] constraint.
//   final double maxWidth;

//   /// The maximum height limit to apply in the absence of a
//   /// [BoxConstraints.maxHeight] constraint.
//   final double maxHeight;

//   @override
//   RenderLimitedBox createRenderObject(BuildContext context) {
//     return RenderLimitedBox(
//       maxWidth: maxWidth,
//       maxHeight: maxHeight,
//     );
//   }

//   @override
//   void updateRenderObject(BuildContext context, RenderLimitedBox renderObject) {
//     renderObject
//       ..maxWidth = maxWidth
//       ..maxHeight = maxHeight;
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//         DoubleProperty('maxWidth', maxWidth, defaultValue: double.infinity));
//     properties.add(
//         DoubleProperty('maxHeight', maxHeight, defaultValue: double.infinity));
//   }
// }

// @MyReflectable()
// class Stack extends MultiChildRenderObjectWidget {
//   /// Creates a stack layout widget.
//   ///
//   /// By default, the non-positioned children of the stack are aligned by their
//   /// top left corners.
//   Stack({
//     Key key,
//     this.alignment = AlignmentDirectional.topStart,
//     this.textDirection,
//     this.fit = StackFit.loose,
//     this.overflow = Overflow.clip,
//     List<Widget> children = const <Widget>[],
//   }) : super(key: key, children: children);

//   /// How to align the non-positioned and partially-positioned children in the
//   /// stack.
//   ///
//   /// The non-positioned children are placed relative to each other such that
//   /// the points determined by [alignment] are co-located. For example, if the
//   /// [alignment] is [Alignment.topLeft], then the top left corner of
//   /// each non-positioned child will be located at the same global coordinate.
//   ///
//   /// Partially-positioned children, those that do not specify an alignment in a
//   /// particular axis (e.g. that have neither `top` nor `bottom` set), use the
//   /// alignment to determine how they should be positioned in that
//   /// under-specified axis.
//   ///
//   /// Defaults to [AlignmentDirectional.topStart].
//   ///
//   /// See also:
//   ///
//   ///  * [Alignment], a class with convenient constants typically used to
//   ///    specify an [AlignmentGeometry].
//   ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
//   ///    relative to text direction.
//   final AlignmentGeometry alignment;

//   /// The text direction with which to resolve [alignment].
//   ///
//   /// Defaults to the ambient [Directionality].
//   final TextDirection textDirection;

//   /// How to size the non-positioned children in the stack.
//   ///
//   /// The constraints passed into the [Stack] from its parent are either
//   /// loosened ([StackFit.loose]) or tightened to their biggest size
//   /// ([StackFit.expand]).
//   final StackFit fit;

//   /// Whether overflowing children should be clipped. See [Overflow].
//   ///
//   /// Some children in a stack might overflow its box. When this flag is set to
//   /// [Overflow.clip], children cannot paint outside of the stack's box.
//   final Overflow overflow;

//   @override
//   RenderStack createRenderObject(BuildContext context) {
//     return RenderStack(
//       alignment: alignment,
//       textDirection: textDirection ?? Directionality.of(context),
//       fit: fit,
//       overflow: overflow,
//     );
//   }

//   @override
//   void updateRenderObject(BuildContext context, RenderStack renderObject) {
//     renderObject
//       ..alignment = alignment
//       ..textDirection = textDirection ?? Directionality.of(context)
//       ..fit = fit
//       ..overflow = overflow;
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties
//         .add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
//     properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
//         defaultValue: null));
//     properties.add(EnumProperty<StackFit>('fit', fit));
//     properties.add(EnumProperty<Overflow>('overflow', overflow));
//   }
// }

@MyReflectable()
class MaterialApp extends StatefulWidget {
  /// Creates a MaterialApp.
  ///
  /// At least one of [home], [routes], [onGenerateRoute], or [builder] must be
  /// non-null. If only [routes] is given, it must include an entry for the
  /// [Navigator.defaultRouteName] (`/`), since that is the route used when the
  /// application is launched with an intent that specifies an otherwise
  /// unsupported route.
  ///
  /// This class creates an instance of [WidgetsApp].
  ///
  /// The boolean arguments, [routes], and [navigatorObservers], must not be null.
  const MaterialApp({
    Key key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        super(key: key);

  /// {@macro flutter.widgets.widgetsApp.navigatorKey}
  final GlobalKey<NavigatorState> navigatorKey;

  /// {@macro flutter.widgets.widgetsApp.home}
  final Widget home;

  /// The application's top-level routing table.
  ///
  /// When a named route is pushed with [Navigator.pushNamed], the route name is
  /// looked up in this map. If the name is present, the associated
  /// [WidgetBuilder] is used to construct a [MaterialPageRoute] that performs
  /// an appropriate transition, including [Hero] animations, to the new route.
  ///
  /// {@macro flutter.widgets.widgetsApp.routes}
  final Map<String, WidgetBuilder> routes;

  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String initialRoute;

  /// {@macro flutter.widgets.widgetsApp.onGenerateRoute}
  final RouteFactory onGenerateRoute;

  /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
  final RouteFactory onUnknownRoute;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver> navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.builder}
  ///
  /// Material specific features such as [showDialog] and [showMenu], and widgets
  /// such as [Tooltip], [PopupMenuButton], also require a [Navigator] to properly
  /// function.
  final TransitionBuilder builder;

  /// {@macro flutter.widgets.widgetsApp.title}
  ///
  /// This value is passed unmodified to [WidgetsApp.title].
  final String title;

  /// {@macro flutter.widgets.widgetsApp.onGenerateTitle}
  ///
  /// This value is passed unmodified to [WidgetsApp.onGenerateTitle].
  final GenerateAppTitle onGenerateTitle;

  /// Default visual properties, like colors fonts and shapes, for this app's
  /// material widgets.
  ///
  /// A second [darkTheme] [ThemeData] value, which is used when the underlying
  /// platform requests a "dark mode" UI, can also be specified.
  ///
  /// The default value of this property is the value of [ThemeData.light()].
  ///
  /// See also:
  ///
  ///  * [MediaQueryData.platformBrightness], which indicates the platform's
  ///    desired brightness and is used to automatically toggle between [theme]
  ///    and [darkTheme] in [MaterialApp].
  ///  * [ThemeData.brightness], which indicates the [Brightness] of a theme's
  ///    colors.
  final ThemeData theme;

  /// The [ThemeData] to use when the platform specifically requests a dark
  /// themed UI.
  ///
  /// Host platforms such as Android Pie can request a system-wide "dark mode"
  /// when entering battery saver mode.
  ///
  /// When the host platform requests a [Brightness.dark] mode, you may want to
  /// supply a [ThemeData.brightness] that's also [Brightness.dark].
  ///
  /// Uses [theme] instead when null. Defaults to the value of
  /// [ThemeData.light()] when both [darkTheme] and [theme] are null.
  ///
  /// See also:
  ///
  ///  * [MediaQueryData.platformBrightness], which indicates the platform's
  ///    desired brightness and is used to automatically toggle between [theme]
  ///    and [darkTheme] in [MaterialApp].
  ///  * [ThemeData.brightness], which is typically set to the value of
  ///    [MediaQueryData.platformBrightness].
  final ThemeData darkTheme;

  /// {@macro flutter.widgets.widgetsApp.color}
  final Color color;

  /// {@macro flutter.widgets.widgetsApp.locale}
  final Locale locale;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  ///
  /// Internationalized apps that require translations for one of the locales
  /// listed in [GlobalMaterialLocalizations] should specify this parameter
  /// and list the [supportedLocales] that the application can handle.
  ///
  /// ```dart
  /// import 'package:flutter_localizations/flutter_localizations.dart';
  /// MaterialApp(
  ///   localizationsDelegates: [
  ///     // ... app-specific localization delegate[s] here
  ///     GlobalMaterialLocalizations.delegate,
  ///     GlobalWidgetsLocalizations.delegate,
  ///   ],
  ///   supportedLocales: [
  ///     const Locale('en', 'US'), // English
  ///     const Locale('he', 'IL'), // Hebrew
  ///     // ... other locales the app supports
  ///   ],
  ///   // ...
  /// )
  /// ```
  ///
  /// ## Adding localizations for a new locale
  ///
  /// The information that follows applies to the unusual case of an app
  /// adding translations for a language not already supported by
  /// [GlobalMaterialLocalizations].
  ///
  /// Delegates that produce [WidgetsLocalizations] and [MaterialLocalizations]
  /// are included automatically. Apps can provide their own versions of these
  /// localizations by creating implementations of
  /// [LocalizationsDelegate<WidgetsLocalizations>] or
  /// [LocalizationsDelegate<MaterialLocalizations>] whose load methods return
  /// custom versions of [WidgetsLocalizations] or [MaterialLocalizations].
  ///
  /// For example: to add support to [MaterialLocalizations] for a
  /// locale it doesn't already support, say `const Locale('foo', 'BR')`,
  /// one could just extend [DefaultMaterialLocalizations]:
  ///
  /// ```dart
  /// class FooLocalizations extends DefaultMaterialLocalizations {
  ///   FooLocalizations(Locale locale) : super(locale);
  ///   @override
  ///   String get okButtonLabel {
  ///     if (locale == const Locale('foo', 'BR'))
  ///       return 'foo';
  ///     return super.okButtonLabel;
  ///   }
  /// }
  ///
  /// ```
  ///
  /// A `FooLocalizationsDelegate` is essentially just a method that constructs
  /// a `FooLocalizations` object. We return a [SynchronousFuture] here because
  /// no asynchronous work takes place upon "loading" the localizations object.
  ///
  /// ```dart
  /// class FooLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  ///   const FooLocalizationsDelegate();
  ///   @override
  ///   Future<FooLocalizations> load(Locale locale) {
  ///     return SynchronousFuture(FooLocalizations(locale));
  ///   }
  ///   @override
  ///   bool shouldReload(FooLocalizationsDelegate old) => false;
  /// }
  /// ```
  ///
  /// Constructing a [MaterialApp] with a `FooLocalizationsDelegate` overrides
  /// the automatically included delegate for [MaterialLocalizations] because
  /// only the first delegate of each [LocalizationsDelegate.type] is used and
  /// the automatically included delegates are added to the end of the app's
  /// [localizationsDelegates] list.
  ///
  /// ```dart
  /// MaterialApp(
  ///   localizationsDelegates: [
  ///     const FooLocalizationsDelegate(),
  ///   ],
  ///   // ...
  /// )
  /// ```
  /// See also:
  ///
  ///  * [supportedLocales], which must be specified along with
  ///    [localizationsDelegates].
  ///  * [GlobalMaterialLocalizations], a [localizationsDelegates] value
  ///    which provides material localizations for many languages.
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleListResolutionCallback localeListResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.localeResolutionCallback}
  ///
  /// This callback is passed along to the [WidgetsApp] built by this widget.
  final LocaleResolutionCallback localeResolutionCallback;

  /// {@macro flutter.widgets.widgetsApp.supportedLocales}
  ///
  /// It is passed along unmodified to the [WidgetsApp] built by this widget.
  ///
  /// See also:
  ///
  ///  * [localizationsDelegates], which must be specified for localized
  ///    applications.
  ///  * [GlobalMaterialLocalizations], a [localizationsDelegates] value
  ///    which provides material localizations for many languages.
  ///  * The Flutter Internationalization Tutorial,
  ///    <https://flutter.dev/tutorials/internationalization/>.
  final Iterable<Locale> supportedLocales;

  /// Turns on a performance overlay.
  ///
  /// See also:
  ///
  ///  * <https://flutter.dev/debugging/#performanceoverlay>
  final bool showPerformanceOverlay;

  /// Turns on checkerboarding of raster cache images.
  final bool checkerboardRasterCacheImages;

  /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
  final bool checkerboardOffscreenLayers;

  /// Turns on an overlay that shows the accessibility information
  /// reported by the framework.
  final bool showSemanticsDebugger;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  /// Turns on a [GridPaper] overlay that paints a baseline grid
  /// Material apps.
  ///
  /// Only available in checked mode.
  ///
  /// See also:
  ///
  ///  * <https://material.io/design/layout/spacing-methods.html>
  final bool debugShowMaterialGrid;

  @override
  _MaterialAppState createState() => _MaterialAppState();
}

void main() {}
