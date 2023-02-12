import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/location_tutorial/enum/tutorial_images_enum.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationTutorialPage extends StatelessWidget {
  const LocationTutorialPage._();

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (ctx) => const LocationTutorialPage._(),
      ),
    );
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
              LocaleKeys.how_can_give_access_your_location.getStr(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              LocaleKeys.make_sure_permission_granted_with_instructions
                  .getStr(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              shrinkWrap: true,
              children: [
                _TutorialPlatformCard(
                  title: 'iPhone',
                  iconPath: Assets.icons.appleIcon,
                  children: AppleTutorialImages.values
                      .map(
                        (e) => _PlatformDetails(
                          title: e.title,
                          image: e.getImage,
                        ),
                      )
                      .toList(),
                ),
                _TutorialPlatformCard(
                  title: 'Android',
                  iconPath: Assets.icons.androidIcon,
                  children: AndroidTutorialImages.values
                      .map(
                        (e) => _PlatformDetails(
                          title: e.title,
                          image: e.getImage,
                        ),
                      )
                      .toList(),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    LocaleKeys.make_sure_permission_granted_on_browser.getStr(),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                const Divider(),
                _TutorialPlatformCard(
                  title: 'Chrome',
                  iconPath: Assets.icons.chromeIcon,
                  children: ChromeTutorialImages.values
                      .map(
                        (e) => _PlatformDetails(
                          title: e.title,
                          image: e.getImage,
                        ),
                      )
                      .toList(),
                ),
                _TutorialPlatformCard(
                  title: 'Safari',
                  iconPath: Assets.icons.safariIcon,
                  children: SafariTutorialImages.values
                      .map(
                        (e) => _PlatformDetails(
                          title: e.title,
                          image: e.getImage,
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformDetails extends StatelessWidget {
  const _PlatformDetails({
    required this.title,
    required this.image,
  });
  final String title;
  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 6),
          Image(image: image),
        ],
      ),
    );
  }
}

class _TutorialPlatformCard extends StatelessWidget {
  const _TutorialPlatformCard({
    required this.title,
    required this.children,
    required this.iconPath,
  });
  final String title;
  final List<Widget> children;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        collapsedTextColor: Theme.of(context).textTheme.bodyMedium?.color,
        childrenPadding: const EdgeInsets.all(12),
        title: Row(
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 10.83),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        children: children,
      ),
    );
  }
}
