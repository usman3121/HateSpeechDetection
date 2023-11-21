import 'package:flutter/material.dart';

class _UsmanButtonState extends State<UsmanButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: Container(
        height: 75,
        width: 175,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            primary: _isHovered ? Colors.green : Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class UsmanButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const UsmanButton({super.key, required this.label, required this.onPressed});

  @override
  _UsmanButtonState createState() => _UsmanButtonState();
}
