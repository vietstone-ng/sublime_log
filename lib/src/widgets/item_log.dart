import 'package:flutter/material.dart';

class ItemLog extends StatelessWidget {
  const ItemLog({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFF2F2F4),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.28,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
