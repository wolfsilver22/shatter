import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({Key? key, required this.child}) : super(key: key);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Ball> balls = [];

  @override
  void initState() {
    super.initState();

    // إنشاء 15 كرة بأحجام وألوان مختلفة
    final random = Random();
    for (int i = 0; i < 15; i++) {
      balls.add(Ball(
        size: random.nextDouble() * 40 + 20, // حجم بين 20 و 60
        color: _getRandomColor(random),
        speedX: random.nextDouble() * 2 - 1, // سرعة بين -1 و 1
        speedY: random.nextDouble() * 2 - 1,
      ));
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
  }

  Color _getRandomColor(Random random) {
    final colors = [
      Color(0xFF1E88E5).withOpacity(0.3),
      Color(0xFF1565C0).withOpacity(0.25),
      Color(0xFF42A5F5).withOpacity(0.2),
      Color(0xFF90CAF9).withOpacity(0.15),
      Colors.white.withOpacity(0.1),
    ];
    return colors[random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E88E5), // الخلفية الزرقاء الأساسية
      body: Stack(
        children: [
          // الأنيميشن في الخلفية
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              _updateBalls();
              return CustomPaint(
                painter: BallPainter(balls),
                size: Size.infinite,
              );
            },
          ),

          // المحتوى الأصلي
          widget.child,
        ],
      ),
    );
  }

  void _updateBalls() {
    final time = _controller.value * 2 * pi;

    for (var ball in balls) {
      // تحديث المواقع مع حركة جيبية لسلاسة أكثر
      ball.x += ball.speedX * 0.5 + sin(time + ball.size) * 0.3;
      ball.y += ball.speedY * 0.5 + cos(time + ball.size) * 0.3;

      // تغيير الاتجاه عند الوصول للحواف
      if (ball.x < -50 || ball.x > MediaQuery.of(context).size.width + 50) {
        ball.speedX *= -1;
      }
      if (ball.y < -50 || ball.y > MediaQuery.of(context).size.height + 50) {
        ball.speedY *= -1;
      }
    }
  }
}

class Ball {
  double x = 0;
  double y = 0;
  double size;
  Color color;
  double speedX;
  double speedY;

  Ball({
    required this.size,
    required this.color,
    required this.speedX,
    required this.speedY,
  }) {
    // وضع عشوائي ابتدائي
    final random = Random();
    x = random.nextDouble() * 400;
    y = random.nextDouble() * 800;
  }
}

class BallPainter extends CustomPainter {
  final List<Ball> balls;

  BallPainter(this.balls);

  @override
  void paint(Canvas canvas, Size size) {
    for (var ball in balls) {
      final paint = Paint()
        ..color = ball.color
        ..style = PaintingStyle.fill;

      // رسم الكرة مع تأثير تدرج لوني
      final gradient = RadialGradient(
        colors: [
          ball.color.withOpacity(0.8),
          ball.color.withOpacity(0.3),
          ball.color.withOpacity(0.1),
        ],
      );

      final paintWithGradient = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(
            center: Offset(ball.x, ball.y),
            radius: ball.size / 2,
          ),
        );

      canvas.drawCircle(
        Offset(ball.x, ball.y),
        ball.size / 2,
        paintWithGradient,
      );

      // تأثير إشعاعي خفيف
      final glowPaint = Paint()
        ..color = ball.color.withOpacity(0.1)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, ball.size * 0.5);

      canvas.drawCircle(
        Offset(ball.x, ball.y),
        ball.size * 0.8,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}