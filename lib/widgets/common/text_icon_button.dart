import 'package:flutter/material.dart';

import '../../config/styles.dart';
class TextIconButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback action;
  final bool showTitle;
  final Color? color;

  const TextIconButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.action, required this.showTitle, this.color = primaryColor,
  }) : super(key: key);

  @override
  _TextIconButtonState createState() => _TextIconButtonState();
}

class _TextIconButtonState extends State<TextIconButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0), // Apply margin here to control outer spacing
      child: MouseRegion(
        onEnter: (_) => setState(() {
          _isHovering = true;
        }),
        onExit: (_) => setState(() {
          _isHovering = false;
        }),
        child: InkWell(
          onTap: widget.action,
          borderRadius: BorderRadius.circular(8.0),
          splashColor: Colors.white.withOpacity(0.2), // Click effect
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10.0), // Inner padding to create space inside the button
            decoration: BoxDecoration(
              color: _isHovering
                  ? widget.color?.withOpacity(0.8) // Hover effect
                  : widget.color, // Default color
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                    widget.icon,
                    color: Colors.white,
                    size :20
                ),
                if(widget.showTitle)const SizedBox(width: 10),
                if(widget.showTitle)Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
