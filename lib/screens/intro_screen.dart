import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_colors.dart';
import '../widgets/intro_page_widget.dart';
import 'login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPageData> _pages = [
    IntroPageData(
      icon: Icons.account_balance_wallet,
      title: 'Welcome to CashFlow',
      description:
          'Your personal finance companion. Track income, expenses, and manage your money effortlessly.',
      color: AppColors.primary,
    ),
    IntroPageData(
      icon: Icons.account_balance,
      title: 'Manage Multiple Accounts',
      description:
          'Create and manage multiple accounts like bank accounts, cash, credit cards, and more.',
      color: AppColors.income,
    ),
    IntroPageData(
      icon: Icons.receipt_long,
      title: 'Track Transactions',
      description:
          'Record all your income and expenses with categories, dates, and notes for better organization.',
      color: AppColors.expense,
    ),
    IntroPageData(
      icon: Icons.analytics,
      title: 'Insights & Reports',
      description:
          'View detailed reports, charts, and analytics to understand your spending patterns and net worth.',
      color: AppColors.secondary,
    ),
    IntroPageData(
      icon: Icons.security,
      title: 'Complete Privacy',
      description:
          'All your financial data stays right here on your device. No cloud uploads, no tracking. Use CashFlow with complete peace of mind.',
      color: Color(0xFF00BCD4),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);

    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeIntro,
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ),

              // Page View
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return IntroPageWidget(data: _pages[index]);
                  },
                ),
              ),

              // Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.primary
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Next/Get Started Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _completeIntro();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Privacy Note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 14, color: Colors.white54),
                  SizedBox(width: 6),
                  Text(
                    'Your data is stored locally on this device',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroPageData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  IntroPageData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
