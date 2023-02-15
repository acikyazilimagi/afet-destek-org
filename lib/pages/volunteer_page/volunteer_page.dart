import 'package:afet_destek/data/repository/auth_repository.dart';
import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/my_demand_page/widgets/geo_value_accessor.dart';
import 'package:afet_destek/pages/volunteer_page/state/volunteer_cubit.dart';
import 'package:afet_destek/pages/volunteer_page/state/volunteer_state.dart';
import 'package:afet_destek/pages/volunteer_page/widgets/volunteer_request_category_selector.dart';
import 'package:afet_destek/shared/extensions/reactive_forms_extensions.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/widgets/app_form_field_title.dart';
import 'package:afet_destek/shared/widgets/infobox.dart';
import 'package:afet_destek/shared/widgets/responsive_app_bar.dart';
import 'package:afet_destek/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

class VolunteerPage extends StatefulWidget {
  const VolunteerPage._({
    required this.userId,
  });

  final String? userId;

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) {
          return StreamBuilder(
            stream: context.read<AuthRepository>().userStream,
            builder: (context, snapshot) {
              return BlocProvider<VolunteerCubit>(
                create: (context) => VolunteerCubit(
                  demandsRepository: context.read<DemandsRepository>(),
                ),
                child: VolunteerPage._(
                  userId: snapshot.data?.uid,
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  List<String> _categoryIds = [];

  final FormGroup _volunteerPageFormGroup = FormGroup(
    {
      _VolunteerPageFormFields.geoLocation.name:
          FormControl<GoogleGeocodingResult>(
        disabled: true,
      ),
      _VolunteerPageFormFields.radiusKm.name: FormControl<double>(value: 25),
    },
  );

  @override
  void initState() {
    super.initState();
    final currentLocation = context.read<AppCubit>().state.whenOrNull(
          loaded: (currentLocation, demandCategories) => currentLocation,
        );

    _volunteerPageFormGroup
        .control(_VolunteerPageFormFields.geoLocation.name)
        .value = currentLocation;
  }

  void _onSave() {
    final geo =
        _volunteerPageFormGroup.readByControlName<GoogleGeocodingResult>(
      _VolunteerPageFormFields.geoLocation.name,
    );

    final radiusKm = _volunteerPageFormGroup.readByControlName<double>(
      _VolunteerPageFormFields.radiusKm.name,
    );

    context.read<VolunteerCubit>().addRequest(
          geo: geo,
          categoryIds: _categoryIds,
          radiusKm: radiusKm,
        );
  }

  void _listener(BuildContext context, VolunteerState state) {
    state.status.whenOrNull(
      saveFail: () {
        AppSnackbars.failure(LocaleKeys.volunteer_subscribe_failed.getStr())
            .show(context);
      },
      saveSuccess: () {
        AppSnackbars.success(LocaleKeys.volunteer_subscribed.getStr())
            .show(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
      listener: _listener,
      builder: (context, state) {
        final deactivateButtons = state.status.maybeWhen(
          saving: () => true,
          orElse: () => false,
        );

        return Scaffold(
          appBar: ResponsiveAppBar(
            title: LocaleKeys.become_volunteer_page_title.getStr(),
          ),
          body: ReactiveForm(
            formGroup: _volunteerPageFormGroup,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (MediaQuery.of(context).size.width >= 1000)
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back),
                              ),
                              Text(
                                LocaleKeys.become_volunteer_page_title.getStr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    const SizedBox(height: 16),
                    const Infobox(
                      info:
                          '''Yakınınızda oluşturulan yardım taleplerinden anında haberdar olmak ve yardım edebilmek için bu sayfadan bildirim ayarlarınızı oluşturabilirsiniz. Bu özellik henüz iOS'ta desteklenmemektedir.''',
                    ),
                    const SizedBox(height: 32),
                    AppFormFieldTitle(
                      title: LocaleKeys.current_address.getStr(),
                    ),
                    const SizedBox(height: 8),
                    ReactiveTextField<GoogleGeocodingResult>(
                      formControlName:
                          _VolunteerPageFormFields.geoLocation.name,
                      readOnly: true,
                      valueAccessor: GeoValueAccessor(),
                      decoration: InputDecoration(
                        fillColor: context.appColors.disabledButton,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppFormFieldTitle(
                      title: LocaleKeys.radius_km_title.getStr(),
                    ),
                    const SizedBox(height: 8),
                    ReactiveSlider(
                      formControlName: _VolunteerPageFormFields.radiusKm.name,
                      inactiveColor: Colors.grey[200],
                      max: 50,
                      min: 1,
                    ),
                    const SizedBox(height: 8),
                    ReactiveFormConsumer(
                      builder: (context, formGroup, child) {
                        final radiusKm = formGroup
                            .control(
                              _VolunteerPageFormFields.radiusKm.name,
                            )
                            .value as double;
                        return Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: LocaleKeys.distance.getStr(),
                                style: const TextStyle(
                                  color: Color(0xff475467),
                                ),
                              ),
                              TextSpan(
                                text: radiusKm == 50
                                    ? LocaleKeys.everywhere.getStr()
                                    : LocaleKeys.distance_km.getStrArgs(
                                        args: ['${radiusKm.toInt()}'],
                                      ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.appColors.mainRed,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    AppFormFieldTitle(
                      title: LocaleKeys.volunteer_categories_title.getStr(),
                    ),
                    const SizedBox(height: 8),
                    VolunteerCategorySelector(
                      categoryIds: _categoryIds,
                      onChanged: (categoryIds) {
                        setState(() {
                          _categoryIds = List.from(categoryIds);
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: (MediaQuery.of(context).size.height * 0.06)
                          .clamp(0, 54),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.appColors.mainRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: deactivateButtons ? null : _onSave,
                        child: Text(
                          LocaleKeys.become_volunteer_submit_btn.getStr(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum _VolunteerPageFormFields {
  geoLocation,
  radiusKm,
}
