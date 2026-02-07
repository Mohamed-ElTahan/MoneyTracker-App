import 'package:flutter/material.dart';
import '../../core/theme/colors_manager.dart';
import '../../core/utils/app_routes.dart';
import '../../core/extension/media_query_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double logoSize = context.w(0.25);

    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              // Logo
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  color: ColorsManager.primaryBlue,
                  borderRadius: BorderRadius.circular(
                    logoSize * 0.24,
                  ), // Proportional radius
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.primaryBlue.withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Center(
                  child: SizedBox(
                    width: logoSize * 0.5,
                    height: logoSize * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBar(height: (logoSize * 0.25).toInt()),
                        _buildBar(height: (logoSize * 0.38).toInt()),
                        _buildBar(height: (logoSize * 0.50).toInt()),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.h(0.03)),
              // App Name
              const Text(
                'MoneyWise',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.textDark,
                ),
              ),
              SizedBox(height: context.h(0.01)),
              // Slogan
              const Text(
                'YOUR FINANCES, SIMPLIFIED',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.textGrey,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              // Footer
              Padding(
                padding: EdgeInsets.only(bottom: context.h(0.05)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorsManager.primaryBlue,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.lock,
                        size: 16,
                        color: ColorsManager.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'SECURE ENCRYPTION ENABLED',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF546E7A), // BlueGrey
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

  Container _buildBar({required int height}) {
    return Container(
      width: 10,
      height: height.toDouble(),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
