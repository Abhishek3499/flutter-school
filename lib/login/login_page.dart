import 'package:flutter/material.dart';
import 'login_validator.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final LoginController controller = LoginController();

  late final AnimationController _bgController;
  late final Animation<double> _bgAnim;
  late final AnimationController _logoController;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoBounce;

  @override
  void initState() {
    super.initState();
    // re-render when controller notifies (e.g., toggling showPass)
    controller.addListener(() => setState(() {}));

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _bgAnim = Tween<double>(
      begin: -0.35,
      end: 0.35,
    ).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));

    // logo animations: fade + zoom-in + subtle bounce
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _logoOpacity = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.6,
          end: 1.06,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.06,
          end: 0.98,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.98,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 10,
      ),
    ]).animate(_logoController);

    _logoBounce = Tween<double>(begin: 16.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );

    // start after a short delay to avoid clashing with background motion on entry
    Future.delayed(
      const Duration(milliseconds: 200),
      () => _logoController.forward(),
    );
  }

  @override
  void dispose() {
    _bgController.dispose();
    _logoController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Animated gradient + glow layers behind the content
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgAnim,
              builder: (context, child) {
                // derive moving offsets from animation value
                final dx = _bgAnim.value;
                final dy = -_bgAnim.value * 0.6;

                final lightGradient = const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFBEE6FF), Color(0xFF8A5CFF)],
                );

                final darkGradient = const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF071223), Color(0xFF0B1020)],
                );

                return Container(
                  decoration: BoxDecoration(
                    gradient: theme.brightness == Brightness.dark
                        ? darkGradient
                        : lightGradient,
                  ),
                  child: Stack(
                    children: [
                      // Top-left glowing circle (moves slightly)
                      Align(
                        alignment: Alignment(-0.9 + dx, -0.8 + dy),
                        child: Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: theme.brightness == Brightness.dark
                                  ? [
                                      Colors.deepPurple.withOpacity(0.35),
                                      Colors.transparent,
                                    ]
                                  : [
                                      Colors.lightBlue.withOpacity(0.35),
                                      Colors.transparent,
                                    ],
                              stops: const [0.0, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Bottom-right glowing circle (moves in opposite direction)
                      Align(
                        alignment: Alignment(0.9 - dx, 0.9 - dy),
                        child: Container(
                          width: 340,
                          height: 340,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: theme.brightness == Brightness.dark
                                  ? [
                                      Colors.purpleAccent.withOpacity(0.22),
                                      Colors.transparent,
                                    ]
                                  : [
                                      Colors.purple.withOpacity(0.26),
                                      Colors.transparent,
                                    ],
                              stops: const [0.0, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Centered scrollable content (login card)
          Positioned.fill(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: theme.brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.6)
                            : Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Login  ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Start Your Coding Journey Today',
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.brightness == Brightness.dark
                                ? Colors.white60
                                : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Logo (placeholder). Replace with an asset image if you add one to
                        // `assets/` and update `pubspec.yaml`.
                        Center(
                          child: FadeTransition(
                            opacity: _logoOpacity,
                            child: AnimatedBuilder(
                              animation: _logoScale,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _logoBounce.value),
                                  child: Transform.scale(
                                    scale: _logoScale.value,
                                    child: child,
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: theme.colorScheme.primary,
                                child: Icon(
                                  Icons.school,
                                  size: 36,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Welcome to Flutter School',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        const SizedBox(height: 20),

                        // PHONE
                        TextFormField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: phoneValidator,
                        ),
                        const SizedBox(height: 14),

                        // PASSWORD
                        TextFormField(
                          controller: controller.passController,
                          obscureText: !controller.showPass,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.showPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => controller.toggleShowPass(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: passwordValidator,
                        ),
                        const SizedBox(height: 10),

                        // FORGOT
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Forgot Password"),
                                  content: Text(
                                    "Enter mobile number to reset your password",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text("Forgot Password?"),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // SIGN IN BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor:
                                  theme.brightness == Brightness.dark
                                  ? Colors.deepPurpleAccent
                                  : Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => controller.submit(context),
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Social login
                        Center(
                          child: Column(
                            children: [
                              const Text(
                                'or',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),

                              // Full-width social buttons stacked vertically
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            theme.brightness == Brightness.dark
                                            ? Colors.white10
                                            : Colors.white,
                                        side: BorderSide(
                                          color: theme.dividerColor,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () =>
                                          controller.signInWithGoogle(context),
                                      icon: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          'G',
                                          style: TextStyle(
                                            color: Colors.redAccent.shade200,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      label: Text(
                                        'Login with Google',
                                        style: TextStyle(
                                          color:
                                              theme.brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            theme.brightness == Brightness.dark
                                            ? Colors.white10
                                            : Colors.white,
                                        side: BorderSide(
                                          color: theme.dividerColor,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () =>
                                          controller.signInWithGmail(context),
                                      icon: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          'M',
                                          style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      label: Text(
                                        'Login with Gmail',
                                        style: TextStyle(
                                          color:
                                              theme.brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
