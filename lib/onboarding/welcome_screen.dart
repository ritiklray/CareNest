import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'role_selection_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _waveController;

  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  late Animation<double> _scaleIn;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

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
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

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

    _floatingAnimation = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(
        parent: _floatingController,
        curve: Curves.easeInOut,
      ),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
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
    _waveController.dispose();
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
              _waveController,
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

                  // Header Title
                  FadeTransition(
                    opacity: _fadeIn,
                    child: const Text(
                      'Welcome to CareNest',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  FadeTransition(
                    opacity: _fadeIn,
                    child: Text(
                      'Your space for care, safety, and connection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Illustration Section
                  Expanded(
                    flex: 5,
                    child: Transform.translate(
                      offset: Offset(0, _floatingAnimation.value * 0.5),
                      child: FadeTransition(
                        opacity: _fadeIn,
                        child: ScaleTransition(
                          scale: _scaleIn,
                          child: _buildIllustration(),
                        ),
                      ),
                    ),
                  ),

                  // Description Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: SlideTransition(
                      position: _slideUp,
                      child: FadeTransition(
                        opacity: _fadeIn,
                        child: Text(
                          'CareNest helps elders stay healthy and independent while keeping family and caregivers connected and informed.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.55),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Get Started Button
                  FadeTransition(
                    opacity: _fadeIn,
                    child: _buildGetStartedButton(),
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
        // Background gradient circle
        Container(
          width: 320,
          height: 320,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFFFFD4C4).withOpacity(0.5),
                const Color(0xFFFFE8DE).withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Ground/Path
        Positioned(
          bottom: 40,
          child: Container(
            width: 280,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF8BC34A).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // Floating decorative elements
        Positioned(
          top: 10,
          left: 50,
          child: _buildFloatingIcon(
            Icons.favorite,
            const Color(0xFFFF6B6B),
            0,
          ),
        ),
        Positioned(
          top: 30,
          right: 40,
          child: _buildFloatingIcon(
            Icons.home_filled,
            const Color(0xFF4ECDC4),
            0.3,
          ),
        ),
        Positioned(
          bottom: 90,
          left: 25,
          child: _buildFloatingIcon(
            Icons.health_and_safety,
            const Color(0xFF4CAF50),
            0.5,
          ),
        ),
        Positioned(
          bottom: 100,
          right: 30,
          child: _buildFloatingIcon(
            Icons.notifications_active,
            const Color(0xFFFFBE0B),
            0.7,
          ),
        ),

        // Small decorative circles
        Positioned(
          top: 80,
          left: 30,
          child: _buildDecorativeCircle(12, const Color(0xFFFF8E53)),
        ),
        Positioned(
          top: 60,
          right: 60,
          child: _buildDecorativeCircle(8, const Color(0xFF89CFF0)),
        ),
        Positioned(
          bottom: 130,
          right: 50,
          child: _buildDecorativeCircle(10, const Color(0xFFFF6B6B)),
        ),

        // Main characters - Caregiver and Elder walking together
        Center(
          child: Transform.translate(
            offset: Offset(0, _floatingAnimation.value * 0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Caregiver (younger person)
                _buildCaregiver(),
                const SizedBox(width: 5),
                // Elder (older person with support)
                _buildElder(),
              ],
            ),
          ),
        ),

        // Connection heart between them
        Positioned(
          top: 70,
          child: Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6B6B).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite,
                color: Color(0xFFFF6B6B),
                size: 26,
              ),
            ),
          ),
        ),

        // "Together" badge
        Positioned(
          bottom: 70,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF4CAF50),
                    size: 14,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Care Together',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaregiver() {
    return SizedBox(
      width: 100,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Body
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                // Head
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8B89D),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      // Hair
                      Positioned(
                        top: 0,
                        left: 5,
                        right: 5,
                        child: Container(
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFF5D4037),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                        ),
                      ),
                      // Face
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3E2723),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3E2723),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Smile
                      Positioned(
                        bottom: 8,
                        left: 15,
                        right: 15,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: const Color(0xFF3E2723).withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                // Torso with yellow shirt
                Container(
                  width: 55,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFBE0B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // Legs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF37474F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF37474F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Hand reaching to elder
          Positioned(
            right: 0,
            top: 80,
            child: Container(
              width: 35,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFE8B89D),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElder() {
    return SizedBox(
      width: 90,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                // Head
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8B89D),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      // Gray/White hair
                      Positioned(
                        top: 0,
                        left: 5,
                        right: 5,
                        child: Container(
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBDBDBD),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      // Eyes
                      Positioned(
                        bottom: 12,
                        left: 10,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3E2723),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 10,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3E2723),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Glasses
                      Positioned(
                        bottom: 10,
                        left: 6,
                        right: 6,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF5D4037),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                // Torso with cardigan/vest
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9575CD),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Cardigan opening
                    Positioned(
                      top: 5,
                      left: 15,
                      right: 15,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB39DDB),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                // Legs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 18,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5D4037),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 18,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5D4037),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Walking cane
          Positioned(
            right: 5,
            bottom: 0,
            child: Transform.rotate(
              angle: 0.15,
              child: Container(
                width: 8,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF8D6E63),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 20,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6D4C41),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Hand being held
          Positioned(
            left: 0,
            top: 75,
            child: Container(
              width: 30,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFE8B89D),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircle(double size, Color color) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            math.sin(_floatingController.value * math.pi * 2) * 3,
            math.cos(_floatingController.value * math.pi * 2) * 3,
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color, double delay) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final delayedValue =
            math.sin((_floatingController.value + delay) * math.pi * 2) * 8;
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

  Widget _buildGetStartedButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const RoleSelectionScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    )),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        },
        child: Container(
          width: double.infinity,
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
              'Get Started',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
