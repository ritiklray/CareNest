import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'health_score_screen.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  String selectedPeriod = 'Day';
  late DateTime selectedDate;
  late String selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedMonth = DateFormat('MMMM, yyyy').format(selectedDate);
  }

  final List<RoutineItem> morningRoutines = [
    RoutineItem(
      id: '1',
      name: 'Breakfast',
      time: '08:00 AM',
      icon: Icons.restaurant,
      color: const Color(0xFF6BCB77),
      isCompleted: true,
    ),
    RoutineItem(
      id: '2',
      name: 'Medicines',
      time: '10:00 AM',
      icon: Icons.medication,
      color: const Color(0xFFFFB74D),
      isCompleted: false,
    ),
    RoutineItem(
      id: '3',
      name: 'Daily Walk',
      time: '10:00 AM',
      icon: Icons.directions_walk,
      color: const Color(0xFFEC407A),
      isCompleted: false,
    ),
  ];

  final List<RoutineItem> afternoonRoutines = [
    RoutineItem(
      id: '4',
      name: 'Lunch',
      time: '01:00 PM',
      icon: Icons.lunch_dining,
      color: const Color(0xFFFF7675),
      isCompleted: false,
    ),
    RoutineItem(
      id: '5',
      name: 'Appointment',
      time: '02:00 PM',
      icon: Icons.calendar_today,
      color: const Color(0xFF4ECDC4),
      isCompleted: false,
    ),
  ];

  final List<RoutineItem> eveningRoutines = [
    RoutineItem(
      id: '6',
      name: 'Relax',
      time: '09:00 PM',
      icon: Icons.chair,
      color: const Color(0xFF81C784),
      isCompleted: false,
    ),
  ];

  List<DateTime> _getWeekDates() {
    final weekday = selectedDate.weekday;
    final startOfWeek = selectedDate.subtract(Duration(days: weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Routine',
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

              // Day/Week Toggle
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
                        child: _buildToggleButton('Day', 'Day'),
                      ),
                      Expanded(
                        child: _buildToggleButton('Week', 'Week'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Date Selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('MMMM d').format(selectedDate),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Color(0xFF1A1A2E)),
                          const SizedBox(width: 8),
                          Text(
                            selectedMonth,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.expand_more,
                            color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Calendar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        final date = weekDates[index];
                        final dayName = DateFormat('EEE').format(date);
                        final isSelected = date.day == selectedDate.day;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                              selectedMonth = DateFormat('MMMM, yyyy').format(selectedDate);
                            });
                          },
                          child: Column(
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
                                  color: isSelected ? const Color(0xFF1A1A2E) : Colors.white,
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
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Morning Routine
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Morning Routine',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8C42),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Add more',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ...morningRoutines.map((routine) => _buildRoutineCard(routine)),
              const SizedBox(height: 24),

              // Afternoon Routine
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  'Afternoon Routine',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...afternoonRoutines.map((routine) => _buildRoutineCard(routine)),
              const SizedBox(height: 24),

              // Evening Routine
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  'Evening Routine',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...eveningRoutines.map((routine) => _buildRoutineCard(routine)),
              const SizedBox(height: 24),

              // View Weekly Progress Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A2E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HealthScoreScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'View Weekly Progress',
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
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

  Widget _buildRoutineCard(RoutineItem routine) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                routine.isCompleted = !routine.isCompleted;
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: routine.isCompleted ? routine.color : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: routine.color,
                  width: 2,
                ),
              ),
              child: routine.isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          // Dotted Line (visual connector)
          if (!routine.isCompleted)
            Column(
              children: [
                const SizedBox(height: 24),
                SizedBox(
                  height: 20,
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                    size: const Size(2, 20),
                  ),
                ),
              ],
            )
          else
            const SizedBox(width: 2, height: 44),

          const SizedBox(width: 12),

          // Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: routine.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      routine.icon,
                      size: 20,
                      color: routine.color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          routine.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          routine.time,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
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
              _buildNavItem(Icons.home, 'Home', false, () {
                Navigator.pop(context);
              }),
              _buildNavItem(Icons.sentiment_satisfied, 'Mood', false, () {}),
              _buildNavItem(Icons.calendar_today, 'Routine', true, () {}),
              _buildNavItem(Icons.group, 'Care Circle', false, () {}),
              _buildNavItem(Icons.emergency, 'SOS', false, () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
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

class RoutineItem {
  final String id;
  final String name;
  final String time;
  final IconData icon;
  final Color color;
  bool isCompleted;

  RoutineItem({
    required this.id,
    required this.name,
    required this.time,
    required this.icon,
    required this.color,
    this.isCompleted = false,
  });
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 3.0;
    const dashSpace = 3.0;
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 2;

    double y = 0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(1, y),
        Offset(1, y + dashWidth),
        paint,
      );
      y += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DottedLinePainter oldDelegate) => false;
}
