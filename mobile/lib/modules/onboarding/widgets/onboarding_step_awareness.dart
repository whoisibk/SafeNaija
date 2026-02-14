import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_colors.dart';
import 'package:mobile/common/utils/extensions.dart';

class OnboardingStepAwareness extends StatelessWidget {
  const OnboardingStepAwareness({
    required this.onNext,
    required this.onSkip,
    super.key,
  });

  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: onSkip,
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkSlate.withOp(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(child: _AwarenessMapSection()),
            const SizedBox(height: 32),
            const _AwarenessTextSection(),
            const SizedBox(height: 32),
            _AwarenessBottomControls(onNext: onNext),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _AwarenessMapSection extends StatelessWidget {
  const _AwarenessMapSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOp(0.1),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
            border: Border.all(color: Colors.white, width: 4),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            'assets/images/map.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Positioned(
          top: 40,
          right: -10,
          child: _GlassCard(
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.red,
            label: 'ALERT',
            value: 'Flooding',
            iconBgColor: Colors.red.withOp(0.1),
          ),
        ),
        Positioned(
          bottom: 40,
          left: -10,
          child: _GlassCard(
            icon: Icons.verified_user_outlined,
            iconColor: AppColors.safeTeal,
            label: 'STATUS',
            value: 'Safe Zone',
            iconBgColor: AppColors.safeTeal.withOp(0.1),
          ),
        ),
      ],
    );
  }
}

class _AwarenessTextSection extends StatelessWidget {
  const _AwarenessTextSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              height: 1.15,
            ),
            children: const [
              TextSpan(text: 'See What '),
              TextSpan(
                text: 'Matters',
                style: TextStyle(color: AppColors.safeTeal),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'See real-time safety reports in your area. Make better decisions about where you go and how you get there.',
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

class _AwarenessBottomControls extends StatelessWidget {
  const _AwarenessBottomControls({required this.onNext});

  final VoidCallback onNext;

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
              width: index == 0 ? 24 : 8,
              decoration: BoxDecoration(
                color: index == 0 ? AppColors.safeTeal : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onNext,
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
                  'Next',
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

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.iconBgColor,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
      decoration: BoxDecoration(
        color: Colors.white.withOp(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOp(0.6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOp(0.06),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.slateGrey,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkSlate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
