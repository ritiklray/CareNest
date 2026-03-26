import 'package:flutter/material.dart';

class CircleVerifiedScreen extends StatefulWidget {
  const CircleVerifiedScreen({super.key});

  @override
  State<CircleVerifiedScreen> createState() => _CircleVerifiedScreenState();
}

class _CircleVerifiedScreenState extends State<CircleVerifiedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  late Animation<double> _scaleUp;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _scaleUp = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: Row(
                    children: [
                      GestureDetector(
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
                      const SizedBox(width: 16),
                      const Text(
                        'Circle Verified',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

                      // Success Illustration
                      FadeTransition(
                        opacity: _fadeIn,
                        child: ScaleTransition(
                          scale: _scaleUp,
                          child: Container(
                            width: 300,
                            height: 200,
                            child: _buildSuccessIllustration(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Title
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideUp,
                          child: const Text(
                            'You\'re Connected!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A2E),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Subtitle
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideUp,
                          child: Text(
                            'Your family care circle is ready. Everyone can now stay updated and coordinate care together.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.6),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

              // Bottom Actions
              FadeTransition(
                opacity: _fadeIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Go to Home Button
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to main home screen
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
                              'Go to Home',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Invite more members
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to invite members screen
                        },
                        child: Text(
                          'Invite more members',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Main background with gradient
        Positioned(
          child: Container(
            width: 280,
            height: 180,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8F5E8),
                  Color(0xFFF0F8F0),
                ],
              ),
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ),

        // Success circle background
        Positioned(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Success checkmark circle
        Positioned(
          top: 0,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4CAF50),
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),

        // Connection line
        Positioned(
          top: 55,
          child: Container(
            width: 140,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Caregiver (left - standing person with caring gesture)
        Positioned(
          left: 30,
          bottom: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Head with smile
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFDBB5),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    // Hair
                    Positioned(
                      top: 1,
                      left: 3,
                      right: 3,
                      child: Container(
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8B4513),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    // Eyes
                    Positioned(
                      top: 10,
                      left: 8,
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 8,
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Smile
                    Positioned(
                      bottom: 8,
                      left: 10,
                      child: Container(
                        width: 12,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B6B),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Body with caring pose
              Container(
                width: 38,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF4ECDC4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    // Heart symbol on shirt
                    Positioned(
                      top: 12,
                      left: 14,
                      child: Container(
                        width: 10,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: CustomPaint(
                          painter: HeartPainter(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              // Legs
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3E50),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 12,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3E50),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Elder (right - sitting peacefully)
        Positioned(
          right: 35,
          bottom: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Head with gentle expression
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFDBB5),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    // Gray hair
                    Positioned(
                      top: 1,
                      left: 3,
                      right: 3,
                      child: Container(
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD5D5D5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    // Eyes (peaceful)
                    Positioned(
                      top: 10,
                      left: 7,
                      child: Container(
                        width: 2,
                        height: 2,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 7,
                      child: Container(
                        width: 2,
                        height: 2,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Gentle smile
                    Positioned(
                      bottom: 6,
                      left: 9,
                      child: Container(
                        width: 12,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B6B),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Body (seated position)
              Container(
                width: 35,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 3),
              // Chair
              Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xFF8D6E63),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),

        // Connection hearts floating between them
        Positioned(
          top: 75,
          left: 110,
          child: Container(
            width: 12,
            height: 10,
            child: CustomPaint(
              painter: HeartPainter(color: const Color(0xFFFF6B9D)),
            ),
          ),
        ),
        Positioned(
          top: 90,
          left: 130,
          child: Container(
            width: 8,
            height: 7,
            child: CustomPaint(
              painter: HeartPainter(color: const Color(0xFFFF8A80)),
            ),
          ),
        ),
        Positioned(
          top: 105,
          left: 120,
          child: Container(
            width: 6,
            height: 5,
            child: CustomPaint(
              painter: HeartPainter(color: const Color(0xFFFFC1CC)),
            ),
          ),
        ),

        // Care symbols around
        Positioned(
          top: 25,
          left: 50,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF64B5F6).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite,
              size: 12,
              color: Color(0xFF1976D2),
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 45,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: const Color(0xFFAED581).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety,
              size: 10,
              color: Color(0xFF388E3C),
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 45,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFFFAB91).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.support_agent,
              size: 9,
              color: Color(0xFFFF5722),
            ),
          ),
        ),
      ],
    );
  }
}

class WheelchairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF455A64)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = const Color(0xFF455A64)
      ..style = PaintingStyle.fill;

    // Wheel (large circle)
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.7),
      12,
      paint,
    );

    // Small front wheel
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.8),
      5,
      fillPaint,
    );

    // Wheelchair frame
    final framePath = Path();
    framePath.moveTo(size.width * 0.4, size.height * 0.3);
    framePath.lineTo(size.width * 0.6, size.height * 0.3);
    framePath.lineTo(size.width * 0.65, size.height * 0.6);
    framePath.lineTo(size.width * 0.45, size.height * 0.6);
    framePath.close();

    canvas.drawPath(framePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HeartPainter extends CustomPainter {
  final Color color;

  HeartPainter({this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Create heart shape
    final width = size.width;
    final height = size.height;

    path.moveTo(width * 0.5, height * 0.9);

    // Left curve
    path.cubicTo(
      width * 0.1, height * 0.6,
      width * 0.1, height * 0.2,
      width * 0.35, height * 0.2,
    );

    // Top center
    path.cubicTo(
      width * 0.5, height * 0.1,
      width * 0.5, height * 0.1,
      width * 0.65, height * 0.2,
    );

    // Right curve
    path.cubicTo(
      width * 0.9, height * 0.2,
      width * 0.9, height * 0.6,
      width * 0.5, height * 0.9,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}