import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _colorAnimation = ColorTween(begin: Colors.green, end: Colors.green.shade600).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 - (_scaleAnimation.value * 0.05),
          child: ElevatedButton.icon(
            onPressed: () {
              _controller.forward().then((_) {
                _controller.reverse().then((_) {
                  Navigator.of(context).pop();
                });
              });
            },
            icon: Icon(Icons.check, color: Colors.white),
            label: Text('Aceptar'),
            style: ElevatedButton.styleFrom(
              primary: _colorAnimation.value,
              onPrimary: Colors.white, // Para el texto y el icono
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              shadowColor: Colors.green.shade400,
              elevation: _scaleAnimation.value * 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
