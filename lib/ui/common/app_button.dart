import 'package:flutter/material.dart';
import 'package:todo/ui/common/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool? isEnabled;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isEnabled! ? Theme.of(context).colorScheme.primary : kcPrimaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      onPressed: isEnabled! ? () => onPressed() : null,
      child: Text(label),
    );
  }
}
