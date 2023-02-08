// ignore_for_file: avoid_positional_boolean_parameters, avoid_dynamic_calls, unused_element, lines_longer_than_80_chars

import 'dart:async';

import 'package:deprem_destek/data/repository/auth_repository.dart';
import 'package:deprem_destek/gen/assets.gen.dart';
import 'package:deprem_destek/pages/auth_page/state/auth_cubit.dart';
import 'package:deprem_destek/pages/auth_page/state/auth_state.dart';
import 'package:deprem_destek/pages/kvkk_page/kvkk_page.dart';
import 'package:deprem_destek/pages/my_demand_page/my_demand_page.dart';
import 'package:deprem_destek/shared/widgets/loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage._();
  static Future<void> show(BuildContext context) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          return BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
            child: const AuthPage._(),
          );
        },
      ),
    );

    if (result != null && result) {
      // ignore: use_build_context_synchronously
      unawaited(MyDemandPage.show(context));
    }
  }

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // TODO(enes): refactor to use reactive_forms

  // ignore: unused_field, prefer_final_fields
  bool _kvkkAccepted = false;
  String _number = '';
  String _code = '';

  Timer? _smsResendTimer;

  int _smsResendCountdown = 180;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isFirstStep = authState.status == AuthStateStatus.initial ||
        authState.status == AuthStateStatus.smsFailure ||
        authState.status == AuthStateStatus.sendingSms;

    final isLoading = authState.status == AuthStateStatus.sendingSms ||
        authState.status == AuthStateStatus.verifyingCode;

    final isButtonEnabled =
        _kvkkAccepted && (isFirstStep || (!isFirstStep && _code.isNotEmpty));

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
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(Assets.logoSvg),
            )
          ],
          leadingWidth: 52,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Giriş Yap',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 28),

              IntlPhoneField(
                initialCountryCode: 'TR',
                dropdownTextStyle: Theme.of(context).textTheme.titleMedium,
                showCountryFlag: false,
                pickerDialogStyle: PickerDialogStyle(
                  searchFieldInputDecoration: const InputDecoration(
                    labelText: 'Ülke ara',
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: 'Telefon Numarası',
                  isDense: false,
                  contentPadding: EdgeInsets.zero,
                ),
                style: Theme.of(context).textTheme.titleMedium,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                autovalidateMode: AutovalidateMode.disabled,
                invalidNumberMessage: 'Geçersiz telefon numarası',
                onChanged: (number) {
                  setState(() => _number = number.completeNumber);
                },
              ),
              if (!isFirstStep) ...[
                const SizedBox(height: 8),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'SMS Kodu',
                    suffix: _smsResendCountdown > 0
                        ? Text('$_smsResendCountdown')
                        : TextButton(
                            child: const Text('Tekrar Dene'),
                            onPressed: () {
                              context
                                  .read<AuthCubit>()
                                  .sendSms(number: _number);
                            },
                          ),
                    isDense: true,
                    suffixStyle: const TextStyle(color: Colors.black),
                  ),
                  onChanged: (code) => setState(() => _code = code),
                ),
              ],
              // implement kvkk
              _KVKKCheckBox(_kvkkAccepted, (bool value) {
                setState(() {
                  _kvkkAccepted = value;
                });
              }),

              if (authState.status == AuthStateStatus.smsFailure) ...[
                const _AuthErrorMessage('SMS gönderme başarısız')
              ],
              if (authState.status ==
                  AuthStateStatus.codeVerificationFailure) ...[
                const _AuthErrorMessage('Kod doğrulama başarısız')
              ],

              const SizedBox(height: 16),

              if (isLoading) ...[
                const Loader(),
              ] else ...[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.maxFinite - 40, 50),
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                          final cubit = context.read<AuthCubit>();
                          if (isFirstStep) {
                            cubit.sendSms(number: _number);
                          } else {
                            cubit.verifySMSCode(code: _code);
                          }
                        }
                      : null,
                  child: const Text('Devam Et'),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _KVKKCheckBox extends StatelessWidget {
  const _KVKKCheckBox(this.kvkkAccepted, this.setKvkkAccepted);
  final bool kvkkAccepted;
  final Function setKvkkAccepted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: kvkkAccepted,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (value) {
                setKvkkAccepted(value ?? false);
              },
            ),
          ),
          Text.rich(
            TextSpan(
              text: '',
              style: const TextStyle(fontSize: 12),
              children: <TextSpan>[
                TextSpan(
                  text: 'KVKK Açık Rıza Metni',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => KVKKPage.show(context),
                ),
                const TextSpan(
                  text: "'ni okudum ve kabul ediyorum.",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
      child: ColoredBox(color: Colors.red, child: Text(message)),
    );
  }
}
