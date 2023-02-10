import 'package:flutter/material.dart';

class DemandTitle extends StatelessWidget {
  const DemandTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        'Yardım Talepleri',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
