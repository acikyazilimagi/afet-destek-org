import 'package:deprem_destek/data/models/demand.dart';
import 'package:flutter/material.dart';

class DemandWidget extends StatelessWidget {
  const DemandWidget({super.key, required this.demand});

  final Demand demand;

  Widget get heightGap => const SizedBox(
        height: 8,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF0F0F0)),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: const SizedBox(
              height: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      demand.addressText,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      '', //TODO: Talep saati eklenecek
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                heightGap,
                Text(
                  demand.notes,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
                heightGap,
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 8,
                  children: List.generate(
                    demand.categoryIds.length,
                    (index) => DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFD0D5DD),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: Text(
                          demand.categoryIds[index],
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                ),
                heightGap,
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Detay'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
