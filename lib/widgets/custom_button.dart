import 'package:deprem_destek/config/palette.dart';
import 'package:deprem_destek/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

enum CustomButtonType { primary, secondary, delete, confirm, cancel, formField, flat, whatsapp, sms, faded, outlined, deleteOutlined }

Map<CustomButtonType, Color> _customButtonColors = {
  CustomButtonType.confirm: Palette.primaryColor,
  CustomButtonType.cancel: Palette.primaryColor,
  CustomButtonType.formField: Palette.backgroundColor,
  CustomButtonType.flat: Colors.black,
  CustomButtonType.whatsapp: Palette.successColor,
  CustomButtonType.sms: Palette.primaryColor,
  CustomButtonType.faded: Palette.primaryColor.withAlpha(100),
  CustomButtonType.outlined: Palette.backgroundColor,
  CustomButtonType.deleteOutlined: Palette.backgroundColor,
};

Map<CustomButtonType, Color> _customButtonTextColors = {
  CustomButtonType.primary: Colors.white,
  CustomButtonType.secondary: Colors.white,
  CustomButtonType.delete: Colors.white,
  CustomButtonType.confirm: Colors.white,
  CustomButtonType.cancel: Colors.white,
  CustomButtonType.formField: Palette.greyTextColor,
  CustomButtonType.flat: Colors.white.withOpacity(0.65),
  CustomButtonType.whatsapp: Colors.white,
  CustomButtonType.sms: Colors.white,
  CustomButtonType.faded: Palette.primaryColor,
  CustomButtonType.deleteOutlined: Colors.white,
};

class CustomButton extends StatelessWidget {
  final CustomButtonType _customButtonType;
  final Widget? _child;
  final String _text;
  final Function() _onPressed;
  final Function()? _onLongPress;
  final bool? _haveChild;
  final bool? _isExpanded;
  final bool? _isEnabled;
  final bool? _isDone;

  final FocusNode? _focusNode;

  final TextStyle? _textStyle;

  final BorderRadius? _borderRadius;
  final EdgeInsetsGeometry _padding;
  final EdgeInsetsGeometry _margin;
  final EdgeInsetsGeometry? _customPadding;

  const CustomButton({
    Key? key,
    required String text,
    required CustomButtonType customButtonType,
    required Function() onPressed,
    Function()? onLongPress,
    bool isExpanded = true,
    bool isEnabled = true,
    bool isDone = false,
    FocusNode? focusNode,
    TextStyle? textStyle,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 3.5),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8.0),
    EdgeInsetsGeometry? customPadding,
  })  : _text = text,
        _customButtonType = customButtonType,
        _onPressed = onPressed,
        _onLongPress = onLongPress,
        _isExpanded = isExpanded,
        _isEnabled = isEnabled && onPressed != null,
        _isDone = isDone,
        _focusNode = focusNode,
        _textStyle = textStyle,
        _borderRadius = borderRadius,
        _padding = padding,
        _margin = margin,
        _customPadding = customPadding,
        _haveChild = false,
        _child = null,
        super(key: key);

  const CustomButton.child({
    Key? key,
    required Widget child,
    required Function() onPressed,
    CustomButtonType customButtonType = CustomButtonType.flat,
    Function()? onLongPress,
    bool isExpanded = true,
    bool isEnabled = true,
    bool isDone = false,
    FocusNode? focusNode,
    TextStyle? textStyle,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 3.5),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8.0),
    EdgeInsetsGeometry? customPadding,
  })  : _child = child,
        _customButtonType = customButtonType,
        _onPressed = onPressed,
        _onLongPress = onLongPress,
        _isExpanded = isExpanded,
        _isEnabled = isEnabled,
        _isDone = isDone,
        _focusNode = focusNode,
        _textStyle = textStyle,
        _borderRadius = borderRadius,
        _padding = padding,
        _margin = margin,
        _customPadding = customPadding,
        _haveChild = true,
        _text = "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !_isEnabled!,
      child: Container(
        margin: _margin,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          border: _customButtonType == CustomButtonType.deleteOutlined
              ? Border.all(color: Colors.red)
              : _customButtonType == CustomButtonType.outlined
                  ? Border.all(color: Palette.primaryColor)
                  : _customButtonType == CustomButtonType.formField
                      ? Border.all(color: Palette.hintTextColor)
                      : null,
          color: _isEnabled!
              ? (_haveChild!
                  ? (_customButtonType == CustomButtonType.formField || _customButtonType == CustomButtonType.faded
                      ? _customButtonColors[_customButtonType]
                      : Colors.transparent)
                  : _customButtonColors[_customButtonType])
              : Palette.grayColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            overlayColor: MaterialStateProperty.all(Palette.primaryColor.withOpacity(0.7).withAlpha(100)),
            highlightColor: Palette.primaryColor.withOpacity(0.7).withAlpha(50),
            focusNode: _focusNode,
            borderRadius: const BorderRadius.all(Radius.circular(7.0)),
            onTap: () {
              HapticFeedback.mediumImpact();
              _onPressed();
            },
            onLongPress: _onLongPress != null
                ? () {
                    HapticFeedback.heavyImpact();
                    _onLongPress!();
                  }
                : null,
            child: Padding(
              padding: _customPadding ?? const EdgeInsets.all(12.0).add(_padding),
              child: Row(
                mainAxisSize: _isExpanded! ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _childBuilder(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _childBuilder(BuildContext context) {
    if (_haveChild!) {
      return _child!;
    } else if (_customButtonType == CustomButtonType.deleteOutlined) {
      return Text(_text, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
    } else if (_customButtonType == CustomButtonType.whatsapp) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 12.0),
          SvgPicture.asset("whatsapp.svg"),
          const SizedBox(width: 12.0),
          Text(_text, style: CustomTheme.subtitle(context, color: Colors.white)),
        ],
      );
    } else if (_customButtonType == CustomButtonType.sms) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 12.0),
          SvgPicture.asset("sms.svg"),
          const SizedBox(width: 12.0),
          Text(_text, style: CustomTheme.subtitle(context, color: Colors.white)),
        ],
      );
    } else {
      if (!_isExpanded!) {
        return Text(
          _text,
          style: _textStyle ??
              CustomTheme.subtitle(
                context,
                color: _isEnabled! ? _customButtonTextColors[_customButtonType] : Colors.white,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        );
      } else {
        return Expanded(
          child: Text(
            _text,
            style: _textStyle ??
                CustomTheme.subtitle(
                  context,
                  color: _isEnabled! ? _customButtonTextColors[_customButtonType] : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        );
      }
    }
  }
}
