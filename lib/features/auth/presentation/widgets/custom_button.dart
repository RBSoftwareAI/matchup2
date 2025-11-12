import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

/// Custom button widget with consistent styling
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isEnabled && !widget.isLoading 
          ? (_) => setState(() => _isPressed = true) 
          : null,
      onTapUp: widget.isEnabled && !widget.isLoading 
          ? (_) => setState(() => _isPressed = false) 
          : null,
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width ?? double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: widget.isEnabled && !widget.isLoading
              ? (_isPressed ? AppColors.primaryPressed : AppColors.primary)
              : AppColors.textMuted,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: widget.isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  widget.text,
                  style: AppTextStyles.button,
                ),
        ),
      ),
    );
  }
}
