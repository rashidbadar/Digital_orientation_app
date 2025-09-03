import 'package:flutter/material.dart';
import 'custom_button.dart';

class GridItem extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onTap;
  final VoidCallback onButtonPressed;

  const GridItem({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onTap,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title Section
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              // Button Section
              CustomButton(
                title: buttonText,
                onPressed: onButtonPressed,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
