import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_colors.dart';
import 'package:mobile/common/utils/extensions.dart';

class OnboardingStepSupport extends StatelessWidget {
  const OnboardingStepSupport({
    required this.onGetStarted,
    required this.onSkip,
    super.key,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const Spacer(),

            // Main Visual
            const Expanded(
              flex: 4,
              child: _SupportVisualSection(),
            ),

            const SizedBox(height: 24),

            // Chips
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SupportChip(icon: Icons.my_location, label: 'Live Location'),
                SizedBox(width: 12),
                _SupportChip(
                  icon: Icons.diversity_3,
                  label: 'Trusted Contacts',
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Text Content
            const _SupportTextSection(),

            const SizedBox(height: 32),

            // Bottom Indicators and Button
            _SupportBottomControls(onGetStarted: onGetStarted),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SupportVisualSection extends StatelessWidget {
  const _SupportVisualSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Glow
        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: AppColors.safeTeal.withOp(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.safeTeal.withOp(0.2),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
        ),
        // Rings
        Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.safeTeal.withOp(0.1),
              width: 1,
            ),
          ),
        ),
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.withOp(0.2),
              width: 1,
            ),
          ),
        ),
        // Shield Icon Main
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOp(0.08),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.shield,
              size: 120,
              color: AppColors.safeTeal,
            ),
          ),
        ),
        const Center(
          child: Icon(
            Icons.diversity_1,
            size: 48,
            color: AppColors.white,
          ),
        ),
        // Floating bubbles
        const Positioned(
          top: 40,
          right: 20,
          child: _FloatingIcon(icon: Icons.share_location),
        ),
        const Positioned(
          bottom: 60,
          left: 20,
          child: _FloatingIcon(
            icon: Icons.favorite,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class _SupportTextSection extends StatelessWidget {
  const _SupportTextSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          const TextSpan(
            children: [
              TextSpan(text: "You're Not "),
              TextSpan(
                text: 'Alone',
                style: TextStyle(color: AppColors.safeTeal),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            height: 1.15,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Share your live location or send an SOS alert to trusted contacts when you feel unsafe.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.darkSlate.withOp(0.7),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _SupportBottomControls extends StatelessWidget {
  const _SupportBottomControls({required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: index == 2 ? 24 : 8,
              decoration: BoxDecoration(
                color: index == 2 ? AppColors.safeTeal : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onGetStarted,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.safeTeal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  const _FloatingIcon({
    required this.icon,
    this.color = AppColors.safeTeal,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOp(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _SupportChip extends StatelessWidget {
  const _SupportChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOp(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.safeTeal),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.neutralGrey,
            ),
          ),
        ],
      ),
    );
  }
}
