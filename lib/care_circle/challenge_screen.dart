import 'package:flutter/material.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
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
              Icons.share,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Challenge Title
            const Text(
              '7-Day Walking Challenge',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 16),

            // Challenge Illustration
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Background gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFFFE0B2).withValues(alpha: 0.5),
                            const Color(0xFFFFB74D).withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                    // Sun
                    Positioned(
                      top: 10,
                      left: 40,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF8C00),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFFF8C00),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Tree
                    Positioned(
                      top: 20,
                      left: 20,
                      child: _buildTreeIllustration(),
                    ),
                    // Runners
                    Positioned(
                      bottom: 30,
                      left: 40,
                      child: _buildRunnerGroupIllustration(),
                    ),
                    // Ground
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF558B2F).withValues(alpha: 0.4),
                              const Color(0xFF558B2F).withValues(alpha: 0.6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Family event label
                    Positioned(
                      bottom: 10,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Family event',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Goal Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8DE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C42),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.directions_walk,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Goal: Every Day Movement',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Maintain a consistent 15-minute walk everyday\nfor a full week to build lasting habits.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withValues(alpha: 0.6),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Participants Section
            const Text(
              'Participants',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Avatar 1
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF69B4),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      'N',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Avatar 2
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4ECDC4),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Avatar 3
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF8BC34A),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      'P',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // +2 Badge
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.1),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '+2',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Neha and 5 family members are ready.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),

            // Challenge Daily Goals
            const Text(
              'Challenge Daily Goals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 12),
            _buildGoalItem(
              number: '01',
              title: 'The First Step - 1,000 Paces',
              subtitle: 'Day 1 milestone',
            ),
            const SizedBox(height: 10),
            _buildGoalItem(
              number: '02',
              title: 'Consistency is Key - 15 Min',
              subtitle: 'Day 2 & 3 target',
            ),
            const SizedBox(height: 10),
            _buildGoalItem(
              number: '03',
              title: 'Mid-Week Stretch - 2,000 Paces',
              subtitle: 'Day 4 & 5 challenge',
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'View all 7 days',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFA500),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Badge Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFFFA500),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFA500).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.emoji_events,
                      size: 24,
                      color: Color(0xFFFFA500),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Legacy Walker Badge',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Plus a family video call dinner',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Join Challenge Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Challenge joined successfully!'),
                      backgroundColor: Color(0xFF4CAF50),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A2E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Join Challenge',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Maybe Later Button
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Maybe Later',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withValues(alpha: 0.5),
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

  Widget _buildGoalItem({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFA500),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeIllustration() {
    return SizedBox(
      width: 35,
      height: 60,
      child: Stack(
        children: [
          // Tree trunk
          Positioned(
            bottom: 0,
            left: 12,
            child: Container(
              width: 8,
              height: 20,
              color: const Color(0xFF5D4037),
            ),
          ),
          // Tree foliage
          Positioned(
            top: 0,
            left: 2,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0xFF558B2F),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFF6BAA3D),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFF6BAA3D),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRunnerGroupIllustration() {
    return SizedBox(
      width: 120,
      height: 50,
      child: Stack(
        children: [
          // Runner 1
          Positioned(
            left: 0,
            bottom: 0,
            child: _buildSingleRunner(const Color(0xFFFF6B6B)),
          ),
          // Runner 2
          Positioned(
            left: 35,
            bottom: 2,
            child: _buildSingleRunner(const Color(0xFFFF8C42)),
          ),
          // Runner 3
          Positioned(
            left: 70,
            bottom: 0,
            child: _buildSingleRunner(const Color(0xFFFFA500)),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleRunner(Color shirtColor) {
    return SizedBox(
      width: 35,
      height: 50,
      child: Stack(
        children: [
          // Head
          Positioned(
            top: 0,
            left: 10,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFFD4A574),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Body (shirt)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              width: 8,
              height: 12,
              color: shirtColor,
            ),
          ),
          // Shorts
          Positioned(
            top: 24,
            left: 12,
            child: Container(
              width: 8,
              height: 6,
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
          // Left leg (running pose)
          Positioned(
            top: 28,
            left: 10,
            child: Transform.rotate(
              angle: 0.3,
              child: Container(
                width: 2,
                height: 12,
                color: const Color(0xFFD4A574),
              ),
            ),
          ),
          // Right leg (running pose)
          Positioned(
            top: 28,
            right: 10,
            child: Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 2,
                height: 12,
                color: const Color(0xFFD4A574),
              ),
            ),
          ),
          // Left arm
          Positioned(
            top: 14,
            left: 8,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 2,
                height: 10,
                color: const Color(0xFFD4A574),
              ),
            ),
          ),
          // Right arm
          Positioned(
            top: 14,
            right: 8,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 2,
                height: 10,
                color: const Color(0xFFD4A574),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
