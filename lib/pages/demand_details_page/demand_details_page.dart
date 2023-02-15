import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/demands_page/widgets/demand_card.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:afet_destek/shared/widgets/loader.dart';
import 'package:afet_destek/shared/widgets/responsive_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandDetailsPage extends StatefulWidget {
  const DemandDetailsPage({super.key, required this.demandId});
  final String demandId;

  // static Future<void> show(
  //   BuildContext context, {
  //   required String demandId,
  // }) async {
  //   await Navigator.of(context).push<bool>(
  //     MaterialPageRoute<bool>(
  //       builder: (context) {
  //         return DemandDetailsPage._(demandId: demandId);
  //       },
  //     ),
  //   );
  // }

  @override
  State<DemandDetailsPage> createState() => _DemandDetailsPageState();
}

class _DemandDetailsPageState extends State<DemandDetailsPage> {
  Demand? _demand;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        try {
          _demand = await context
              .read<DemandsRepository>()
              .getDemand(demandId: widget.demandId);
        } catch (_) {}
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Loader());
    }

    return _DemandDetailsPageView(
      demand: _demand,
    );
  }
}

class _DemandDetailsPageView extends StatelessWidget {
  const _DemandDetailsPageView({
    required this.demand,
  });
  final Demand? demand;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const ResponsiveAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 800,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (size.width >= 1000)
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      Text(
                        LocaleKeys.demand_details.getStr(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xff101828),
                        ),
                      )
                    ],
                  ),
                  if (demand == null) ...[
                    const SizedBox(height: 32),
                    Row(
                      children: const [
                        Expanded(
                          child: Text(
                            '''Talep bulunamadı. Talebin sahibi talebi silmiş olabilir.''',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const SizedBox(height: 16),
                    DemandCard(
                      demand: demand!,
                      isDetailed: true,
                    ),
                    const SizedBox(height: 32),
                    const Center(
                      child: Text(
                        '''Bu yardım talebini paylaşmak için aşağıdaki linki kopayalabilirsiniz.''',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SelectableText(
                        'https://afetdestek.org/demand/${demand!.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
