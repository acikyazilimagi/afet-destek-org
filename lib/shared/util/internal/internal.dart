// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/material.dart';

dynamic getIframe() =>
    throw UnimplementedError('getIframe method must be call from web');

dynamic get document =>
    throw UnimplementedError('document variable must be call from web');

Widget htmlElementView({
  required String viewType,
  Function(int)? onPlatformViewCreated,
}) =>
    throw UnimplementedError('htmlElementView method must be call from web');

void setUiIframeParameter({required String key, String? id, String? url}) =>
    throw UnimplementedError(
      'setUiIframeParameter method must be call from web',
    );
