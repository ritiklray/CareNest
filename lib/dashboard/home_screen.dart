import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeIn;

  int _currentBottomIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildHeader(),
                const SizedBox(height: 20),
                _buildWeeklyCalendar(),
                const SizedBox(height: 24),
                _buildNextActivityCard(),
                const SizedBox(height: 24),
                _buildHealthMetricsGrid(),
                const SizedBox(height: 24),
                _buildHealthScore(),
                const SizedBox(height: 24),
                _buildWaterIntake(),
                const SizedBox(height: 24),
                _buildDailyRoutine(),
                const SizedBox(height: 20),
                _buildCareNestPlusCard(),
                const SizedBox(height: 20),
                _buildFamilyChallenge(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, d MMMM, y').format(now);
  }

  List<DateTime> _getWeekDates() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekday = today.weekday;
    final startOfWeek = today.subtract(Duration(days: weekday - 1));

    return List.generate(7, (index) {
      return startOfWeek.add(Duration(days: index));
    });
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(
          Icons.menu,
          size: 24,
          color: Color(0xFF1A1A2E),
        ),
        const Spacer(),
        Column(
          children: [
            Text(
              '${_getGreeting()}, Ritik',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            Text(
              _getCurrentDate(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            size: 20,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyCalendar() {
    final weekDates = _getWeekDates();
    final today = DateTime.now();
    final currentDay = DateTime(today.year, today.month, today.day);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final date = weekDates[index];
        final dayName = DateFormat('E').format(date);
        final isSelected = date.isAtSameMomentAs(currentDay);

        return Column(
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1A1A2E) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildNextActivityCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8DE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Next Activity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hope you\'re having a peaceful day. Your next medicine is at 10:00 AM.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 80,
            height: 80,
            child: _buildMedicineIllustration(),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineIllustration() {
    return Stack(
      children: [
        // Background circle
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD4B4).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Medicine cabinet/shelf
        Positioned(
          bottom: 15,
          left: 15,
          child: Container(
            width: 50,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFF8B4513).withOpacity(0.8),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Cabinet handles
                Positioned(
                  top: 8,
                  left: 12,
                  child: Container(
                    width: 3,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 12,
                  child: Container(
                    width: 3,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Medicine bottles with labels
        Positioned(
          bottom: 25,
          left: 20,
          child: Container(
            width: 8,
            height: 18,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 8,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4ECDC4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 25,
          left: 32,
          child: Container(
            width: 8,
            height: 15,
            decoration: BoxDecoration(
              color: const Color(0xFF4ECDC4),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 8,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD700),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 25,
          left: 44,
          child: Container(
            width: 8,
            height: 22,
            decoration: BoxDecoration(
              color: const Color(0xFF9575CD),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 8,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF8C42),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Clock icon for timing
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C42).withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(
              Icons.access_time,
              size: 10,
              color: Colors.white,
            ),
          ),
        ),

        // Medicine pills scattered
        Positioned(
          top: 20,
          left: 25,
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0xFFFF6B6B),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 35,
          child: Container(
            width: 3,
            height: 3,
            decoration: const BoxDecoration(
              color: Color(0xFF4ECDC4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 25,
          left: 45,
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Health cross symbol
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            width: 12,
            height: 12,
            child: Stack(
              children: [
                Positioned(
                  top: 4,
                  left: 0,
                  child: Container(
                    width: 12,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 4,
                  child: Container(
                    width: 4,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(2),
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

  Widget _buildHealthMetricsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _buildMetricCard(
          icon: Icons.directions_walk,
          iconColor: const Color(0xFFFF8C42),
          title: 'Walk Steps',
          value: '1,717',
          subtitle: '78% Goal',
        ),
        _buildMetricCard(
          icon: Icons.bedtime,
          iconColor: const Color(0xFF8BC34A),
          title: 'Sleep',
          value: '8h 40m',
          subtitle: '88% Goal',
        ),
        _buildMetricCard(
          icon: Icons.medication,
          iconColor: const Color(0xFF4ECDC4),
          title: 'Medicine',
          value: '1 / 3',
          subtitle: 'Taken Today',
        ),
        _buildMetricCard(
          icon: Icons.timer,
          iconColor: const Color(0xFFE91E63),
          title: 'Activity',
          value: 'Active Time',
          subtitle: '35 mins',
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScore() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Score',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Good Progress Today',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You have completed 4 out of 5 daily vitals',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.78,
                  strokeWidth: 8,
                  backgroundColor: const Color(0xFFFF8C42).withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFFF8C42),
                  ),
                ),
              ),
              Column(
                children: [
                  const Text(
                    '78%',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8C42),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mic,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaterIntake() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Water Intake',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            Text(
              'Daily Goal',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '5 / 7 Glasses',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(7, (index) {
            final isFilled = index < 5;
            return Container(
              margin: const EdgeInsets.only(right: 12),
              width: 30,
              height: 40,
              decoration: BoxDecoration(
                color: isFilled
                    ? const Color(0xFF4ECDC4)
                    : const Color(0xFF4ECDC4).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFF4ECDC4),
                  width: 1,
                ),
              ),
              child: isFilled
                  ? null
                  : const Icon(
                      Icons.add,
                      size: 16,
                      color: Color(0xFF4ECDC4),
                    ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDailyRoutine() {
    final routines = [
      {
        'title': 'Drink a glass of water',
        'streak': 'Streak 3 day',
        'time': '5 min',
        'completed': true,
        'color': const Color(0xFFFF8C42),
      },
      {
        'title': 'Meditate to relax',
        'streak': 'Streak 6 day',
        'time': '15 min',
        'completed': true,
        'color': const Color(0xFF8BC34A),
      },
      {
        'title': 'Stretch for 10 minutes',
        'streak': 'Streak 5 day',
        'time': '10 min',
        'completed': false,
        'color': const Color(0xFFE91E63),
      },
      {
        'title': 'Go for a short walk',
        'streak': 'Streak 3 day',
        'time': '20 min',
        'completed': false,
        'color': const Color(0xFFFF8C42),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daily routine',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFF8C42),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...routines.map((routine) => _buildRoutineItem(routine)).toList(),
      ],
    );
  }

  Widget _buildRoutineItem(Map<String, dynamic> routine) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: routine['completed']
                  ? routine['color']
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: routine['color'],
                width: 2,
              ),
            ),
            child: routine['completed']
                ? const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: routine['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getRoutineIcon(routine['title']),
              size: 20,
              color: routine['color'],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routine['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  routine['streak'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color: Colors.black.withOpacity(0.5),
                ),
                const SizedBox(width: 4),
                Text(
                  routine['time'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getRoutineIcon(String title) {
    if (title.contains('water')) return Icons.local_drink;
    if (title.contains('Meditate')) return Icons.self_improvement;
    if (title.contains('Stretch')) return Icons.accessibility_new;
    if (title.contains('walk')) return Icons.directions_walk;
    return Icons.task_alt;
  }

  Widget _buildCareNestPlusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.add_circle,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'CareNest',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Plus',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Unlock advanced safety and family features\nwith CareNest plus',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Upgrade',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF6B6B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyChallenge() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8DE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Family Challenge',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Weekend Walking Goal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '4 Members are participating!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Center(
              child: Text(
                'Join Challenge',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.mood, 'label': 'Mood'},
      {'icon': Icons.calendar_today, 'label': 'Routine'},
      {'icon': Icons.group, 'label': 'Care Circle'},
      {'icon': Icons.sos, 'label': 'SOS'},
    ];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final isSelected = index == _currentBottomIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentBottomIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1A1A2E)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        items[index]['icon'] as IconData,
                        size: 24,
                        color: isSelected
                            ? Colors.white
                            : Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF1A1A2E)
                            : Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}