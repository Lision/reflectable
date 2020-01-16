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
          staticInvokeCapability,
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

// @MyReflectable()
// class MaterialApp extends StatefulWidget {
//   /// Creates a MaterialApp.
//   ///
//   /// At least one of [home], [routes], [onGenerateRoute], or [builder] must be
//   /// non-null. If only [routes] is given, it must include an entry for the
//   /// [Navigator.defaultRouteName] (`/`), since that is the route used when the
//   /// application is launched with an intent that specifies an otherwise
//   /// unsupported route.
//   ///
//   /// This class creates an instance of [WidgetsApp].
//   ///
//   /// The boolean arguments, [routes], and [navigatorObservers], must not be null.
//   const MaterialApp({
//     Key key,
//     this.navigatorKey,
//     this.home,
//     this.routes = const <String, WidgetBuilder>{},
//     this.initialRoute,
//     this.onGenerateRoute,
//     this.onUnknownRoute,
//     this.navigatorObservers = const <NavigatorObserver>[],
//     this.builder,
//     this.title = '',
//     this.onGenerateTitle,
//     this.color,
//     this.theme,
//     this.darkTheme,
//     this.locale,
//     this.localizationsDelegates,
//     this.localeListResolutionCallback,
//     this.localeResolutionCallback,
//     this.supportedLocales = const <Locale>[Locale('en', 'US')],
//     this.debugShowMaterialGrid = false,
//     this.showPerformanceOverlay = false,
//     this.checkerboardRasterCacheImages = false,
//     this.checkerboardOffscreenLayers = false,
//     this.showSemanticsDebugger = false,
//     this.debugShowCheckedModeBanner = true,
//   })  : assert(routes != null),
//         assert(navigatorObservers != null),
//         assert(title != null),
//         assert(debugShowMaterialGrid != null),
//         assert(showPerformanceOverlay != null),
//         assert(checkerboardRasterCacheImages != null),
//         assert(checkerboardOffscreenLayers != null),
//         assert(showSemanticsDebugger != null),
//         assert(debugShowCheckedModeBanner != null),
//         super(key: key);

//   /// {@macro flutter.widgets.widgetsApp.navigatorKey}
//   final GlobalKey<NavigatorState> navigatorKey;

//   /// {@macro flutter.widgets.widgetsApp.home}
//   final Widget home;

//   /// The application's top-level routing table.
//   ///
//   /// When a named route is pushed with [Navigator.pushNamed], the route name is
//   /// looked up in this map. If the name is present, the associated
//   /// [WidgetBuilder] is used to construct a [MaterialPageRoute] that performs
//   /// an appropriate transition, including [Hero] animations, to the new route.
//   ///
//   /// {@macro flutter.widgets.widgetsApp.routes}
//   final Map<String, WidgetBuilder> routes;

//   /// {@macro flutter.widgets.widgetsApp.initialRoute}
//   final String initialRoute;

//   /// {@macro flutter.widgets.widgetsApp.onGenerateRoute}
//   final RouteFactory onGenerateRoute;

//   /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
//   final RouteFactory onUnknownRoute;

//   /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
//   final List<NavigatorObserver> navigatorObservers;

//   /// {@macro flutter.widgets.widgetsApp.builder}
//   ///
//   /// Material specific features such as [showDialog] and [showMenu], and widgets
//   /// such as [Tooltip], [PopupMenuButton], also require a [Navigator] to properly
//   /// function.
//   final TransitionBuilder builder;

//   /// {@macro flutter.widgets.widgetsApp.title}
//   ///
//   /// This value is passed unmodified to [WidgetsApp.title].
//   final String title;

//   /// {@macro flutter.widgets.widgetsApp.onGenerateTitle}
//   ///
//   /// This value is passed unmodified to [WidgetsApp.onGenerateTitle].
//   final GenerateAppTitle onGenerateTitle;

//   /// Default visual properties, like colors fonts and shapes, for this app's
//   /// material widgets.
//   ///
//   /// A second [darkTheme] [ThemeData] value, which is used when the underlying
//   /// platform requests a "dark mode" UI, can also be specified.
//   ///
//   /// The default value of this property is the value of [ThemeData.light()].
//   ///
//   /// See also:
//   ///
//   ///  * [MediaQueryData.platformBrightness], which indicates the platform's
//   ///    desired brightness and is used to automatically toggle between [theme]
//   ///    and [darkTheme] in [MaterialApp].
//   ///  * [ThemeData.brightness], which indicates the [Brightness] of a theme's
//   ///    colors.
//   final ThemeData theme;

//   /// The [ThemeData] to use when the platform specifically requests a dark
//   /// themed UI.
//   ///
//   /// Host platforms such as Android Pie can request a system-wide "dark mode"
//   /// when entering battery saver mode.
//   ///
//   /// When the host platform requests a [Brightness.dark] mode, you may want to
//   /// supply a [ThemeData.brightness] that's also [Brightness.dark].
//   ///
//   /// Uses [theme] instead when null. Defaults to the value of
//   /// [ThemeData.light()] when both [darkTheme] and [theme] are null.
//   ///
//   /// See also:
//   ///
//   ///  * [MediaQueryData.platformBrightness], which indicates the platform's
//   ///    desired brightness and is used to automatically toggle between [theme]
//   ///    and [darkTheme] in [MaterialApp].
//   ///  * [ThemeData.brightness], which is typically set to the value of
//   ///    [MediaQueryData.platformBrightness].
//   final ThemeData darkTheme;

//   /// {@macro flutter.widgets.widgetsApp.color}
//   final Color color;

//   /// {@macro flutter.widgets.widgetsApp.locale}
//   final Locale locale;

//   /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
//   ///
//   /// Internationalized apps that require translations for one of the locales
//   /// listed in [GlobalMaterialLocalizations] should specify this parameter
//   /// and list the [supportedLocales] that the application can handle.
//   ///
//   /// ```dart
//   /// import 'package:flutter_localizations/flutter_localizations.dart';
//   /// MaterialApp(
//   ///   localizationsDelegates: [
//   ///     // ... app-specific localization delegate[s] here
//   ///     GlobalMaterialLocalizations.delegate,
//   ///     GlobalWidgetsLocalizations.delegate,
//   ///   ],
//   ///   supportedLocales: [
//   ///     const Locale('en', 'US'), // English
//   ///     const Locale('he', 'IL'), // Hebrew
//   ///     // ... other locales the app supports
//   ///   ],
//   ///   // ...
//   /// )
//   /// ```
//   ///
//   /// ## Adding localizations for a new locale
//   ///
//   /// The information that follows applies to the unusual case of an app
//   /// adding translations for a language not already supported by
//   /// [GlobalMaterialLocalizations].
//   ///
//   /// Delegates that produce [WidgetsLocalizations] and [MaterialLocalizations]
//   /// are included automatically. Apps can provide their own versions of these
//   /// localizations by creating implementations of
//   /// [LocalizationsDelegate<WidgetsLocalizations>] or
//   /// [LocalizationsDelegate<MaterialLocalizations>] whose load methods return
//   /// custom versions of [WidgetsLocalizations] or [MaterialLocalizations].
//   ///
//   /// For example: to add support to [MaterialLocalizations] for a
//   /// locale it doesn't already support, say `const Locale('foo', 'BR')`,
//   /// one could just extend [DefaultMaterialLocalizations]:
//   ///
//   /// ```dart
//   /// class FooLocalizations extends DefaultMaterialLocalizations {
//   ///   FooLocalizations(Locale locale) : super(locale);
//   ///   @override
//   ///   String get okButtonLabel {
//   ///     if (locale == const Locale('foo', 'BR'))
//   ///       return 'foo';
//   ///     return super.okButtonLabel;
//   ///   }
//   /// }
//   ///
//   /// ```
//   ///
//   /// A `FooLocalizationsDelegate` is essentially just a method that constructs
//   /// a `FooLocalizations` object. We return a [SynchronousFuture] here because
//   /// no asynchronous work takes place upon "loading" the localizations object.
//   ///
//   /// ```dart
//   /// class FooLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
//   ///   const FooLocalizationsDelegate();
//   ///   @override
//   ///   Future<FooLocalizations> load(Locale locale) {
//   ///     return SynchronousFuture(FooLocalizations(locale));
//   ///   }
//   ///   @override
//   ///   bool shouldReload(FooLocalizationsDelegate old) => false;
//   /// }
//   /// ```
//   ///
//   /// Constructing a [MaterialApp] with a `FooLocalizationsDelegate` overrides
//   /// the automatically included delegate for [MaterialLocalizations] because
//   /// only the first delegate of each [LocalizationsDelegate.type] is used and
//   /// the automatically included delegates are added to the end of the app's
//   /// [localizationsDelegates] list.
//   ///
//   /// ```dart
//   /// MaterialApp(
//   ///   localizationsDelegates: [
//   ///     const FooLocalizationsDelegate(),
//   ///   ],
//   ///   // ...
//   /// )
//   /// ```
//   /// See also:
//   ///
//   ///  * [supportedLocales], which must be specified along with
//   ///    [localizationsDelegates].
//   ///  * [GlobalMaterialLocalizations], a [localizationsDelegates] value
//   ///    which provides material localizations for many languages.
//   ///  * The Flutter Internationalization Tutorial,
//   ///    <https://flutter.dev/tutorials/internationalization/>.
//   final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

//   /// {@macro flutter.widgets.widgetsApp.localeListResolutionCallback}
//   ///
//   /// This callback is passed along to the [WidgetsApp] built by this widget.
//   final LocaleListResolutionCallback localeListResolutionCallback;

//   /// {@macro flutter.widgets.widgetsApp.localeResolutionCallback}
//   ///
//   /// This callback is passed along to the [WidgetsApp] built by this widget.
//   final LocaleResolutionCallback localeResolutionCallback;

//   /// {@macro flutter.widgets.widgetsApp.supportedLocales}
//   ///
//   /// It is passed along unmodified to the [WidgetsApp] built by this widget.
//   ///
//   /// See also:
//   ///
//   ///  * [localizationsDelegates], which must be specified for localized
//   ///    applications.
//   ///  * [GlobalMaterialLocalizations], a [localizationsDelegates] value
//   ///    which provides material localizations for many languages.
//   ///  * The Flutter Internationalization Tutorial,
//   ///    <https://flutter.dev/tutorials/internationalization/>.
//   final Iterable<Locale> supportedLocales;

//   /// Turns on a performance overlay.
//   ///
//   /// See also:
//   ///
//   ///  * <https://flutter.dev/debugging/#performanceoverlay>
//   final bool showPerformanceOverlay;

//   /// Turns on checkerboarding of raster cache images.
//   final bool checkerboardRasterCacheImages;

//   /// Turns on checkerboarding of layers rendered to offscreen bitmaps.
//   final bool checkerboardOffscreenLayers;

//   /// Turns on an overlay that shows the accessibility information
//   /// reported by the framework.
//   final bool showSemanticsDebugger;

//   /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
//   final bool debugShowCheckedModeBanner;

//   /// Turns on a [GridPaper] overlay that paints a baseline grid
//   /// Material apps.
//   ///
//   /// Only available in checked mode.
//   ///
//   /// See also:
//   ///
//   ///  * <https://material.io/design/layout/spacing-methods.html>
//   final bool debugShowMaterialGrid;

//   @override
//   _MaterialAppState createState() => _MaterialAppState();
// }

// @MyReflectable()
// class Dialog extends StatelessWidget {
//   /// Creates a dialog.
//   ///
//   /// Typically used in conjunction with [showDialog].
//   const Dialog({
//     Key key,
//     this.backgroundColor,
//     this.elevation,
//     this.insetAnimationDuration = const Duration(milliseconds: 100),
//     this.insetAnimationCurve = Curves.decelerate,
//     this.shape,
//     this.child,
//   }) : super(key: key);

//   /// {@template flutter.material.dialog.backgroundColor}
//   /// The background color of the surface of this [Dialog].
//   ///
//   /// This sets the [Material.color] on this [Dialog]'s [Material].
//   ///
//   /// If `null`, [ThemeData.cardColor] is used.
//   /// {@endtemplate}
//   final Color backgroundColor;

//   /// {@template flutter.material.dialog.elevation}
//   /// The z-coordinate of this [Dialog].
//   ///
//   /// If null then [DialogTheme.elevation] is used, and if that's null then the
//   /// dialog's elevation is 24.0.
//   /// {@endtemplate}
//   /// {@macro flutter.material.material.elevation}
//   final double elevation;

//   /// The duration of the animation to show when the system keyboard intrudes
//   /// into the space that the dialog is placed in.
//   ///
//   /// Defaults to 100 milliseconds.
//   final Duration insetAnimationDuration;

//   /// The curve to use for the animation shown when the system keyboard intrudes
//   /// into the space that the dialog is placed in.
//   ///
//   /// Defaults to [Curves.fastOutSlowIn].
//   final Curve insetAnimationCurve;

//   /// {@template flutter.material.dialog.shape}
//   /// The shape of this dialog's border.
//   ///
//   /// Defines the dialog's [Material.shape].
//   ///
//   /// The default shape is a [RoundedRectangleBorder] with a radius of 2.0.
//   /// {@endtemplate}
//   final ShapeBorder shape;

//   /// The widget below this widget in the tree.
//   ///
//   /// {@macro flutter.widgets.child}
//   final Widget child;

//   // TODO(johnsonmh): Update default dialog border radius to 4.0 to match material spec.
//   static const RoundedRectangleBorder _defaultDialogShape =
//       RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(2.0)));
//   static const double _defaultElevation = 24.0;

//   @override
//   Widget build(BuildContext context) {
//     final DialogTheme dialogTheme = DialogTheme.of(context);
//     return AnimatedPadding(
//       padding: MediaQuery.of(context).viewInsets +
//           const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
//       duration: insetAnimationDuration,
//       curve: insetAnimationCurve,
//       child: MediaQuery.removeViewInsets(
//         removeLeft: true,
//         removeTop: true,
//         removeRight: true,
//         removeBottom: true,
//         context: context,
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(minWidth: 280.0),
//             child: Material(
//               color: backgroundColor ??
//                   dialogTheme.backgroundColor ??
//                   Theme.of(context).dialogBackgroundColor,
//               elevation:
//                   elevation ?? dialogTheme.elevation ?? _defaultElevation,
//               shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
//               type: MaterialType.card,
//               child: child,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// @MyReflectable()
// class InkWell extends InkResponse {
//   /// Creates an ink well.
//   ///
//   /// Must have an ancestor [Material] widget in which to cause ink reactions.
//   ///
//   /// The [enableFeedback] and [excludeFromSemantics] arguments must not be
//   /// null.
//   const InkWell({
//     Key key,
//     Widget child,
//     GestureTapCallback onTap,
//     GestureTapCallback onDoubleTap,
//     GestureLongPressCallback onLongPress,
//     GestureTapDownCallback onTapDown,
//     GestureTapCancelCallback onTapCancel,
//     ValueChanged<bool> onHighlightChanged,
//     Color highlightColor,
//     Color splashColor,
//     InteractiveInkFeatureFactory splashFactory,
//     double radius,
//     BorderRadius borderRadius,
//     ShapeBorder customBorder,
//     bool enableFeedback = true,
//     bool excludeFromSemantics = false,
//   }) : super(
//           key: key,
//           child: child,
//           onTap: onTap,
//           onDoubleTap: onDoubleTap,
//           onLongPress: onLongPress,
//           onTapDown: onTapDown,
//           onTapCancel: onTapCancel,
//           onHighlightChanged: onHighlightChanged,
//           containedInkWell: true,
//           highlightShape: BoxShape.rectangle,
//           highlightColor: highlightColor,
//           splashColor: splashColor,
//           splashFactory: splashFactory,
//           radius: radius,
//           borderRadius: borderRadius,
//           customBorder: customBorder,
//           enableFeedback: enableFeedback,
//           excludeFromSemantics: excludeFromSemantics,
//         );
// }

// @MyReflectable()
// class TextField extends StatefulWidget {
//   /// Creates a Material Design text field.
//   ///
//   /// If [decoration] is non-null (which is the default), the text field requires
//   /// one of its ancestors to be a [Material] widget.
//   ///
//   /// To remove the decoration entirely (including the extra padding introduced
//   /// by the decoration to save space for the labels), set the [decoration] to
//   /// null.
//   ///
//   /// The [maxLines] property can be set to null to remove the restriction on
//   /// the number of lines. By default, it is one, meaning this is a single-line
//   /// text field. [maxLines] must not be zero.
//   ///
//   /// The [maxLength] property is set to null by default, which means the
//   /// number of characters allowed in the text field is not restricted. If
//   /// [maxLength] is set a character counter will be displayed below the
//   /// field showing how many characters have been entered. If the value is
//   /// set to a positive integer it will also display the maximum allowed
//   /// number of characters to be entered.  If the value is set to
//   /// [TextField.noMaxLength] then only the current length is displayed.
//   ///
//   /// After [maxLength] characters have been input, additional input
//   /// is ignored, unless [maxLengthEnforced] is set to false. The text field
//   /// enforces the length with a [LengthLimitingTextInputFormatter], which is
//   /// evaluated after the supplied [inputFormatters], if any. The [maxLength]
//   /// value must be either null or greater than zero.
//   ///
//   /// If [maxLengthEnforced] is set to false, then more than [maxLength]
//   /// characters may be entered, and the error counter and divider will
//   /// switch to the [decoration.errorStyle] when the limit is exceeded.
//   ///
//   /// The [textAlign], [autofocus], [obscureText], [autocorrect],
//   /// [maxLengthEnforced], [scrollPadding], [maxLines], and [maxLength]
//   /// arguments must not be null.
//   ///
//   /// See also:
//   ///
//   ///  * [maxLength], which discusses the precise meaning of "number of
//   ///    characters" and how it may differ from the intuitive meaning.
//   const TextField({
//     Key key,
//     this.controller,
//     this.focusNode,
//     this.decoration = const InputDecoration(),
//     TextInputType keyboardType,
//     this.textInputAction,
//     this.textCapitalization = TextCapitalization.none,
//     this.style,
//     this.strutStyle,
//     this.textAlign = TextAlign.start,
//     this.textDirection,
//     this.autofocus = false,
//     this.obscureText = false,
//     this.autocorrect = true,
//     this.maxLines = 1,
//     this.minLines,
//     this.expands = false,
//     this.maxLength,
//     this.maxLengthEnforced = true,
//     this.onChanged,
//     this.onEditingComplete,
//     this.onSubmitted,
//     this.inputFormatters,
//     this.enabled,
//     this.cursorWidth = 2.0,
//     this.cursorRadius,
//     this.cursorColor,
//     this.keyboardAppearance,
//     this.scrollPadding = const EdgeInsets.all(20.0),
//     this.dragStartBehavior = DragStartBehavior.start,
//     this.enableInteractiveSelection,
//     this.onTap,
//     this.buildCounter,
//     this.scrollPhysics,
//   })  : assert(textAlign != null),
//         assert(autofocus != null),
//         assert(obscureText != null),
//         assert(autocorrect != null),
//         assert(maxLengthEnforced != null),
//         assert(scrollPadding != null),
//         assert(dragStartBehavior != null),
//         assert(maxLines == null || maxLines > 0),
//         assert(minLines == null || minLines > 0),
//         assert(
//           (maxLines == null) || (minLines == null) || (maxLines >= minLines),
//           'minLines can\'t be greater than maxLines',
//         ),
//         assert(expands != null),
//         assert(
//           !expands || (maxLines == null && minLines == null),
//           'minLines and maxLines must be null when expands is true.',
//         ),
//         assert(maxLength == null ||
//             maxLength == TextField.noMaxLength ||
//             maxLength > 0),
//         keyboardType = keyboardType ??
//             (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
//         super(key: key);

//   /// Controls the text being edited.
//   ///
//   /// If null, this widget will create its own [TextEditingController].
//   final TextEditingController controller;

//   /// Defines the keyboard focus for this widget.
//   ///
//   /// The [focusNode] is a long-lived object that's typically managed by a
//   /// [StatefulWidget] parent. See [FocusNode] for more information.
//   ///
//   /// To give the keyboard focus to this widget, provide a [focusNode] and then
//   /// use the current [FocusScope] to request the focus:
//   ///
//   /// ```dart
//   /// FocusScope.of(context).requestFocus(myFocusNode);
//   /// ```
//   ///
//   /// This happens automatically when the widget is tapped.
//   ///
//   /// To be notified when the widget gains or loses the focus, add a listener
//   /// to the [focusNode]:
//   ///
//   /// ```dart
//   /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
//   /// ```
//   ///
//   /// If null, this widget will create its own [FocusNode].
//   ///
//   /// ## Keyboard
//   ///
//   /// Requesting the focus will typically cause the keyboard to be shown
//   /// if it's not showing already.
//   ///
//   /// On Android, the user can hide the keyboard - without changing the focus -
//   /// with the system back button. They can restore the keyboard's visibility
//   /// by tapping on a text field.  The user might hide the keyboard and
//   /// switch to a physical keyboard, or they might just need to get it
//   /// out of the way for a moment, to expose something it's
//   /// obscuring. In this case requesting the focus again will not
//   /// cause the focus to change, and will not make the keyboard visible.
//   ///
//   /// This widget builds an [EditableText] and will ensure that the keyboard is
//   /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
//   final FocusNode focusNode;

//   /// The decoration to show around the text field.
//   ///
//   /// By default, draws a horizontal line under the text field but can be
//   /// configured to show an icon, label, hint text, and error text.
//   ///
//   /// Specify null to remove the decoration entirely (including the
//   /// extra padding introduced by the decoration to save space for the labels).
//   final InputDecoration decoration;

//   /// {@macro flutter.widgets.editableText.keyboardType}
//   final TextInputType keyboardType;

//   /// The type of action button to use for the keyboard.
//   ///
//   /// Defaults to [TextInputAction.newline] if [keyboardType] is
//   /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
//   final TextInputAction textInputAction;

//   /// {@macro flutter.widgets.editableText.textCapitalization}
//   final TextCapitalization textCapitalization;

//   /// The style to use for the text being edited.
//   ///
//   /// This text style is also used as the base style for the [decoration].
//   ///
//   /// If null, defaults to the `subhead` text style from the current [Theme].
//   final TextStyle style;

//   /// {@macro flutter.widgets.editableText.strutStyle}
//   final StrutStyle strutStyle;

//   /// {@macro flutter.widgets.editableText.textAlign}
//   final TextAlign textAlign;

//   /// {@macro flutter.widgets.editableText.textDirection}
//   final TextDirection textDirection;

//   /// {@macro flutter.widgets.editableText.autofocus}
//   final bool autofocus;

//   /// {@macro flutter.widgets.editableText.obscureText}
//   final bool obscureText;

//   /// {@macro flutter.widgets.editableText.autocorrect}
//   final bool autocorrect;

//   /// {@macro flutter.widgets.editableText.maxLines}
//   final int maxLines;

//   /// {@macro flutter.widgets.editableText.minLines}
//   final int minLines;

//   /// {@macro flutter.widgets.editableText.expands}
//   final bool expands;

//   /// If [maxLength] is set to this value, only the "current input length"
//   /// part of the character counter is shown.
//   static const int noMaxLength = -1;

//   /// The maximum number of characters (Unicode scalar values) to allow in the
//   /// text field.
//   ///
//   /// If set, a character counter will be displayed below the
//   /// field showing how many characters have been entered. If set to a number
//   /// greater than 0, it will also display the maximum number allowed. If set
//   /// to [TextField.noMaxLength] then only the current character count is displayed.
//   ///
//   /// After [maxLength] characters have been input, additional input
//   /// is ignored, unless [maxLengthEnforced] is set to false. The text field
//   /// enforces the length with a [LengthLimitingTextInputFormatter], which is
//   /// evaluated after the supplied [inputFormatters], if any.
//   ///
//   /// This value must be either null, [TextField.noMaxLength], or greater than 0.
//   /// If null (the default) then there is no limit to the number of characters
//   /// that can be entered. If set to [TextField.noMaxLength], then no limit will
//   /// be enforced, but the number of characters entered will still be displayed.
//   ///
//   /// Whitespace characters (e.g. newline, space, tab) are included in the
//   /// character count.
//   ///
//   /// If [maxLengthEnforced] is set to false, then more than [maxLength]
//   /// characters may be entered, but the error counter and divider will
//   /// switch to the [decoration.errorStyle] when the limit is exceeded.
//   ///
//   /// ## Limitations
//   ///
//   /// The text field does not currently count Unicode grapheme clusters (i.e.
//   /// characters visible to the user), it counts Unicode scalar values, which
//   /// leaves out a number of useful possible characters (like many emoji and
//   /// composed characters), so this will be inaccurate in the presence of those
//   /// characters. If you expect to encounter these kinds of characters, be
//   /// generous in the maxLength used.
//   ///
//   /// For instance, the character "ö" can be represented as '\u{006F}\u{0308}',
//   /// which is the letter "o" followed by a composed diaeresis "¨", or it can
//   /// be represented as '\u{00F6}', which is the Unicode scalar value "LATIN
//   /// SMALL LETTER O WITH DIAERESIS". In the first case, the text field will
//   /// count two characters, and the second case will be counted as one
//   /// character, even though the user can see no difference in the input.
//   ///
//   /// Similarly, some emoji are represented by multiple scalar values. The
//   /// Unicode "THUMBS UP SIGN + MEDIUM SKIN TONE MODIFIER", "👍🏽", should be
//   /// counted as a single character, but because it is a combination of two
//   /// Unicode scalar values, '\u{1F44D}\u{1F3FD}', it is counted as two
//   /// characters.
//   ///
//   /// See also:
//   ///
//   ///  * [LengthLimitingTextInputFormatter] for more information on how it
//   ///    counts characters, and how it may differ from the intuitive meaning.
//   final int maxLength;

//   /// If true, prevents the field from allowing more than [maxLength]
//   /// characters.
//   ///
//   /// If [maxLength] is set, [maxLengthEnforced] indicates whether or not to
//   /// enforce the limit, or merely provide a character counter and warning when
//   /// [maxLength] is exceeded.
//   final bool maxLengthEnforced;

//   /// {@macro flutter.widgets.editableText.onChanged}
//   ///
//   /// See also:
//   ///
//   ///  * [inputFormatters], which are called before [onChanged]
//   ///    runs and can validate and change ("format") the input value.
//   ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
//   ///    which are more specialized input change notifications.
//   final ValueChanged<String> onChanged;

//   /// {@macro flutter.widgets.editableText.onEditingComplete}
//   final VoidCallback onEditingComplete;

//   /// {@macro flutter.widgets.editableText.onSubmitted}
//   final ValueChanged<String> onSubmitted;

//   /// {@macro flutter.widgets.editableText.inputFormatters}
//   final List<TextInputFormatter> inputFormatters;

//   /// If false the text field is "disabled": it ignores taps and its
//   /// [decoration] is rendered in grey.
//   ///
//   /// If non-null this property overrides the [decoration]'s
//   /// [Decoration.enabled] property.
//   final bool enabled;

//   /// {@macro flutter.widgets.editableText.cursorWidth}
//   final double cursorWidth;

//   /// {@macro flutter.widgets.editableText.cursorRadius}
//   final Radius cursorRadius;

//   /// The color to use when painting the cursor.
//   ///
//   /// Defaults to the theme's `cursorColor` when null.
//   final Color cursorColor;

//   /// The appearance of the keyboard.
//   ///
//   /// This setting is only honored on iOS devices.
//   ///
//   /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
//   final Brightness keyboardAppearance;

//   /// {@macro flutter.widgets.editableText.scrollPadding}
//   final EdgeInsets scrollPadding;

//   /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
//   final bool enableInteractiveSelection;

//   /// {@macro flutter.widgets.scrollable.dragStartBehavior}
//   final DragStartBehavior dragStartBehavior;

//   /// {@macro flutter.rendering.editable.selectionEnabled}
//   bool get selectionEnabled {
//     return enableInteractiveSelection ?? !obscureText;
//   }

//   /// Called when the user taps on this text field.
//   ///
//   /// The text field builds a [GestureDetector] to handle input events like tap,
//   /// to trigger focus requests, to move the caret, adjust the selection, etc.
//   /// Handling some of those events by wrapping the text field with a competing
//   /// GestureDetector is problematic.
//   ///
//   /// To unconditionally handle taps, without interfering with the text field's
//   /// internal gesture detector, provide this callback.
//   ///
//   /// If the text field is created with [enabled] false, taps will not be
//   /// recognized.
//   ///
//   /// To be notified when the text field gains or loses the focus, provide a
//   /// [focusNode] and add a listener to that.
//   ///
//   /// To listen to arbitrary pointer events without competing with the
//   /// text field's internal gesture detector, use a [Listener].
//   final GestureTapCallback onTap;

//   /// Callback that generates a custom [InputDecorator.counter] widget.
//   ///
//   /// See [InputCounterWidgetBuilder] for an explanation of the passed in
//   /// arguments.  The returned widget will be placed below the line in place of
//   /// the default widget built when [counterText] is specified.
//   ///
//   /// The returned widget will be wrapped in a [Semantics] widget for
//   /// accessibility, but it also needs to be accessible itself.  For example,
//   /// if returning a Text widget, set the [semanticsLabel] property.
//   ///
//   /// {@tool sample}
//   /// ```dart
//   /// Widget counter(
//   ///   BuildContext context,
//   ///   {
//   ///     int currentLength,
//   ///     int maxLength,
//   ///     bool isFocused,
//   ///   }
//   /// ) {
//   ///   return Text(
//   ///     '$currentLength of $maxLength characters',
//   ///     semanticsLabel: 'character count',
//   ///   );
//   /// }
//   /// ```
//   /// {@end-tool}
//   final InputCounterWidgetBuilder buildCounter;

//   /// {@macro flutter.widgets.edtiableText.scrollPhysics}
//   final ScrollPhysics scrollPhysics;

//   @override
//   _TextFieldState createState() => _TextFieldState();

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(DiagnosticsProperty<TextEditingController>(
//         'controller', controller,
//         defaultValue: null));
//     properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode,
//         defaultValue: null));
//     properties
//         .add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
//     properties.add(DiagnosticsProperty<InputDecoration>(
//         'decoration', decoration,
//         defaultValue: const InputDecoration()));
//     properties.add(DiagnosticsProperty<TextInputType>(
//         'keyboardType', keyboardType,
//         defaultValue: TextInputType.text));
//     properties.add(
//         DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
//     properties.add(
//         DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
//     properties.add(DiagnosticsProperty<bool>('obscureText', obscureText,
//         defaultValue: false));
//     properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect,
//         defaultValue: true));
//     properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
//     properties.add(IntProperty('minLines', minLines, defaultValue: null));
//     properties.add(
//         DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
//     properties.add(IntProperty('maxLength', maxLength, defaultValue: null));
//     properties.add(FlagProperty('maxLengthEnforced',
//         value: maxLengthEnforced,
//         defaultValue: true,
//         ifFalse: 'maxLength not enforced'));
//     properties.add(EnumProperty<TextInputAction>(
//         'textInputAction', textInputAction,
//         defaultValue: null));
//     properties.add(EnumProperty<TextCapitalization>(
//         'textCapitalization', textCapitalization,
//         defaultValue: TextCapitalization.none));
//     properties.add(EnumProperty<TextAlign>('textAlign', textAlign,
//         defaultValue: TextAlign.start));
//     properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
//         defaultValue: null));
//     properties
//         .add(DoubleProperty('cursorWidth', cursorWidth, defaultValue: 2.0));
//     properties.add(DiagnosticsProperty<Radius>('cursorRadius', cursorRadius,
//         defaultValue: null));
//     properties.add(DiagnosticsProperty<Color>('cursorColor', cursorColor,
//         defaultValue: null));
//     properties.add(DiagnosticsProperty<Brightness>(
//         'keyboardAppearance', keyboardAppearance,
//         defaultValue: null));
//     properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
//         'scrollPadding', scrollPadding,
//         defaultValue: const EdgeInsets.all(20.0)));
//     properties.add(FlagProperty('selectionEnabled',
//         value: selectionEnabled,
//         defaultValue: true,
//         ifFalse: 'selection disabled'));
//     properties.add(DiagnosticsProperty<ScrollPhysics>(
//         'scrollPhysics', scrollPhysics,
//         defaultValue: null));
//   }
// }

// @MyReflectable()
// class AlertDialog extends StatelessWidget {
//   /// Creates an alert dialog.
//   ///
//   /// Typically used in conjunction with [showDialog].
//   ///
//   /// The [contentPadding] must not be null. The [titlePadding] defaults to
//   /// null, which implies a default that depends on the values of the other
//   /// properties. See the documentation of [titlePadding] for details.
//   const AlertDialog({
//     Key key,
//     this.title,
//     this.titlePadding,
//     this.titleTextStyle,
//     this.content,
//     this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
//     this.contentTextStyle,
//     this.actions,
//     this.backgroundColor,
//     this.elevation,
//     this.semanticLabel,
//     this.shape,
//   })  : assert(contentPadding != null),
//         super(key: key);

//   /// The (optional) title of the dialog is displayed in a large font at the top
//   /// of the dialog.
//   ///
//   /// Typically a [Text] widget.
//   final Widget title;

//   /// Padding around the title.
//   ///
//   /// If there is no title, no padding will be provided. Otherwise, this padding
//   /// is used.
//   ///
//   /// This property defaults to providing 24 pixels on the top, left, and right
//   /// of the title. If the [content] is not null, then no bottom padding is
//   /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
//   /// pixels of bottom padding is added to separate the [title] from the
//   /// [actions].
//   final EdgeInsetsGeometry titlePadding;

//   /// Style for the text in the [title] of this [AlertDialog].
//   ///
//   /// If null, [DialogTheme.titleTextStyle] is used, if that's null, defaults to
//   /// [ThemeData.textTheme.title].
//   final TextStyle titleTextStyle;

//   /// The (optional) content of the dialog is displayed in the center of the
//   /// dialog in a lighter font.
//   ///
//   /// Typically this is a [SingleChildScrollView] that contains the dialog's
//   /// message. As noted in the [AlertDialog] documentation, it's important
//   /// to use a [SingleChildScrollView] if there's any risk that the content
//   /// will not fit.
//   final Widget content;

//   /// Padding around the content.
//   ///
//   /// If there is no content, no padding will be provided. Otherwise, padding of
//   /// 20 pixels is provided above the content to separate the content from the
//   /// title, and padding of 24 pixels is provided on the left, right, and bottom
//   /// to separate the content from the other edges of the dialog.
//   final EdgeInsetsGeometry contentPadding;

//   /// Style for the text in the [content] of this [AlertDialog].
//   ///
//   /// If null, [DialogTheme.contentTextStyle] is used, if that's null, defaults
//   /// to [ThemeData.textTheme.subhead].
//   final TextStyle contentTextStyle;

//   /// The (optional) set of actions that are displayed at the bottom of the
//   /// dialog.
//   ///
//   /// Typically this is a list of [FlatButton] widgets.
//   ///
//   /// These widgets will be wrapped in a [ButtonBar], which introduces 8 pixels
//   /// of padding on each side.
//   ///
//   /// If the [title] is not null but the [content] _is_ null, then an extra 20
//   /// pixels of padding is added above the [ButtonBar] to separate the [title]
//   /// from the [actions].
//   final List<Widget> actions;

//   /// {@macro flutter.material.dialog.backgroundColor}
//   final Color backgroundColor;

//   /// {@macro flutter.material.dialog.elevation}
//   /// {@macro flutter.material.material.elevation}
//   final double elevation;

//   /// The semantic label of the dialog used by accessibility frameworks to
//   /// announce screen transitions when the dialog is opened and closed.
//   ///
//   /// If this label is not provided, a semantic label will be inferred from the
//   /// [title] if it is not null.  If there is no title, the label will be taken
//   /// from [MaterialLocalizations.alertDialogLabel].
//   ///
//   /// See also:
//   ///
//   ///  * [SemanticsConfiguration.isRouteName], for a description of how this
//   ///    value is used.
//   final String semanticLabel;

//   /// {@macro flutter.material.dialog.shape}
//   final ShapeBorder shape;

//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterialLocalizations(context));
//     final ThemeData theme = Theme.of(context);
//     final DialogTheme dialogTheme = DialogTheme.of(context);
//     final List<Widget> children = <Widget>[];
//     String label = semanticLabel;

//     if (title != null) {
//       children.add(Padding(
//         padding: titlePadding ??
//             EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
//         child: DefaultTextStyle(
//           style: titleTextStyle ??
//               dialogTheme.titleTextStyle ??
//               theme.textTheme.title,
//           child: Semantics(
//             child: title,
//             namesRoute: true,
//             container: true,
//           ),
//         ),
//       ));
//     } else {
//       switch (defaultTargetPlatform) {
//         case TargetPlatform.iOS:
//           label = semanticLabel;
//           break;
//         case TargetPlatform.android:
//         case TargetPlatform.fuchsia:
//           label = semanticLabel ??
//               MaterialLocalizations.of(context)?.alertDialogLabel;
//       }
//     }

//     if (content != null) {
//       children.add(Flexible(
//         child: Padding(
//           padding: contentPadding,
//           child: DefaultTextStyle(
//             style: contentTextStyle ??
//                 dialogTheme.contentTextStyle ??
//                 theme.textTheme.subhead,
//             child: content,
//           ),
//         ),
//       ));
//     }

//     if (actions != null) {
//       children.add(ButtonTheme.bar(
//         child: ButtonBar(
//           children: actions,
//         ),
//       ));
//     }

//     Widget dialogChild = IntrinsicWidth(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: children,
//       ),
//     );

//     if (label != null)
//       dialogChild = Semantics(
//         namesRoute: true,
//         label: label,
//         child: dialogChild,
//       );

//     return Dialog(
//       backgroundColor: backgroundColor,
//       elevation: elevation,
//       shape: shape,
//       child: dialogChild,
//     );
//   }
// }

// @MyReflectable()
// class MediaQuery extends InheritedWidget {
//   /// Creates a widget that provides [MediaQueryData] to its descendants.
//   ///
//   /// The [data] and [child] arguments must not be null.
//   const MediaQuery({
//     Key key,
//     @required this.data,
//     @required Widget child,
//   })  : assert(child != null),
//         assert(data != null),
//         super(key: key, child: child);

//   /// Creates a new [MediaQuery] that inherits from the ambient [MediaQuery] from
//   /// the given context, but removes the specified paddings.
//   ///
//   /// This should be inserted into the widget tree when the [MediaQuery] padding
//   /// is consumed by a widget in such a way that the padding is no longer
//   /// exposed to the widget's descendants or siblings.
//   ///
//   /// The [context] argument is required, must not be null, and must have a
//   /// [MediaQuery] in scope.
//   ///
//   /// The `removeLeft`, `removeTop`, `removeRight`, and `removeBottom` arguments
//   /// must not be null. If all four are false (the default) then the returned
//   /// [MediaQuery] reuses the ambient [MediaQueryData] unmodified, which is not
//   /// particularly useful.
//   ///
//   /// The [child] argument is required and must not be null.
//   ///
//   /// See also:
//   ///
//   ///  * [SafeArea], which both removes the padding from the [MediaQuery] and
//   ///    adds a [Padding] widget.
//   ///  * [MediaQueryData.padding], the affected property of the [MediaQueryData].
//   ///  * [new removeViewInsets], the same thing but for removing view insets.
//   factory MediaQuery.removePadding({
//     Key key,
//     @required BuildContext context,
//     bool removeLeft = false,
//     bool removeTop = false,
//     bool removeRight = false,
//     bool removeBottom = false,
//     @required Widget child,
//   }) {
//     return MediaQuery(
//       key: key,
//       data: MediaQuery.of(context).removePadding(
//         removeLeft: removeLeft,
//         removeTop: removeTop,
//         removeRight: removeRight,
//         removeBottom: removeBottom,
//       ),
//       child: child,
//     );
//   }

//   /// Creates a new [MediaQuery] that inherits from the ambient [MediaQuery] from
//   /// the given context, but removes the specified view insets.
//   ///
//   /// This should be inserted into the widget tree when the [MediaQuery] view
//   /// insets are consumed by a widget in such a way that the view insets are no
//   /// longer exposed to the widget's descendants or siblings.
//   ///
//   /// The [context] argument is required, must not be null, and must have a
//   /// [MediaQuery] in scope.
//   ///
//   /// The `removeLeft`, `removeTop`, `removeRight`, and `removeBottom` arguments
//   /// must not be null. If all four are false (the default) then the returned
//   /// [MediaQuery] reuses the ambient [MediaQueryData] unmodified, which is not
//   /// particularly useful.
//   ///
//   /// The [child] argument is required and must not be null.
//   ///
//   /// See also:
//   ///
//   ///  * [MediaQueryData.viewInsets], the affected property of the [MediaQueryData].
//   ///  * [new removePadding], the same thing but for removing paddings.
//   factory MediaQuery.removeViewInsets({
//     Key key,
//     @required BuildContext context,
//     bool removeLeft = false,
//     bool removeTop = false,
//     bool removeRight = false,
//     bool removeBottom = false,
//     @required Widget child,
//   }) {
//     return MediaQuery(
//       key: key,
//       data: MediaQuery.of(context).removeViewInsets(
//         removeLeft: removeLeft,
//         removeTop: removeTop,
//         removeRight: removeRight,
//         removeBottom: removeBottom,
//       ),
//       child: child,
//     );
//   }

//   /// Contains information about the current media.
//   ///
//   /// For example, the [MediaQueryData.size] property contains the width and
//   /// height of the current window.
//   final MediaQueryData data;

//   /// The data from the closest instance of this class that encloses the given
//   /// context.
//   ///
//   /// You can use this function to query the size an orientation of the screen.
//   /// When that information changes, your widget will be scheduled to be rebuilt,
//   /// keeping your widget up-to-date.
//   ///
//   /// Typical usage is as follows:
//   ///
//   /// ```dart
//   /// MediaQueryData media = MediaQuery.of(context);
//   /// ```
//   ///
//   /// If there is no [MediaQuery] in scope, then this will throw an exception.
//   /// To return null if there is no [MediaQuery], then pass `nullOk: true`.
//   ///
//   /// If you use this from a widget (e.g. in its build function), consider
//   /// calling [debugCheckHasMediaQuery].
//   static MediaQueryData of(BuildContext context, {bool nullOk = false}) {
//     assert(context != null);
//     assert(nullOk != null);
//     final MediaQuery query = context.inheritFromWidgetOfExactType(MediaQuery);
//     if (query != null) return query.data;
//     if (nullOk) return null;
//     throw FlutterError(
//         'MediaQuery.of() called with a context that does not contain a MediaQuery.\n'
//         'No MediaQuery ancestor could be found starting from the context that was passed '
//         'to MediaQuery.of(). This can happen because you do not have a WidgetsApp or '
//         'MaterialApp widget (those widgets introduce a MediaQuery), or it can happen '
//         'if the context you use comes from a widget above those widgets.\n'
//         'The context used was:\n'
//         '  $context');
//   }

//   /// Returns textScaleFactor for the nearest MediaQuery ancestor or 1.0, if
//   /// no such ancestor exists.
//   static double textScaleFactorOf(BuildContext context) {
//     return MediaQuery.of(context, nullOk: true)?.textScaleFactor ?? 1.0;
//   }

//   /// Returns platformBrightness for the nearest MediaQuery ancestor or
//   /// [Brightness.light], if no such ancestor exists.
//   ///
//   /// Use of this method will cause the given [context] to rebuild any time that
//   /// any property of the ancestor [MediaQuery] changes.
//   static Brightness platformBrightnessOf(BuildContext context) {
//     return MediaQuery.of(context, nullOk: true)?.platformBrightness ??
//         Brightness.light;
//   }

//   /// Returns the boldText accessibility setting for the nearest MediaQuery
//   /// ancestor, or false if no such ancestor exists.
//   static bool boldTextOverride(BuildContext context) {
//     return MediaQuery.of(context, nullOk: true)?.boldText ?? false;
//   }

//   @override
//   bool updateShouldNotify(MediaQuery oldWidget) => data != oldWidget.data;

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//         DiagnosticsProperty<MediaQueryData>('data', data, showName: false));
//   }
// }

@MyReflectable()
class EdgeInsets extends EdgeInsetsGeometry {
  /// Creates insets from offsets from the left, top, right, and bottom.
  const EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom);

  /// Creates insets where all the offsets are `value`.
  ///
  /// {@tool sample}
  ///
  /// Typical eight-pixel margin on all sides:
  ///
  /// ```dart
  /// const EdgeInsets.all(8.0)
  /// ```
  /// {@end-tool}
  const EdgeInsets.all(double value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  /// Creates insets with only the given values non-zero.
  ///
  /// {@tool sample}
  ///
  /// Left margin indent of 40 pixels:
  ///
  /// ```dart
  /// const EdgeInsets.only(left: 40.0)
  /// ```
  /// {@end-tool}
  const EdgeInsets.only({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  /// Creates insets with symmetrical vertical and horizontal offsets.
  ///
  /// {@tool sample}
  ///
  /// Eight pixel margin above and below, no horizontal margins:
  ///
  /// ```dart
  /// const EdgeInsets.symmetric(vertical: 8.0)
  /// ```
  /// {@end-tool}
  const EdgeInsets.symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  /// Creates insets that match the given window padding.
  ///
  /// If you need the current system padding or view insets in the context of a
  /// widget, consider using [MediaQuery.of] to obtain these values rather than
  /// using the value from [dart:ui.window], so that you get notified of
  /// changes.
  EdgeInsets.fromWindowPadding(
      ui.WindowPadding padding, double devicePixelRatio)
      : left = padding.left / devicePixelRatio,
        top = padding.top / devicePixelRatio,
        right = padding.right / devicePixelRatio,
        bottom = padding.bottom / devicePixelRatio;

  /// An [EdgeInsets] with zero offsets in each direction.
  static const EdgeInsets zero = EdgeInsets.only();

  /// The offset from the left.
  final double left;

  @override
  double get _left => left;

  /// The offset from the top.
  final double top;

  @override
  double get _top => top;

  /// The offset from the right.
  final double right;

  @override
  double get _right => right;

  /// The offset from the bottom.
  final double bottom;

  @override
  double get _bottom => bottom;

  @override
  double get _start => 0.0;

  @override
  double get _end => 0.0;

  /// An Offset describing the vector from the top left of a rectangle to the
  /// top left of that rectangle inset by this object.
  Offset get topLeft => Offset(left, top);

  /// An Offset describing the vector from the top right of a rectangle to the
  /// top right of that rectangle inset by this object.
  Offset get topRight => Offset(-right, top);

  /// An Offset describing the vector from the bottom left of a rectangle to the
  /// bottom left of that rectangle inset by this object.
  Offset get bottomLeft => Offset(left, -bottom);

  /// An Offset describing the vector from the bottom right of a rectangle to the
  /// bottom right of that rectangle inset by this object.
  Offset get bottomRight => Offset(-right, -bottom);

  /// An [EdgeInsets] with top and bottom as well as left and right flipped.
  @override
  EdgeInsets get flipped => EdgeInsets.fromLTRB(right, bottom, left, top);

  /// Returns a new rect that is bigger than the given rect in each direction by
  /// the amount of inset in each direction. Specifically, the left edge of the
  /// rect is moved left by [left], the top edge of the rect is moved up by
  /// [top], the right edge of the rect is moved right by [right], and the
  /// bottom edge of the rect is moved down by [bottom].
  ///
  /// See also:
  ///
  ///  * [inflateSize], to inflate a [Size] rather than a [Rect].
  ///  * [deflateRect], to deflate a [Rect] rather than inflating it.
  Rect inflateRect(Rect rect) {
    return Rect.fromLTRB(rect.left - left, rect.top - top, rect.right + right,
        rect.bottom + bottom);
  }

  /// Returns a new rect that is smaller than the given rect in each direction by
  /// the amount of inset in each direction. Specifically, the left edge of the
  /// rect is moved right by [left], the top edge of the rect is moved down by
  /// [top], the right edge of the rect is moved left by [right], and the
  /// bottom edge of the rect is moved up by [bottom].
  ///
  /// If the argument's [Rect.size] is smaller than [collapsedSize], then the
  /// resulting rectangle will have negative dimensions.
  ///
  /// See also:
  ///
  ///  * [deflateSize], to deflate a [Size] rather than a [Rect].
  ///  * [inflateRect], to inflate a [Rect] rather than deflating it.
  Rect deflateRect(Rect rect) {
    return Rect.fromLTRB(rect.left + left, rect.top + top, rect.right - right,
        rect.bottom - bottom);
  }

  @override
  EdgeInsetsGeometry subtract(EdgeInsetsGeometry other) {
    if (other is EdgeInsets) return this - other;
    return super.subtract(other);
  }

  @override
  EdgeInsetsGeometry add(EdgeInsetsGeometry other) {
    if (other is EdgeInsets) return this + other;
    return super.add(other);
  }

  /// Returns the difference between two [EdgeInsets].
  EdgeInsets operator -(EdgeInsets other) {
    return EdgeInsets.fromLTRB(
      left - other.left,
      top - other.top,
      right - other.right,
      bottom - other.bottom,
    );
  }

  /// Returns the sum of two [EdgeInsets].
  EdgeInsets operator +(EdgeInsets other) {
    return EdgeInsets.fromLTRB(
      left + other.left,
      top + other.top,
      right + other.right,
      bottom + other.bottom,
    );
  }

  /// Returns the [EdgeInsets] object with each dimension negated.
  ///
  /// This is the same as multiplying the object by -1.0.
  @override
  EdgeInsets operator -() {
    return EdgeInsets.fromLTRB(
      -left,
      -top,
      -right,
      -bottom,
    );
  }

  /// Scales the [EdgeInsets] in each dimension by the given factor.
  @override
  EdgeInsets operator *(double other) {
    return EdgeInsets.fromLTRB(
      left * other,
      top * other,
      right * other,
      bottom * other,
    );
  }

  /// Divides the [EdgeInsets] in each dimension by the given factor.
  @override
  EdgeInsets operator /(double other) {
    return EdgeInsets.fromLTRB(
      left / other,
      top / other,
      right / other,
      bottom / other,
    );
  }

  /// Integer divides the [EdgeInsets] in each dimension by the given factor.
  @override
  EdgeInsets operator ~/(double other) {
    return EdgeInsets.fromLTRB(
      (left ~/ other).toDouble(),
      (top ~/ other).toDouble(),
      (right ~/ other).toDouble(),
      (bottom ~/ other).toDouble(),
    );
  }

  /// Computes the remainder in each dimension by the given factor.
  @override
  EdgeInsets operator %(double other) {
    return EdgeInsets.fromLTRB(
      left % other,
      top % other,
      right % other,
      bottom % other,
    );
  }

  /// Linearly interpolate between two [EdgeInsets].
  ///
  /// If either is null, this function interpolates from [EdgeInsets.zero].
  ///
  /// {@macro dart.ui.shadow.lerp}
  static EdgeInsets lerp(EdgeInsets a, EdgeInsets b, double t) {
    assert(t != null);
    if (a == null && b == null) return null;
    if (a == null) return b * t;
    if (b == null) return a * (1.0 - t);
    return EdgeInsets.fromLTRB(
      ui.lerpDouble(a.left, b.left, t),
      ui.lerpDouble(a.top, b.top, t),
      ui.lerpDouble(a.right, b.right, t),
      ui.lerpDouble(a.bottom, b.bottom, t),
    );
  }

  @override
  EdgeInsets resolve(TextDirection direction) => this;

  /// Creates a copy of this EdgeInsets but with the given fields replaced
  /// with the new values.
  EdgeInsets copyWith({
    double left,
    double top,
    double right,
    double bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }
}

void main() {}
