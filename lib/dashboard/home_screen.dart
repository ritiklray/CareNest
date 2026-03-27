import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../mood/mood_popup.dart';
import '../routine/routine_screen.dart';
import '../care_circle/memory_popup.dart';
import '../care_circle/challenge_screen.dart';
import '../sos/safety_centre_screen.dart';

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

  // Carousel variables
  late PageController _carouselController;
  int _currentCarouselIndex = 0;

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

    // Initialize carousel
    _carouselController = PageController();
    _startCarouselTimer();
  }

  void _startCarouselTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return false;

      final nextPage = (_currentCarouselIndex + 1) % 3;
      _carouselController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          SafeArea(
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
                    _buildCarouselCards(),
                    const SizedBox(height: 24),
                    _buildHealthMetricsGrid(),
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
          // Floating Voice Button
          Positioned(
            bottom: 90, // Navigation bar ke upar
            right: 20,
            child: GestureDetector(
              onTap: () {
                _showVoicePopup(context);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8C42),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF8C42).withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
                color: Colors.black.withValues(alpha: 0.5),
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
                color: Colors.black.withValues(alpha: 0.1),
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
                color: Colors.black.withValues(alpha: 0.6),
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

  Widget _buildCarouselCards() {
    return Column(
      children: [
        SizedBox(
          height: 195,
          child: PageView(
            controller: _carouselController,
            onPageChanged: (index) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
            children: [
              _buildNextActivityCard(),
              _buildFeelingCard(),
              _buildHealthScoreCard(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentCarouselIndex == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentCarouselIndex == index
                    ? const Color(0xFFFF8C42)
                    : const Color(0xFFFF8C42).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFeelingCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9E7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'How are you feeling?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your last check-in was 4 hours ago, let us know your mood.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withValues(alpha: 0.6),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A6741),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'Record Mood',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 90,
            height: 90,
            child: _buildMoodMeterIllustration(),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodMeterIllustration() {
    return Stack(
      children: [
        // Meter arc background
        Positioned(
          top: 10,
          left: 5,
          child: SizedBox(
            width: 80,
            height: 50,
            child: CustomPaint(
              painter: MoodMeterPainter(),
            ),
          ),
        ),
        // Smiley face in center
        Positioned(
          top: 25,
          left: 30,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD93D),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Left eye
                Positioned(
                  top: 10,
                  left: 8,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5D4037),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Right eye
                Positioned(
                  top: 10,
                  right: 8,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5D4037),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Smile
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    width: 14,
                    height: 7,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFF5D4037),
                          width: 2,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Needle pointing to happy
        Positioned(
          top: 20,
          left: 42,
          child: Transform.rotate(
            angle: 0.8,
            child: Container(
              width: 2,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
        // Base platform
        Positioned(
          bottom: 10,
          left: 15,
          child: Container(
            width: 60,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: index < 4 ? const Color(0xFFFFB300) : Colors.white.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthScoreCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Health Score',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'You have completed 4 out of 5 daily vitals. Great progress!',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00796B),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'View Score',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 90,
            height: 90,
            child: _buildHealthScoreIllustration(),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScoreIllustration() {
    return Stack(
      children: [
        // Background circle with gradient effect
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFF8C42).withValues(alpha: 0.2),
                  const Color(0xFFFFB74D).withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Progress ring
        Positioned(
          top: 10,
          left: 10,
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: 0.78,
              strokeWidth: 6,
              backgroundColor: const Color(0xFFFF8C42).withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFF8C42),
              ),
            ),
          ),
        ),
        // Center heart with pulse
        Positioned(
          top: 22,
          left: 22,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8C42).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite,
              size: 20,
              color: Color(0xFFFF8C42),
            ),
          ),
        ),
        // Sparkle effects
        Positioned(
          top: 5,
          right: 10,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 2,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C42).withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Check mark badge
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              size: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextActivityCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8DE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    color: Colors.black.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
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
              color: const Color(0xFFFFD4B4).withValues(alpha: 0.3),
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
              color: const Color(0xFF8B4513).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
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
                  color: Colors.black.withValues(alpha: 0.1),
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
                  color: Colors.black.withValues(alpha: 0.1),
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
                  color: Colors.black.withValues(alpha: 0.1),
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
              color: const Color(0xFFFF8C42).withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
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
            color: Colors.black.withValues(alpha: 0.05),
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
              color: iconColor.withValues(alpha: 0.1),
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
              color: Colors.black.withValues(alpha: 0.6),
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
              color: Colors.black.withValues(alpha: 0.5),
            ),
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
                color: Colors.black.withValues(alpha: 0.5),
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
            color: Colors.black.withValues(alpha: 0.6),
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
                    : const Color(0xFF4ECDC4).withValues(alpha: 0.2),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoutineScreen(),
                  ),
                );
              },
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFFF8C42),
                ),
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
            color: Colors.black.withValues(alpha: 0.05),
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
              color: routine['color'].withValues(alpha: 0.1),
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
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 4),
                Text(
                  routine['time'],
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
              color: Colors.black.withValues(alpha: 0.6),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChallengeScreen(),
                ),
              );
            },
            child: Container(
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
            color: Colors.black.withValues(alpha: 0.1),
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
                if (index == 1) {
                  // Mood button - show mood popup
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => const MoodPopup(),
                  );
                } else if (index == 2) {
                  // Routine button - navigate to routine screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoutineScreen(),
                    ),
                  );
                } else if (index == 3) {
                  // Care Circle button - show memory popup
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => const MemoryPopup(
                      imageUrl: 'https://via.placeholder.com/500x300',
                      senderName: 'Neha',
                      senderImageUrl: 'https://via.placeholder.com/150',
                      memoryTitle: 'Summer Vacation 2010',
                      memorySubtitle: 'Beautiful memories',
                      memoryDescription: 'Hi Mom, this was our vacation in 2010.\nSuch a beautiful day!',
                    ),
                  );
                } else if (index == 4) {
                  // SOS button - navigate to safety centre screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SafetyCentreScreen(),
                    ),
                  );
                } else {
                  setState(() {
                    _currentBottomIndex = index;
                  });
                }
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
                            : Colors.black.withValues(alpha: 0.5),
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
                            : Colors.black.withValues(alpha: 0.5),
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

  void _showVoicePopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Voice Animation Circle
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C42).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF8C42),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.mic,
                    size: 40,
                    color: Color(0xFFFF8C42),
                  ),
                ),
                const SizedBox(height: 24),

                // Voice Recording Text
                const Text(
                  'Voice Assistant',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tap to speak your health concerns\nor ask any questions about your wellness',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withValues(alpha: 0.6),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Single Start Recording Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('🎙️ Voice recording started...'),
                        backgroundColor: const Color(0xFFFF8C42),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C42),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8C42).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Start Recording',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Cancel Text Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Custom Painter for Mood Meter Arc
class MoodMeterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);

    // Red section (sad)
    paint.color = const Color(0xFFEF5350);
    canvas.drawArc(rect, 3.14, 0.6, false, paint);

    // Orange section
    paint.color = const Color(0xFFFF9800);
    canvas.drawArc(rect, 3.74, 0.6, false, paint);

    // Yellow section
    paint.color = const Color(0xFFFFEB3B);
    canvas.drawArc(rect, 4.34, 0.6, false, paint);

    // Light green section
    paint.color = const Color(0xFF8BC34A);
    canvas.drawArc(rect, 4.94, 0.6, false, paint);

    // Green section (happy)
    paint.color = const Color(0xFF4CAF50);
    canvas.drawArc(rect, 5.54, 0.6, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}