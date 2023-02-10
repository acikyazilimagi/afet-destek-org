import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/pages/demand_details_page/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactsGroupWidget extends StatelessWidget {
  const ContactsGroupWidget({
    super.key,
    required this.demand,
  });

  final Demand demand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(
          height: 15,
        ),
        if (demand.whatsappNumber != null) ...[
          Column(
            children: [
              PhoneDetailText(
                phone: '${demand.whatsappNumber}',
                icon: const Icon(
                  FontAwesomeIcons.whatsapp,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ContactButtons(
                copyButton: CopyButton(
                  phoneNumber: '${demand.whatsappNumber}',
                ),
                actionButton: WhatsappButton(
                  phoneNumber: '${demand.whatsappNumber}',
                ),
              ),
            ],
          ),
        ],
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            PhoneDetailText(
              phone: demand.phoneNumber,
              icon: const Icon(
                Icons.phone_outlined,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ContactButtons(
              copyButton: CopyButton(
                phoneNumber: demand.phoneNumber,
              ),
              actionButton: SMSButton(
                phoneNumber: demand.phoneNumber,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
