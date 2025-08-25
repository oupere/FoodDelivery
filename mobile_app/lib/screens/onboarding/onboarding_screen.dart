import 'package:flutter/material.dart';
import 'package:mobile_app/screens/home/home_screen.dart';
import 'package:mobile_app/screens/onboarding/onboarding_page1.dart';
import 'package:mobile_app/screens/onboarding/onboarding_page2.dart';
import 'package:mobile_app/screens/onboarding/onboarding_page3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage1(),
    const OnboardingPage2(),
    const OnboardingPage3(),
  ];

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstLaunch', false);
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const HomePage()),
);

  }

  @override
  Widget build(BuildContext context) {
      final loc = AppLocalizations.of(context)!;


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() => _currentPage = page);
                },
                children: _pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      loc.translate('skip'),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Row(
                    children: List.generate(3, (index) => 
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index 
                            ? Theme.of(context).primaryColor 
                            : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  _currentPage == 2
                    ? ElevatedButton(
                        onPressed: _completeOnboarding,
                        child: Text(
                          loc.translate('getStarted'),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          loc.translate('next'),
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}