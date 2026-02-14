import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_colors.dart';

enum ToastType { success, warning, error, info }

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    required this.type,
    required this.title,
    required this.onDismiss,
    super.key,
    this.message,
  });

  final ToastType type;
  final String title;
  final String? message;
  final VoidCallback onDismiss;

  Color get _color {
    switch (type) {
      case ToastType.success:
        return AppColors.safetyGreen;
      case ToastType.warning:
        return AppColors.warningOrange;
      case ToastType.error:
        return AppColors.emergencyRed;
      case ToastType.info:
        return AppColors.infoBlue;
    }
  }

  IconData get _icon {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.warning:
        return Icons.warning_amber_rounded;
      case ToastType.error:
        return Icons.error_outline;
      case ToastType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: _color,
            width: 4,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(_icon, color: _color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.darkSlate,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    message!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.slateGrey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(
              Icons.close,
              color: AppColors.neutralGrey,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
