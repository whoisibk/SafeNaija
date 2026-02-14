import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile/common/theme/app_colors.dart';
import 'package:mobile/common/utils/extensions.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      decoration: BoxDecoration(
        color: const Color(0xFF013237), // Dark green background from image
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOp(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              0,
              HugeIcons.strokeRoundedHome01,
              HugeIcons.strokeRoundedHome01,
            ),
            _buildNavItem(
              1,
              HugeIcons.strokeRoundedMaps,
              HugeIcons.strokeRoundedMaps,
            ),
            _buildCenterActionItem(2),
            _buildNavItem(
              3,
              HugeIcons.strokeRoundedNotification01,
              HugeIcons.strokeRoundedNotification01,
            ),
            _buildNavItem(
              4,
              HugeIcons.strokeRoundedUser,
              HugeIcons.strokeRoundedUser,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, dynamic icon, dynamic activeIcon) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: (isSelected ? activeIcon : icon) as List<List<dynamic>>,
              color: isSelected ? Colors.white : Colors.white.withOp(0.5),
              size: 26,
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterActionItem(int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.safeTeal.withOp(0.4),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
