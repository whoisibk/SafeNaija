import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/modules/onboarding/widgets/onboarding_step_awareness.dart';
import 'package:mobile/modules/onboarding/widgets/onboarding_step_action.dart';
import 'package:mobile/modules/onboarding/widgets/onboarding_step_support.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    debugPrint('_onNext called, currentIndex: $_currentIndex');
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/auth');
    }
  }

  void _onSkip() {
    debugPrint('_onSkip called');
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              OnboardingStepAwareness(onNext: _onNext, onSkip: _onSkip),
              OnboardingStepAction(onNext: _onNext, onSkip: _onSkip),
              OnboardingStepSupport(
                onGetStarted: _onNext,
                onSkip: _onSkip,
              ), // Reuse onNext for get started logic
            ],
          ),
          // We can put shared indicators or buttons here if they float above everything,
          // but the designs show buttons integrated into the flow, so we'll pass callbacks.
        ],
      ),
    );
  }
}
