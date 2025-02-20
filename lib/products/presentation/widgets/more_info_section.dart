import 'package:flutter/material.dart';

class MoreInfoSection extends StatelessWidget {
  const MoreInfoSection({
    super.key,
    required this.infoTexts,
  });

  final List<String> infoTexts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More info',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 6,
        ),
        for (var info in infoTexts)
          Column(
            children: [
              Text(
                info,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
      ],
    );
  }
}
