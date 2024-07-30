import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomScaffold extends ConsumerStatefulWidget {
  final Widget child;
  final Color? bgColor;
  const CustomScaffold({
    super.key,
    required this.child,
    this.bgColor,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends ConsumerState<CustomScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 28),
        child: Scaffold(
            body: Stack(
          children: [
            widget.child,
          ],
        )),
      ),
    );
  }
}
