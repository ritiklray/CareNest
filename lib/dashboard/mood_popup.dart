import 'package:flutter/material.dart';

class MoodPopup extends StatefulWidget {
  const MoodPopup({super.key});

  @override
  State<MoodPopup> createState() => _MoodPopupState();
}

class _MoodPopupState extends State<MoodPopup> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  double _sliderValue = 2.0; // 0-4 range, default neutral (2)

  final List<MoodData> moods = [
    MoodData(
      emoji: '😍',
      label: 'Amazing',
      color: const Color(0xFF8B7FEE),
      lightColor: const Color(0xFFE5E3FF),
    ),
    MoodData(
      emoji: '😊',
      label: 'Great',
      color: const Color(0xFF6BCB77),
      lightColor: const Color(0xFFD4F4D9),
    ),
    MoodData(
      emoji: '😐',
      label: 'Neutral',
      color: const Color(0xFFFFD93D),
      lightColor: const Color(0xFFFFF4CC),
    ),
    MoodData(
      emoji: '😔',
      label: 'Sad',
      color: const Color(0xFFFF9B71),
      lightColor: const Color(0xFFFFE5D9),
    ),
    MoodData(
      emoji: '😠',
      label: 'Angry',
      color: const Color(0xFFFF6B6B),
      lightColor: const Color(0xFFFFDCDC),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  MoodData get _currentMood {
    // Reverse the index so top = best mood, bottom = worst mood
    int index = (4 - _sliderValue.round()).clamp(0, moods.length - 1);
    return moods[index];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currentMood = _currentMood;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  currentMood.lightColor,
                  Colors.white,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 40),
                        const Text(
                          'How are you feeling?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Color(0xFF1A1A2E)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Current Mood Display
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: currentMood.color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      currentMood.emoji,
                      style: const TextStyle(fontSize: 70),
                    ),
                  ),

                  const SizedBox(height: 12),

                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: currentMood.color,
                    ),
                    child: Text(currentMood.label),
                  ),

                  const SizedBox(height: 30),

                  // Vertical Mood Slider
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Emoji indicators on left
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              final mood = moods[index];
                              // Top emoji (index 0) should match slider at top (value 4)
                              final isSelected = _sliderValue.round() == (4 - index);
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isSelected ? 1.0 : 0.3,
                                  child: Text(
                                    mood.emoji,
                                    style: TextStyle(
                                      fontSize: isSelected ? 28 : 22,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(width: 30),

                          // Draggable Slider
                          SizedBox(
                            height: screenHeight * 0.35,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 8,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 14,
                                    elevation: 4,
                                  ),
                                  overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 24,
                                  ),
                                  activeTrackColor: currentMood.color,
                                  inactiveTrackColor: currentMood.color.withValues(alpha: 0.2),
                                  thumbColor: currentMood.color,
                                  overlayColor: currentMood.color.withValues(alpha: 0.2),
                                ),
                                child: Slider(
                                  value: _sliderValue,
                                  min: 0,
                                  max: 4,
                                  divisions: 4,
                                  onChanged: (value) {
                                    setState(() {
                                      _sliderValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Save Button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentMood.color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          final navigator = Navigator.of(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mood "${currentMood.label}" saved!'),
                              backgroundColor: currentMood.color,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                          Future.delayed(const Duration(milliseconds: 500), () {
                            navigator.pop();
                          });
                        },
                        child: const Text(
                          'Save Mood',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoodData {
  final String emoji;
  final String label;
  final Color color;
  final Color lightColor;

  MoodData({
    required this.emoji,
    required this.label,
    required this.color,
    required this.lightColor,
  });
}
