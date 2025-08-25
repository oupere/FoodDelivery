import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;


    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/onboarding/onboarding1.png',
              height: 220,
              width: 220,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Text(
  loc.translate('onboardingTitle1'),
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontWeight: FontWeight.bold,
    color: Theme.of(context).primaryColor,
  ),
),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              loc.translate('onboardingDesc1'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}