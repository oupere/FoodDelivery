import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/screens/home/home_screen.dart';
import 'package:mobile_app/config/theme.dart';

class AppOnboardingScreen extends StatefulWidget {
  const AppOnboardingScreen({super.key});
  @override
  State<AppOnboardingScreen> createState() => _AppOnboardingScreenState();
}

class _AppOnboardingScreenState extends State<AppOnboardingScreen> {
  final PageController _controller = PageController();
  int _current = 0;
  Timer? _timer;
  bool _isLastPage = false;

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      final nextPage = _current < 2 ? _current + 1 : 0;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCirc,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstLaunch', false);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final pages = [
      _buildPage(context, 'assets/onboarding/onboarding1.png',
          loc.translate('onboardingTitle1'), loc.translate('onboardingDesc1')),
      _buildPage(context, 'assets/onboarding/onboarding2.png',
          loc.translate('onboardingTitle2'), loc.translate('onboardingDesc2')),
      _buildPage(context, 'assets/onboarding/onboarding3.png',
          loc.translate('onboardingTitle3'), loc.translate('onboardingDesc3')),
    ];

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (idx) {
                setState(() {
                  _current = idx;
                  _isLastPage = idx == pages.length - 1;
                });
              },
              itemBuilder: (_, i) => pages[i],
            ),
            
            // Bouton Get Started (toujours visible)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isLastPage ? size.width * 0.7 : size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isLastPage) {
                        _completeOnboarding();
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white, // Texte en blanc
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      shadowColor: theme.primaryColor.withOpacity(0.3),
                    ),
                    child: Text(
                      loc.translate('getStarted'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.white, // Assurance supplémentaire
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Indicateurs de progression
            Positioned(
              bottom: 110,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: _current == i ? 20 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: _current == i
                          ? theme.primaryColor
                          : Colors.grey.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, String imagePath, String title, String desc) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image sans restriction de forme
          SizedBox(
            height: size.height * 0.35, // Hauteur réduite
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.9, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Image.asset(
                imagePath, 
                width: size.width * 0.8,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20), // Espace réduit
          
          // Titre avec animation de fondu
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(1, 1),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 15), // Espace réduit
          
          // Description avec animation de fondu
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 700),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}