import 'package:flutter/material.dart';

class ChallengeCompletionScreen extends StatefulWidget {
  const ChallengeCompletionScreen({super.key});

  @override
  State<ChallengeCompletionScreen> createState() =>
      _ChallengeCompletionScreenState();
}

class _ChallengeCompletionScreenState extends State<ChallengeCompletionScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController.forward();
    _confettiController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1A1A2E),
          ),
        ),
        title: const Text(
          'Challenge',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Trophy Illustration
            ScaleTransition(
              scale: _scaleController.drive(
                Tween<double>(begin: 0.5, end: 1.0),
              ),
              child: SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Confetti decorations
                    _buildConfetti(
                      offset: const Offset(-80, -60),
                      rotation: 0.3,
                    ),
                    _buildConfetti(
                      offset: const Offset(80, -50),
                      rotation: -0.2,
                    ),
                    _buildConfetti(
                      offset: const Offset(-70, 50),
                      rotation: 0.5,
                    ),
                    _buildConfetti(
                      offset: const Offset(75, 60),
                      rotation: -0.4,
                    ),

                    // Trophy
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Trophy Cup
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Cup body
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Handles
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 30,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFFFC107),
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      // Star
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFFC107),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '⭐',
                                            style: TextStyle(
                                              fontSize: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                        height: 30,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFFFC107),
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Base
                        Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Leaf decorations
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLeaf(),
                            const SizedBox(width: 40),
                            _buildLeaf(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Level Up Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9800),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'LEVEL UP',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Congratulations Text
            Text(
              'Great Job, Saniya!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Completion Message
            Text(
              'You completed the 7-Day Walking Challenge\nwith perfect attendance.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black.withValues(alpha: 0.6),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Family Reactions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Family Reactions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFamilyMember(
                        name: 'Ritik',
                        emoji: '👏',
                        initials: 'R',
                        bgColor: const Color(0xFF1A1A2E),
                      ),
                      _buildFamilyMember(
                        name: 'Sara',
                        emoji: '❤️',
                        initials: 'S',
                        bgColor: const Color(0xFFFF69B4),
                      ),
                      _buildFamilyMember(
                        name: 'Rehan',
                        emoji: '👍',
                        initials: 'R',
                        bgColor: const Color(0xFF666666),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.2),
                                width: 2,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFFFF9800),
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Invite',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.directions_walk,
                                color: Color(0xFF4CAF50),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '14,200',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total Steps',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE91E63)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.schedule,
                                color: Color(0xFFE91E63),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '210m',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Active Time',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Share with Family Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎉 Shared with family!'),
                      backgroundColor: Color(0xFFFFA500),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA500),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Share with Family',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Join New Challenge Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(
                    color: Color(0xFFFFA500),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Join New Challenge',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFA500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildConfetti({required Offset offset, required double rotation}) {
    return Positioned(
      left: 185 + offset.dx,
      top: 50 + offset.dy,
      child: Transform.rotate(
        angle: rotation,
        child: Text(
          ['🎉', '🎊', '✨', '🌟'][
              (offset.dx.toInt() + offset.dy.toInt()).abs() % 4],
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }

  Widget _buildLeaf() {
    return Column(
      children: [
        const SizedBox(
          width: 15,
          height: 15,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFE91E63),
            ),
          ),
        ),
        Container(
          width: 2,
          height: 10,
          color: const Color(0xFF4CAF50),
        ),
      ],
    );
  }

  Widget _buildFamilyMember({
    required String name,
    required String emoji,
    required String initials,
    required Color bgColor,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
              ),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -4,
              bottom: -4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: bgColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}
