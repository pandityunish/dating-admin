import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double height;
  final String onText;
  final String offText;
  final double thumbSize;
  final Duration animationDuration;

  const CustomToggleSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.black12,
    this.width = 55,
    this.height = 35,
    this.onText = "On",
    this.offText = "Off",
    this.thumbSize = 20,
    this.animationDuration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(CustomToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
  }

  void _toggleValue() {
    final newValue = !_value;
    setState(() => _value = newValue);
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Track
          AnimatedContainer(
            duration: widget.animationDuration,
            decoration: BoxDecoration(
              color: _value ? widget.activeColor : widget.inactiveColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            width: widget.width,
            height: widget.height * 0.8, // Proportional to container height
          ),
          // Thumb with text
          Align(
            alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
            child: GestureDetector(
              onTap: _toggleValue,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                height: widget.thumbSize,
                width: widget.thumbSize + 10, // Add some extra width for the text
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  _value ? widget.onText : widget.offText,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
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
