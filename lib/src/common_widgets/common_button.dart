import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final Color color;
  final String text;
  final VoidCallback onTap; // Callback function for onTap

  const CommonButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
          widget.onTap(); // Call the onTap function passed from parent
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          alignment: Alignment.center,
          transform: _isPressed
              ? Matrix4.identity().scaled(0.97) // Slightly shrink when pressed
              : Matrix4.identity(),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white, // Adjust text color if needed
            ),
          ),
        ),
      ),
    );
  }
}
