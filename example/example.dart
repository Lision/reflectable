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
class Wrap extends MultiChildRenderObjectWidget {
  /// Creates a wrap layout.
  ///
  /// By default, the wrap layout is horizontal and both the children and the
  /// runs are aligned to the start.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to decide which direction to lay the children in or to
  /// disambiguate `start` or `end` values for the main or cross axis
  /// directions, the [textDirection] must not be null.
  Wrap({
    Key key,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  /// The direction to use as the main axis.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis direction;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment alignment;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [alignment].
  ///
  /// Defaults to 0.0.
  final double spacing;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [Wrap] in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment runAlignment;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// For example, if [runSpacing] is 10.0, the runs will be spaced at least
  /// 10.0 logical pixels apart in the cross axis.
  ///
  /// If there is additional free space in the overall [Wrap] (e.g., because
  /// the wrap has a minimum size that is not filled), the additional free space
  /// will be allocated according to the [runAlignment].
  ///
  /// Defaults to 0.0.
  final double runSpacing;

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// For example, if this is set to [WrapCrossAlignment.end], and the
  /// [direction] is [Axis.horizontal], then the children within each
  /// run will have their bottom edges aligned to the bottom edge of the run.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  final WrapCrossAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If the [direction] is [Axis.horizontal], this controls order in which the
  /// children are positioned (left-to-right or right-to-left), and the meaning
  /// of the [alignment] property's [WrapAlignment.start] and
  /// [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [alignment] is either [WrapAlignment.start] or [WrapAlignment.end], or
  /// there's more than one child, then the [textDirection] (or the ambient
  /// [Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [alignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [alignment]
  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  @override
  RenderWrap createRenderObject(BuildContext context) {
    return RenderWrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection ?? Directionality.of(context),
      verticalDirection: verticalDirection,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderWrap renderObject) {
    renderObject
      ..direction = direction
      ..alignment = alignment
      ..spacing = spacing
      ..runAlignment = runAlignment
      ..runSpacing = runSpacing
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = textDirection ?? Directionality.of(context)
      ..verticalDirection = verticalDirection;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(EnumProperty<WrapAlignment>('alignment', alignment));
    properties.add(DoubleProperty('spacing', spacing));
    properties.add(EnumProperty<WrapAlignment>('runAlignment', runAlignment));
    properties.add(DoubleProperty('runSpacing', runSpacing));
    properties.add(DoubleProperty('crossAxisAlignment', runSpacing));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties.add(EnumProperty<VerticalDirection>(
        'verticalDirection', verticalDirection,
        defaultValue: VerticalDirection.down));
  }
}

void main() {}
