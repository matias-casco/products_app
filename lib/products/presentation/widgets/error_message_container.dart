import 'package:flutter/material.dart';

class ErrorMessageContainer extends StatelessWidget {
  const ErrorMessageContainer({
    super.key,
    required this.errorMessage,
    this.onRetryPressed,
  });

  final String? errorMessage;
  final void Function()? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(
        12,
        36,
        12,
        14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage ?? 'An error occurred'),
          const SizedBox(
            height: 14,
          ),
          FilledButton(
            onPressed: onRetryPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.error,
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
