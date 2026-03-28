import 'package:flutter/material.dart';

class PaidPlanSetupScreen extends StatefulWidget {
  const PaidPlanSetupScreen({super.key});

  @override
  State<PaidPlanSetupScreen> createState() => _PaidPlanSetupScreenState();
}

class _PaidPlanSetupScreenState extends State<PaidPlanSetupScreen> {
  bool emergencyDetection = false;
  bool fallDetection = false;
  bool shakeToAlert = false;
  bool voiceTrigger = false;

  void _showContactPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactSetupSheet(),
    ).then((activated) {
      if (activated == true) {
        setState(() {
          emergencyDetection = true;
          fallDetection = true;
          shakeToAlert = true;
          voiceTrigger = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
        ),
        title: const Text(
          'Paid Plan Setup',
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
            icon: const Icon(Icons.more_vert, color: Color(0xFF1A1A2E)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildSwitchCard(
              title: 'Emergency Detection',
              subtitle: 'Automated safety monitoring active',
              value: emergencyDetection,
              onChanged: (val) {
                if (!emergencyDetection) {
                  _showContactPopup();
                } else {
                  setState(() => emergencyDetection = val);
                }
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Automatic Triggers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 16),
            _buildSwitchCard(
              title: 'Fall Detection',
              subtitle: 'Alerts contacts if sudden fall is detected via accelerometer.',
              value: fallDetection,
              onChanged: (val) => setState(() => fallDetection = val),
            ),
            const SizedBox(height: 12),
            _buildSwitchCard(
              title: 'Shake to Alert',
              subtitle: 'Quickly shake your phone three times to trigger silent SOS.',
              value: shakeToAlert,
              onChanged: (val) => setState(() => shakeToAlert = val),
            ),
            const SizedBox(height: 12),
            _buildSwitchCard(
              title: 'Voice Trigger',
              subtitle: 'Say "Help Help" loudly to active the emergency sequence.',
              value: voiceTrigger,
              onChanged: (val) => setState(() => voiceTrigger = val),
            ),
            const Spacer(),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Connect to Emergency Hub 24/7',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          _CustomSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: value ? const Color(0xFFFF8C42) : const Color(0xFFE0E0E0),
          border: Border.all(
            color: value ? const Color(0xFFFF8C42) : const Color(0xFFD0D0D0),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSetupSheet extends StatelessWidget {
  const ContactSetupSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 16,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 20, color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Set Your Primary\nEmergency Contact',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Once set, shaking your phone or using a voice trigger will immediately notify this contact & start an automatic call.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black45,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter family number',
              hintStyle: const TextStyle(color: Colors.black26),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFFF8C42)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF7F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.lock_outline, size: 14, color: Colors.black45),
                SizedBox(width: 8),
                Text(
                  'ENCRYPTED & SECURE PRIVACY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true); // Return true to indicate activation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8C42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Save & Active',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
