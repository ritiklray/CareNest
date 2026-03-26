import 'package:flutter/material.dart';
import 'dart:math';
import '../elder/elder_connect_screen.dart';

class CareCodeScreen extends StatefulWidget {
  const CareCodeScreen({super.key});

  @override
  State<CareCodeScreen> createState() => _CareCodeScreenState();
}

class _CareCodeScreenState extends State<CareCodeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  late Animation<double> _scaleUp;

  final String _careCode = '4826';

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
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Back button on left
                      Align(
                        alignment: Alignment.centerLeft,
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
                      // Centered title
                      const Text(
                        'Setup Flow',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      // Download icon on right
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Handle download/save functionality
                          },
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
                              Icons.download_rounded,
                              size: 18,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
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
                      const SizedBox(height: 30),

                      // Title
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideUp,
                          child: const Text(
                            'Care Code Generated',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A2E),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Subtitle
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideUp,
                          child: Text(
                            'Your elder can connect their device using this unique code or by scanning the QR code below.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.5),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // QR Code
                      FadeTransition(
                        opacity: _fadeIn,
                        child: ScaleTransition(
                          scale: _scaleUp,
                          child: Container(
                            width: 200,
                            height: 200,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF8C42),
                                  Color(0xFFE91E63),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: _buildQRCode(),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // OR Divider
                      FadeTransition(
                        opacity: _fadeIn,
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Care Code Text
                      FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideUp,
                          child: Text(
                            'Your elder can connect using this care code.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Care Code Numbers
                      FadeTransition(
                        opacity: _fadeIn,
                        child: ScaleTransition(
                          scale: _scaleUp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _careCode.split('').map((digit) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  digit,
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1A2E),
                                    letterSpacing: 4,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Expiry Text
                      FadeTransition(
                        opacity: _fadeIn,
                        child: Text(
                          'Care Code Expires In 24 Hours',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Share Button and Later
              FadeTransition(
                opacity: _fadeIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Share Care Code Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const ElderConnectScreen(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              transitionDuration: const Duration(milliseconds: 300),
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
                              'Share Care Code',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Later Button
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to main app or home screen
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Later',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRCode() {
    return Container(
      width: 140,
      height: 140,
      padding: const EdgeInsets.all(8),
      child: CustomPaint(
        painter: ImprovedQRCodePainter(),
      ),
    );
  }
}

class ImprovedQRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final blockSize = size.width / 21; // Standard QR code is 21x21 for version 1

    // Create positioning patterns (large squares in corners)
    _drawPositioningPattern(canvas, paint, 0, 0, blockSize);
    _drawPositioningPattern(canvas, paint, 14 * blockSize, 0, blockSize);
    _drawPositioningPattern(canvas, paint, 0, 14 * blockSize, blockSize);

    // Timing patterns (horizontal and vertical lines)
    for (int i = 8; i < 13; i++) {
      if (i % 2 == 0) {
        _drawBlock(canvas, paint, i * blockSize, 6 * blockSize, blockSize);
        _drawBlock(canvas, paint, 6 * blockSize, i * blockSize, blockSize);
      }
    }

    // Dark module (always at position 4*version + 9, which is 13 for version 1)
    _drawBlock(canvas, paint, 8 * blockSize, 13 * blockSize, blockSize);

    // Format information patterns around positioning patterns
    final formatPattern = [
      [8, 0], [8, 1], [8, 2], [8, 3], [8, 4], [8, 5], [8, 7], [8, 8],
      [7, 8], [5, 8], [4, 8], [3, 8], [2, 8], [1, 8], [0, 8],
      [8, 14], [8, 15], [8, 16], [8, 17], [8, 18], [8, 19], [8, 20],
      [13, 8], [14, 8], [15, 8], [16, 8], [17, 8], [18, 8], [19, 8], [20, 8],
    ];

    for (int i = 0; i < formatPattern.length; i++) {
      if (i % 3 == 0) { // Create a pattern for format info
        _drawBlock(canvas, paint, formatPattern[i][0] * blockSize, formatPattern[i][1] * blockSize, blockSize);
      }
    }

    // Data modules - create a more realistic pattern
    final dataModules = [
      // Top right area
      [15, 9], [16, 9], [17, 9], [19, 9], [20, 9],
      [15, 10], [17, 10], [18, 10], [20, 10],
      [15, 11], [16, 11], [18, 11], [19, 11],
      [15, 12], [17, 12], [18, 12], [20, 12],
      [15, 13], [16, 13], [17, 13], [19, 13], [20, 13],

      // Bottom left area
      [9, 15], [10, 15], [11, 15], [12, 15], [13, 15],
      [9, 16], [11, 16], [13, 16],
      [9, 17], [10, 17], [12, 17], [13, 17],
      [9, 18], [11, 18], [12, 18], [13, 18],
      [9, 19], [10, 19], [11, 19], [13, 19],
      [9, 20], [10, 20], [12, 20], [13, 20],

      // Bottom right area
      [15, 15], [17, 15], [18, 15], [20, 15],
      [15, 16], [16, 16], [19, 16], [20, 16],
      [15, 17], [17, 17], [18, 17], [19, 17],
      [15, 18], [16, 18], [17, 18], [20, 18],
      [15, 19], [17, 19], [19, 19], [20, 19],
      [15, 20], [16, 20], [18, 20], [19, 20],

      // Central data area
      [9, 9], [11, 9], [12, 9], [13, 9],
      [9, 10], [10, 10], [12, 10], [13, 10],
      [9, 11], [11, 11], [13, 11],
      [9, 12], [10, 12], [11, 12], [13, 12],
      [9, 13], [10, 13], [11, 13], [12, 13],
    ];

    // Draw data modules
    for (final module in dataModules) {
      _drawBlock(canvas, paint, module[0] * blockSize, module[1] * blockSize, blockSize);
    }

    // Add some separator patterns between positioning squares
    // Horizontal separators
    for (int i = 0; i < 8; i++) {
      if (i != 6) { // Skip timing pattern line
        _drawSeparator(canvas, paint, i * blockSize, 7 * blockSize, blockSize);
        _drawSeparator(canvas, paint, (13 + i) * blockSize, 7 * blockSize, blockSize);
        _drawSeparator(canvas, paint, i * blockSize, 13 * blockSize, blockSize);
      }
    }

    // Vertical separators
    for (int i = 0; i < 8; i++) {
      if (i != 6) { // Skip timing pattern line
        _drawSeparator(canvas, paint, 7 * blockSize, i * blockSize, blockSize);
        _drawSeparator(canvas, paint, 7 * blockSize, (13 + i) * blockSize, blockSize);
        _drawSeparator(canvas, paint, 13 * blockSize, i * blockSize, blockSize);
      }
    }
  }

  void _drawPositioningPattern(Canvas canvas, Paint paint, double x, double y, double blockSize) {
    // Outer border (7x7)
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 7; j++) {
        if (i == 0 || i == 6 || j == 0 || j == 6) {
          _drawBlock(canvas, paint, x + j * blockSize, y + i * blockSize, blockSize);
        }
      }
    }

    // Inner square (3x3 in center)
    for (int i = 2; i < 5; i++) {
      for (int j = 2; j < 5; j++) {
        _drawBlock(canvas, paint, x + j * blockSize, y + i * blockSize, blockSize);
      }
    }
  }

  void _drawBlock(Canvas canvas, Paint paint, double x, double y, double size) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x + 0.8, y + 0.8, size - 1.6, size - 1.6),
      const Radius.circular(0.8),
    );
    canvas.drawRRect(rect, paint);
  }

  void _drawSeparator(Canvas canvas, Paint separatorPaint, double x, double y, double size) {
    // Separators are white/empty spaces, so we don't draw anything
    // This method is just for reference and completeness
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}