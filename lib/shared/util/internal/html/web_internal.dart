// ignore: avoid_web_libraries_in_flutter
// ignore_for_file: inference_failure_on_function_return_type, avoid_dynamic_calls, lines_longer_than_80_chars
//ignore_for_file: undefined_prefixed_name

import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

dynamic getIframe() => html.IFrameElement();

dynamic get document => html.document;

Widget htmlElementView({
  required String viewType,
  Function(int)? onPlatformViewCreated,
}) =>
    HtmlElementView(
      viewType: viewType,
      onPlatformViewCreated: onPlatformViewCreated,
    );

void setUiIframeParameter({required String key, String? id, String? url}) {
  final paymentFrame = html.IFrameElement()
    ..id = '$id'
    ..src = url ?? 'data:text/html;base64,$contentBase64'
    ..style.border = 'none'
    ..allow = 'fullscreen';
  ui.platformViewRegistry.registerViewFactory(key, (int viewId) {
    return paymentFrame;
  });
}

final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(initialHTMLPage));
const String initialHTMLPage = '''
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
</head>

<body style="background-color:black;">
</body>

</html>
''';
