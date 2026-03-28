import 'dart:async';
import 'package:flutter/material.dart';
import '../dashboard/home_screen.dart';

class FallDetectionBottomSheet extends StatefulWidget {
  const FallDetectionBottomSheet({super.key});

  @override
  State<FallDetectionBottomSheet> createState() => _FallDetectionBottomSheetState();
}

class _FallDetectionBottomSheetState extends State<FallDetectionBottomSheet> {
  int _secondsRemaining = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        // Here you would automatically trigger Send Help if the timer runs out
        if (mounted) {
           Navigator.pop(context); // Close the sheet automatically
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          
          // Custom Circular Progress
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: _secondsRemaining / 15,
                  strokeWidth: 8,
                  backgroundColor: const Color(0xFFF0F0F0),
                  color: const Color(0xFFFF7A00),
                ),
                Center(
                  child: Text(
                    '${_secondsRemaining}s',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E), 
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Title
          const Text(
            'Are you okay?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 12),

          // Subtitle
          const Text(
            'A sudden fall has been detected.\nCaregivers will be notified automatically\nif you don\'t respond.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF757575),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Yeah, I'm Alright Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A2E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Yeah, I\'m Alright',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Send Help Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the sheet
                // Additional send help logic can go here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A00),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.notifications_active, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Send Help',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
