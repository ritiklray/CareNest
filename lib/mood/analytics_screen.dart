import 'package:flutter/material.dart';
import '../routine/routine_screen.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedPeriod = 'Month';
  String selectedMonth = 'March, 2026';

  final List<MoodAnalytic> moodData = [
    MoodAnalytic(emoji: '😍', percentage: 40, color: const Color(0xFFE5C5FF)),
    MoodAnalytic(emoji: '😊', percentage: 0, color: const Color(0xFFD4F4D9)),
    MoodAnalytic(emoji: '😐', percentage: 0, color: const Color(0xFFFFF4CC)),
    MoodAnalytic(emoji: '😔', percentage: 20, color: const Color(0xFFFFE5D9)),
    MoodAnalytic(emoji: '😠', percentage: 40, color: const Color(0xFFFFDCDC)),
  ];

  final List<DayMoodData> weeklyData = [
    DayMoodData(day: 'Mon', moods: [20, 0, 0, 0, 0]),
    DayMoodData(day: 'Tue', moods: [100, 0, 0, 0, 0]),
    DayMoodData(day: 'Wed', moods: [0, 50, 0, 0, 0]),
    DayMoodData(day: 'Thu', moods: [20, 0, 0, 0, 0]),
    DayMoodData(day: 'Fri', moods: [20, 0, 0, 0, 0]),
    DayMoodData(day: 'Sat', moods: [100, 0, 0, 0, 0]),
    DayMoodData(day: 'Sun', moods: [50, 0, 0, 0, 0]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
                    ),
                    const Text(
                      'Analytics',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Month/Week Toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildToggleButton('Month', 'Month'),
                      ),
                      Expanded(
                        child: _buildToggleButton('Week', 'Week'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Month Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'March, 2026',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.expand_more,
                        color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFDCC9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'You have completed 3 goals during this period!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A2E),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Image.asset(
                        'assets/icons/goal_icon.png',
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.emoji_events, color: Color(0xFFFFA500)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Mood Scale Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mood scale for the period',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Mood Emojis with Percentages
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(moodData.length, (index) {
                          final mood = moodData[index];
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: mood.color,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  mood.emoji,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${mood.percentage}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A2E),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 16),

                      // Mood Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 40,
                                child: Container(
                                  color: const Color(0xFFE5C5FF),
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: Container(
                                  color: const Color(0xFFFFE5D9),
                                ),
                              ),
                              Expanded(
                                flex: 40,
                                child: Container(
                                  color: const Color(0xFFFF9B5B),
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
              const SizedBox(height: 16),

              // Weekly Mood Chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Average mood by days of the week',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Mood Legend on left
                          SizedBox(
                            width: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(moodData.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    moodData[index].emoji,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Bar Chart
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(weeklyData.length, (dayIndex) {
                                final dayData = weeklyData[dayIndex];
                                return _buildMoodBar(dayData);
                              }),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Day Labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 48),
                          ...List.generate(
                            weeklyData.length,
                            (index) => Text(
                              weeklyData[index].day,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, 'Home', false, () {
                  Navigator.pop(context);
                }),
                _buildBottomNavItem(Icons.sentiment_satisfied, 'Mood', true, () {}),
                _buildBottomNavItem(Icons.calendar_today, 'Routine', false, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoutineScreen(),
                    ),
                  );
                }),
                _buildBottomNavItem(Icons.group, 'Care Circle', false, () {}),
                _buildBottomNavItem(Icons.emergency, 'SOS', false, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, String value) {
    final isSelected = selectedPeriod == value;
    return Container(
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFFFAF6F1) : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {
          setState(() {
            selectedPeriod = value;
          });
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? const Color(0xFF1A1A2E) : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildMoodBar(DayMoodData dayData) {
    final totalHeight = 100.0;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 40,
            height: totalHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Amazing (top)
                if (dayData.moods[0] > 0)
                  Container(
                    width: double.infinity,
                    height: (dayData.moods[0] / 100) * totalHeight,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5C5FF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                // Great
                if (dayData.moods[1] > 0)
                  Container(
                    width: double.infinity,
                    height: (dayData.moods[1] / 100) * totalHeight,
                    color: const Color(0xFFD4F4D9),
                  ),
                // Neutral
                if (dayData.moods[2] > 0)
                  Container(
                    width: double.infinity,
                    height: (dayData.moods[2] / 100) * totalHeight,
                    color: const Color(0xFFFFF4CC),
                  ),
                // Sad
                if (dayData.moods[3] > 0)
                  Container(
                    width: double.infinity,
                    height: (dayData.moods[3] / 100) * totalHeight,
                    color: const Color(0xFFFFE5D9),
                  ),
                // Angry (bottom)
                if (dayData.moods[4] > 0)
                  Container(
                    width: double.infinity,
                    height: (dayData.moods[4] / 100) * totalHeight,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF9B5B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF1A1A2E) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isActive ? const Color(0xFF1A1A2E) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class MoodAnalytic {
  final String emoji;
  final int percentage;
  final Color color;

  MoodAnalytic({
    required this.emoji,
    required this.percentage,
    required this.color,
  });
}

class DayMoodData {
  final String day;
  final List<int> moods; // 5 moods percentages

  DayMoodData({
    required this.day,
    required this.moods,
  });
}
