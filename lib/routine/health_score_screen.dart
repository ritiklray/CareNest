import 'package:flutter/material.dart';
import '../care_circle/weekly_progress_screen.dart';

class HealthScoreScreen extends StatefulWidget {
  const HealthScoreScreen({super.key});

  @override
  State<HealthScoreScreen> createState() => _HealthScoreScreenState();
}

class _HealthScoreScreenState extends State<HealthScoreScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _scaleController.forward();
      _progressController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _progressController.dispose();
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
          'Health Score',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Score Card
            ScaleTransition(
              scale: _scaleController.drive(
                Tween<double>(begin: 0.85, end: 1.0),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFFFE5E5),
                                      const Color(0xFFFFD4D4),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFD32F2F).withValues(alpha: 0.25),
                                    width: 1.2,
                                  ),
                                ),
                                child: const Text(
                                  'Status: Excellent',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF991111),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '90/100',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A2E),
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Your score improves when you complete daily health tasks.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withValues(alpha: 0.6),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Circular Progress Indicator
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 110,
                              height: 110,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: CircularProgressIndicator(
                                      value: _progressController.value * 0.9,
                                      strokeWidth: 9,
                                      strokeCap: StrokeCap.round,
                                      backgroundColor: Colors.grey.withValues(
                                        alpha: 0.12,
                                      ),
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        _getColorForScore(90),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${(_progressController.value * 90).toStringAsFixed(0)}%',
                                        style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1A1A2E),
                                          height: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Tasks Score Section
            const Text(
              'Tasks score',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 14),

            // Medicine Task
            _buildTaskCard(
              icon: '💊',
              title: 'Medicines taken',
              description: 'Perfect streak! All morning and noon doses recorded.',
              score: '40/40',
              progressValue: 1.0,
              progressColor: const Color(0xFFFFA500),
            ),
            const SizedBox(height: 12),

            // Activity Task
            _buildTaskCard(
              icon: '🚶',
              title: 'Activity completed',
              description: 'You reached your goal of 20 minutes of light walking.',
              score: '23/30',
              progressValue: 0.77,
              progressColor: const Color(0xFFFFA500),
            ),
            const SizedBox(height: 12),

            // Mood CheckIn
            _buildTaskCard(
              icon: '😊',
              title: 'Mood check-in',
              description: 'Checked in at 8:00 AM. Feeling calm and energized.',
              score: '9/15',
              progressValue: 0.6,
              progressColor: const Color(0xFFFFA500),
            ),
            const SizedBox(height: 12),

            // Routine Tasks
            _buildTaskCard(
              icon: '😔',
              title: 'Routine tasks',
              description: 'Evening reflection and hydration check remaining.',
              score: '0/10',
              progressValue: 0.0,
              progressColor: const Color(0xFFBDBDBD),
              isIncomplete: true,
            ),
            const SizedBox(height: 28),

            // View Weekly Progress Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WeeklyProgressScreen(),
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
                child: const Text(
                  'View Weekly Progress',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

  Widget _buildTaskCard({
    required String icon,
    required String title,
    required String description,
    required String score,
    required double progressValue,
    required Color progressColor,
    bool isIncomplete = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    score,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: isIncomplete
                          ? Colors.grey
                          : const Color(0xFFFFA500),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 10,
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForScore(int score) {
    if (score >= 80) {
      return const Color(0xFFE91E63);
    } else if (score >= 60) {
      return const Color(0xFFFFA500);
    } else {
      return const Color(0xFF4CAF50);
    }
  }
}
