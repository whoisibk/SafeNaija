import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_colors.dart';
import 'package:mobile/common/utils/extensions.dart';

class OnboardingStepAction extends StatelessWidget {
  const OnboardingStepAction({
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

            // Main Card Visualization
            const Expanded(child: _ActionVisualSection()),

            const SizedBox(height: 32),

            // Text Content
            const _ActionTextSection(),

            const SizedBox(height: 32),

            // Bottom Controls
            _ActionBottomControls(onNext: onNext),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ActionVisualSection extends StatelessWidget {
  const _ActionVisualSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Background Glow/Blur
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.safeTeal.withOp(0.15),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.safeTeal.withOp(0.1),
                  blurRadius: 100,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),

          // Rotated Card Stack
          Transform.rotate(
            angle: -0.05, // Slight rotation (~-3 degrees)
            child: Container(
              width: 330,
              constraints: const BoxConstraints(maxHeight: 580),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.white,
                  width: 8,
                ), // Thick border
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOp(0.15),
                    blurRadius: 50,
                    offset: const Offset(0, 30),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Main Content Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top Bar
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade100),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.campaign,
                                  size: 20,
                                  color: Colors.red.shade400,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'New Report',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppColors.darkSlate.withOp(0.9),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Card Content Body
                        Flexible(
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Option Cards
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFF0FDFC,
                                          ), // Light teal bg
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: AppColors.safeTeal,
                                            width: 2,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.water_drop,
                                              color: AppColors.safeTeal,
                                              size: 28,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Flooding',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.local_police_outlined,
                                              color: Colors.grey.shade400,
                                              size: 28,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Theft',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Placeholder Lines
                                Row(
                                  children: [
                                    Icon(
                                      Icons.my_location,
                                      size: 16,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      height: 10,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 10,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 10,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 10,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),

                                // Dark bottom block visual (Action Button Area)
                                const SizedBox(height: 30),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 60,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Success Notification Overlay - Now INSIDE the card stack
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOp(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border(
                            left: BorderSide(
                              color: Colors.green.shade500,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.green.shade600,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 100,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  width: 60,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTextSection extends StatelessWidget {
  const _ActionTextSection();

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
              TextSpan(text: 'Act When It '),
              TextSpan(
                text: 'Counts',
                style: TextStyle(color: AppColors.safeTeal),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Easily report incidents like theft, harassment, flooding, or unsafe roads. You can report anonymously if you choose.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.darkSlate.withOp(0.7),
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionBottomControls extends StatelessWidget {
  const _ActionBottomControls({required this.onNext});

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
              width: index == 1 ? 24 : 8,
              decoration: BoxDecoration(
                color: index == 1 ? AppColors.safeTeal : Colors.grey[300],
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
