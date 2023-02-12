import 'package:afet_destek/gen/assets.gen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage._();

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (ctx) => const AboutPage._(),
      ),
    );
  }

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? version;
  String? buildNumber;

  @override
  void initState() {
    super.initState();
    setPackageInfo();
  }

  Future<void> setPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(Assets.logoSvg),
          )
        ],
        leadingWidth: 52,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Hakkımızda',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              shrinkWrap: true,
              children: [
                const _AboutCard(
                  title: 'Biz Kimiz?',
                  initiallyExpanded: true,
                  children: [
                    Divider(
                      height: 0,
                    ),
                    _AboutDetail(
                      text: whoWeAreText,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const _AboutCard(
                  title: 'Ne yapıyoruz?',
                  children: [
                    Divider(
                      height: 0,
                    ),
                    _AboutDetail(
                      text: whatWeDoText,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const _AboutCard(
                  title: 'Amacımız Nedir?',
                  children: [
                    Divider(
                      height: 0,
                    ),
                    _AboutDetail(
                      text: whatIsOurGoalText,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const _AboutCard(
                  title: 'Diğer uygulamalardan farkımız?',
                  children: [
                    Divider(
                      height: 0,
                    ),
                    _AboutDetail(
                      text: whatIsDifferentText,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const _AboutCard(
                  title: 'İletişim Bilgileri',
                  children: [
                    Divider(
                      height: 0,
                    ),
                    _AboutDetail(
                      text: 'Tel:',
                      value: '+90 (555) 555 5555',
                    ),
                    _AboutDetail(
                      text: 'Mail:',
                      value: 'test@test.com',
                    ),
                    _AboutDetail(
                      text: contactInfoText,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const _AboutCard(
                  title: 'Sosyal medya bilgileri',
                  children: [
                    Divider(
                      height: 0,
                    ),
                    _AboutDetail(
                      text: 'Facebook:',
                      value: '-',
                    ),
                    _AboutDetail(
                      text: 'Instagram:',
                      value: '-',
                    ),
                    _AboutDetail(
                      text: 'Twitter:',
                      value: '-',
                    ),
                    _AboutDetail(
                      text: 'Linkedin:',
                      value: '-',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _AboutCard(
                  title: 'Uygulama Sürümü',
                  children: [
                    const Divider(
                      height: 0,
                    ),
                    _AboutDetail(
                      text: 'Sürüm:',
                      value: version ?? '-',
                    ),
                    _AboutDetail(
                      text: 'Derleme:',
                      value: buildNumber ?? '-',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutDetail extends StatelessWidget {
  const _AboutDetail({required this.text, this.value});
  final String text;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: value == null
          ? Text(
              text,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            )
          : Row(
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(width: 5),
                if (value != null)
                  Text(
                    value!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                  ),
              ],
            ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
  });
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        collapsedTextColor: Theme.of(context).textTheme.bodyMedium?.color,
        initiallyExpanded: initiallyExpanded,
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        tilePadding: const EdgeInsets.only(left: 16, right: 16),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        children: children,
      ),
    );
  }
}

const String whoWeAreText =
    '''Biz yazılım geliştiriciler, ürün yöneticileri, tasarımcılar ve içerik üreticileri olarak ihtiyaca yönelik toplanmış gönüllü bir ekibiz.''';
const String whatWeDoText =
    '''İnsanların eşya ihtiyaçlarını paylaşarak, yardım etmek isteyen kişilerin bu ihtiyaçları karşılamasını sağlayan bir platform geliştiriyoruz.''';
const String whatIsOurGoalText =
    '''İnsanlar arasındaki yardımlaşmayı teşvik etmek ve insanların eşya ihtiyaçlarını paylaşarak, yardım etmek isteyen kişilerin bu ihtiyaçları karşılamasına yardımcı olmak amacıyla bir platform sunuyoruz.''';
const String whatIsDifferentText =
    '''Paylaşılan yardım ihtiyaçlarının konum uzaklığına göre değerlendirilip yardım severin ulaşabiliceği en yakın ihtiyacı karşılaması sağlanmaktadır.''';
const String contactInfoText =
    '''Acil bir durum olmadığı sürece mail ile iletişime geçmenizi rica ediyoruz.''';
