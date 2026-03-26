import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'onboarding_screen_2.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _heartBeatController;

  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  late Animation<double> _scaleIn;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _heartBeatAnimation;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _heartBeatController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _scaleIn = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _floatingAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(
        parent: _floatingController,
        curve: Curves.easeInOut,
      ),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _heartBeatAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _heartBeatController,
        curve: Curves.easeInOut,
      ),
    );

    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    _heartBeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE8DE),
              Color(0xFFFFF5F1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _mainController,
              _floatingController,
              _pulseController,
              _heartBeatController,
            ]),
            builder: (context, child) {
              return Column(
                children: [
                  const SizedBox(height: 20),

                  // Illustration Section
                  Expanded(
                    flex: 5,
                    child: Transform.translate(
                      offset: Offset(0, _floatingAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeIn,
                        child: ScaleTransition(
                          scale: _scaleIn,
                          child: _buildIllustration(),
                        ),
                      ),
                    ),
                  ),

                  // Page Indicator
                  FadeTransition(
                    opacity: _fadeIn,
                    child: _buildPageIndicator(),
                  ),

                  const SizedBox(height: 30),

                  // Text Content
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          SlideTransition(
                            position: _slideUp,
                            child: FadeTransition(
                              opacity: _fadeIn,
                              child: const Text(
                                'Care That Feels Close',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A2E),
                                  letterSpacing: -0.5,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SlideTransition(
                            position: _slideUp,
                            child: FadeTransition(
                              opacity: _fadeIn,
                              child: Text(
                                'Stay connected with your family and caregivers while managing your daily health with ease.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5),
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Buttons
                  FadeTransition(
                    opacity: _fadeIn,
                    child: _buildButtons(),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background glow
        Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFFFB5A0).withOpacity(0.2),
                  const Color(0xFFFFB5A0).withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Floating elements
        Positioned(
          top: 20,
          left: 40,
          child: _buildFloatingIcon(
            Icons.favorite,
            const Color(0xFFFF6B6B),
            delay: 0,
          ),
        ),
        Positioned(
          top: 60,
          right: 30,
          child: _buildFloatingIcon(
            Icons.family_restroom,
            const Color(0xFFFF8E53),
            delay: 0.3,
          ),
        ),
        Positioned(
          bottom: 80,
          left: 30,
          child: _buildFloatingIcon(
            Icons.health_and_safety,
            const Color(0xFF4ECDC4),
            delay: 0.5,
          ),
        ),
        Positioned(
          bottom: 40,
          right: 50,
          child: _buildFloatingIcon(
            Icons.notifications_active,
            const Color(0xFFFFBE0B),
            delay: 0.7,
          ),
        ),

        // Main illustration - Family & Care Circle
        Center(
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFB5A0),
                  Color(0xFFFF8E53),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E53).withOpacity(0.4),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Inner white circle
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),

                // Family icons arranged in circle
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top person (elderly/parent)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.elderly,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Connection line with heart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 2,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        Transform.scale(
                          scale: _heartBeatAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite,
                              size: 20,
                              color: Color(0xFFFF6B6B),
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 2,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Bottom row - caregivers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Connection badge
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.link,
                      size: 18,
                      color: Color(0xFF4ECDC4),
                    ),
                  ),
                ),

                // Health badge
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.monitor_heart,
                      size: 18,
                      color: Color(0xFFFF6B6B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color, {required double delay}) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final delayedValue = math.sin((_floatingController.value + delay) * math.pi * 2) * 6;
        return Transform.translate(
          offset: Offset(0, delayedValue),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == 0 ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == 0
                ? const Color(0xFF1A1A2E)
                : const Color(0xFF1A1A2E).withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Skip Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                // TODO: Skip to main screen
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: const Color(0xFF1A1A2E).withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Next Button
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const OnboardingScreen2(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        )),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 400),
                  ),
                );
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1A1A2E).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
