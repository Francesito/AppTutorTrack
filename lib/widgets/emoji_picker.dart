import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EmojiPickerAnimated extends StatefulWidget {
  final int initial;
  final ValueChanged<int> onChanged;
  const EmojiPickerAnimated({super.key, required this.initial, required this.onChanged});

  @override
  State<EmojiPickerAnimated> createState() => _EmojiPickerAnimatedState();
}

class _EmojiPickerAnimatedState extends State<EmojiPickerAnimated> with SingleTickerProviderStateMixin {
  late int _value;
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _value = widget.initial;
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (i) {
        final v = i + 1;
        final selected = v == _value;
        return GestureDetector(
          onTap: () {
            setState(() => _value = v);
            _ctrl.forward(from: 0);
            widget.onChanged(v);
          },
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.05).animate(_ctrl),
            child: Opacity(
              opacity: selected ? 1 : 0.5,
              child: Image.asset(kEmojiAssets[v]!, width: 48, height: 48),
            ),
          ),
        );
      }),
    );
  }
}
