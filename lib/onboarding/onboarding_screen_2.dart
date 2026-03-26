import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'onboarding_screen_3.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _bellController;

  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  late Animation<double> _scaleIn;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _bellShakeAnimation;

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

    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _bellController = AnimationController(
      duration: const Duration(milliseconds: 500),
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

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _bellShakeAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _bellController,
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
    _rotateController.dispose();
    _bellController.dispose();
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
              _rotateController,
              _bellController,
            ]),
            builder: (context, child) {
              return Column(
                children: [
                  // Back button
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FadeTransition(
                        opacity: _fadeIn,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

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
                                'Stay Healthy Every Day',
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
                                'Get gentle reminders for medicines, daily routines, hydration, and wellness activities.',
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
                  const Color(0xFF4ECDC4).withOpacity(0.15),
                  const Color(0xFF4ECDC4).withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Rotating orbit ring
        Transform.rotate(
          angle: _rotateController.value * 2 * math.pi,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF4ECDC4).withOpacity(0.2),
                width: 2,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
          ),
        ),

        // Second orbit ring
        Transform.rotate(
          angle: -_rotateController.value * 2 * math.pi * 0.5,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFB5A0).withOpacity(0.15),
                width: 1.5,
              ),
            ),
          ),
        ),

        // Floating reminder icons
        // Bell/Notification - top
        Positioned(
          top: 15,
          child: Transform.rotate(
            angle: _bellShakeAnimation.value,
            child: _buildFloatingCard(
              icon: Icons.notifications_active,
              color: const Color(0xFFFFBE0B),
              label: 'Reminder',
            ),
          ),
        ),

        // Medicine - right
        Positioned(
          right: 10,
          top: 100,
          child: _buildFloatingIcon(
            Icons.medication_rounded,
            const Color(0xFFFF6B6B),
            delay: 0.2,
          ),
        ),

        // Water - left
        Positioned(
          left: 10,
          top: 80,
          child: _buildFloatingIcon(
            Icons.water_drop,
            const Color(0xFF2196F3),
            delay: 0.4,
          ),
        ),

        // Walking - bottom left
        Positioned(
          left: 30,
          bottom: 60,
          child: _buildFloatingIcon(
            Icons.directions_walk,
            const Color(0xFF4CAF50),
            delay: 0.6,
          ),
        ),

        // Sleep - bottom right
        Positioned(
          right: 30,
          bottom: 80,
          child: _buildFloatingIcon(
            Icons.bedtime_rounded,
            const Color(0xFF9C27B0),
            delay: 0.8,
          ),
        ),

        // Main center circle - Calendar/Clock
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4ECDC4),
                  Color(0xFF44A08D),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4ECDC4).withOpacity(0.4),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Inner circle
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),

                // Calendar icon with checkmarks
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMiniCheck(true),
                        const SizedBox(width: 6),
                        _buildMiniCheck(true),
                        const SizedBox(width: 6),
                        _buildMiniCheck(false),
                      ],
                    ),
                  ],
                ),

                // Clock badge
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(10),
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
                      Icons.access_time_filled,
                      size: 20,
                      color: Color(0xFF4ECDC4),
                    ),
                  ),
                ),

                // Streak badge
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 16,
                          color: Color(0xFFFF6B6B),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '7',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
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

  Widget _buildMiniCheck(bool isChecked) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isChecked ? Colors.white : Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: isChecked
          ? const Icon(
              Icons.check,
              size: 14,
              color: Color(0xFF4ECDC4),
            )
          : null,
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color, {required double delay}) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final delayedValue =
            math.sin((_floatingController.value + delay) * math.pi * 2) * 8;
        return Transform.translate(
          offset: Offset(0, delayedValue),
          child: Container(
            padding: const EdgeInsets.all(14),
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
              size: 24,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingCard({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final delayedValue =
            math.sin(_floatingController.value * math.pi * 2) * 6;
        return Transform.translate(
          offset: Offset(0, delayedValue),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
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
          width: index == 1 ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == 1
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
                        const OnboardingScreen3(),
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
