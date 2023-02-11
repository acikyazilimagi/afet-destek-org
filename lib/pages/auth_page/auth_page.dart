// ignore_for_file: avoid_positional_boolean_parameters, avoid_dynamic_calls, unused_element, lines_longer_than_80_chars

import 'dart:async';

import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/auth_page/state/auth_cubit.dart';
import 'package:afet_destek/pages/auth_page/state/auth_state.dart';
import 'package:afet_destek/pages/demands_page/state/demands_cubit.dart';
import 'package:afet_destek/pages/demands_page/widgets/new_demand_information_popup.dart';
import 'package:afet_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:afet_destek/shared/widgets/responsive_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage._();
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onClose,
  }) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          final width =
              MediaQuery.of(context).size.width.clamp(0, 700).toDouble();
          return BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
            child: SizedBox(
              width: width,
              child: const AuthPage._(),
            ),
          );
        },
      ),
    );

    if (result != null && result) {
      // ignore: use_build_context_synchronously
      await NewDemandInformationPopup.show(
        context: context,
        onClose: () {
          Navigator.of(context).pop();
        },
        onContinue: () {
          Navigator.of(context).pop();
          MyDemandPage.show(
            context,
            onClose: () {
              context.read<DemandsCubit>().refreshDemands();
            },
          );
        },
      );
    }
  }

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // TODO(enes): refactor to use reactive_forms

  String _number = '';
  String _code = '';

  Timer? _smsResendTimer;

  int _smsResendCountdown = 180;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final authState = context.watch<AuthCubit>().state;
    final isFirstStep = authState.status == AuthStateStatus.initial ||
        authState.status == AuthStateStatus.smsFailure ||
        authState.status == AuthStateStatus.sendingSms;

    final isLoading = authState.status == AuthStateStatus.sendingSms ||
        authState.status == AuthStateStatus.verifyingCode;

    final isButtonEnabled = isFirstStep || (!isFirstStep && _code.isNotEmpty);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.authorized) {
          Navigator.of(context).pop(true);
        }
        if (state.status == AuthStateStatus.smsSent) {
          _smsResendCountdown = 180;
          _smsResendTimer?.cancel();
          _smsResendTimer = Timer.periodic(
            const Duration(seconds: 1),
            (_) {
              if (_smsResendCountdown == 0) {
                _smsResendTimer?.cancel();
              } else {
                setState(() {
                  _smsResendCountdown--;
                });
              }
            },
          );
        }
      },
      child: Scaffold(
        appBar: ResponsiveAppBar(
          mobileTile: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(Assets.logoSvg),
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 700,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (size.width >= 1000)
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.1),
                          SvgPicture.asset(Assets.logoSvg, height: 150),
                          SizedBox(height: size.height * 0.03),
                        ],
                      ),
                    const SizedBox(height: 28),
                    Text(
                      LocaleKeys.login.getStr(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 28),
                    Form(
                      key: _formKey,
                      child: IntlPhoneField(
                        initialCountryCode: 'TR',
                        dropdownTextStyle:
                            Theme.of(context).textTheme.titleMedium,
                        showCountryFlag: false,
                        onCountryChanged: (country) {
                          _formKey.currentState!.validate();
                        },
                        pickerDialogStyle: PickerDialogStyle(
                          width:
                              MediaQuery.of(context).size.width.clamp(0, 500),
                          searchFieldInputDecoration: InputDecoration(
                            labelText: LocaleKeys.search_country.getStr(),
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.phone_number.getStr(),
                          isDense: false,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        autovalidateMode: AutovalidateMode.disabled,
                        invalidNumberMessage:
                            LocaleKeys.invalid_phone_number.getStr(),
                        onChanged: (number) {
                          setState(() => _number = number.completeNumber);
                          _formKey.currentState!.validate();
                        },
                      ),
                    ),
                    if (authState.status == AuthStateStatus.smsFailure) ...[
                      _AuthErrorMessage(LocaleKeys.sms_sending_failed.getStr()),
                    ],
                    if (!isFirstStep) ...[
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.sms_code.getStr(),
                          suffix: _smsResendCountdown > 0
                              ? Text('$_smsResendCountdown')
                              : TextButton(
                                  child: Text(LocaleKeys.try_again.getStr()),
                                  onPressed: () {
                                    context
                                        .read<AuthCubit>()
                                        .sendSms(number: _number);
                                  },
                                ),
                          isDense: true,
                          suffixStyle:
                              TextStyle(color: context.appColors.black),
                        ),
                        onChanged: (code) => setState(() => _code = code),
                      ),
                      if (authState.status ==
                          AuthStateStatus.codeVerificationFailure) ...[
                        _AuthErrorMessage(
                          LocaleKeys.code_validation_failed.getStr(),
                        ),
                      ]
                    ],
                    const SizedBox(height: 16),
                    if (isLoading) ...[
                      const Loader(),
                    ] else ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.maxFinite - 40, 50),
                        ),
                        onPressed: (isButtonEnabled &&
                                _formKey.currentState != null &&
                                _formKey.currentState!.validate())
                            ? () {
                                final cubit = context.read<AuthCubit>();
                                if (isFirstStep) {
                                  cubit.sendSms(number: _number);
                                } else {
                                  cubit.verifySMSCode(code: _code);
                                }
                              }
                            : null,
                        child: Text(LocaleKeys.continue_text.getStr()),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthErrorMessage extends StatelessWidget {
  const _AuthErrorMessage(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: context.appColors.mainRed,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            message,
            style: DefaultTextStyle.of(context).style.copyWith(
                  color: context.appColors.white,
                ),
          ),
        ),
      ),
    );
  }
}
