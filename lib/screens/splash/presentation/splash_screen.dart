import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/screens/auth/presentation/screen/login_screen.dart';
import 'package:fuel_application/screens/branch/presentation/screen/branch_screen.dart';
import 'package:fuel_application/screens/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:fuel_application/screens/splash/logic/splash_cubit.dart';
import 'package:fuel_application/screens/splash/logic/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const Color primary = Color(0xFF0035C5);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashUnauthenticated) {
            // Case 1: No user data -> Login
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
            );
          } else if (state is SplashSelectBranch) {
            // Case 2: User data saved, Branch missing -> Branch Selection
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const BranchScreen()),
                  (route) => false,
            );
          } else if (state is SplashAuthenticated) {
            // Case 3: Both User data & Branch saved -> Dashboard
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  (route) => false,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox.expand(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SafeArea(
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "FuelBoard",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E1E1E),
                          letterSpacing: 3.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "ENTERPRISE STATION MANAGER",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const Spacer(flex: 3),
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            SplashScreen.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}