import 'package:flutter/material.dart';
import 'paid_plan_setup_screen.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2), // Light peach background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Header with Title and Plus Badge
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'CareNest',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE8E0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Plus',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFF8C42),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: const Icon(Icons.close, size: 20, color: Color(0xFF1A1A2E)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Title and Subtitle
              const Text(
                'Unlock your Safety',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A2E),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Advanced safety tools designed for ultimate family peace of mind.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Plans Tab
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EAE4),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Basic plan',
                            style: TextStyle(
                              fontWeight: FontWeight.w800, 
                              color: Color(0xFF1A1A2E),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: const Center(
                          child: Text(
                            'Super plan',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Feature List
              _buildFeatureItem(
                icon: Icons.auto_fix_high,
                title: 'Live SOS Tracking',
                subtitle: 'Real-time location sharing with emergency contacts.',
              ),
              _buildFeatureItem(
                icon: Icons.mic_none,
                title: 'Hands-free Voice Help',
                subtitle: 'Trigger help using pre-set safety phrases.',
              ),
              _buildFeatureItem(
                icon: Icons.vibration,
                title: 'Shake to Alert',
                subtitle: 'A simple vigorous shake sends immediate alerts.',
              ),
              _buildFeatureItem(
                icon: Icons.personal_injury_outlined,
                title: 'Advanced Fall Detection',
                subtitle: 'Automatic alerts if a sudden impact is detected.',
              ),
              const SizedBox(height: 40),

              // Pricing Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPriceCard(
                            label: 'Monthly',
                            price: '₹199',
                            period: '/ Month',
                            isSelected: false,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildPriceCard(
                            label: 'Yearly',
                            price: '₹1899',
                            period: '/ Year',
                            discount: '-18%',
                            isSelected: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PaidPlanSetupScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E1E1E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Start 7-day free trail',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Restore subscription',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Privacy Policy - Terms of Service',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]
            ),
            child: Icon(icon, size: 22, color: const Color(0xFF1A1A2E)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard({
    required String label,
    required String price,
    required String period,
    String? discount,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFE8E0).withValues(alpha: 0.8) : const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? const Color(0xFFFF8C42) : Colors.black.withValues(alpha: 0.05),
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? const Color(0xFFFF8C42) : Colors.black45,
                    ),
                  ),
                  if (discount != null) ...[
                    const SizedBox(width: 6),
                    Text(
                      discount,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFFF8C42),
                      ),
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: price,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    TextSpan(
                      text: '\n$period',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isSelected)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8C42),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
