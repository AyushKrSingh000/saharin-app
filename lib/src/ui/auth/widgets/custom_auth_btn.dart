import 'package:saharin/src/constants/colors.dart';
import 'package:saharin/src/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAuthBtn extends ConsumerStatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isProcessing;
  final Color? borderColor;
  final double height;
  final double? width;
  const CustomAuthBtn({
    super.key,
    required this.height,
    required this.isProcessing,
    required this.onTap,
    required this.text,
    this.borderColor,
    this.width,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomAuthBtnState();
}

class _CustomAuthBtnState extends ConsumerState<CustomAuthBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        height: widget.height,
        width: widget.width,
        child: Center(
          child: widget.isProcessing
              ? const Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FittedBox(
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: Fonts.helvtica,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
