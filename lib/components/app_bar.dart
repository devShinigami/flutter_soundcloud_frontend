import 'dart:ui';

import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final ScrollController controller;
  const MyAppBar({super.key, required this.controller, required this.title});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateBorderVisibility);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_updateBorderVisibility);
  }

  void _updateBorderVisibility() {
    final showBorder = widget.controller.offset > 10;
    if (showBorder != _isVisible) {
      setState(() {
        _isVisible = showBorder;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                    color: _isVisible
                        ? Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.4)
                        : Colors.transparent,
                    width: 0.5),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor.withAlpha(200),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.file_upload_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.chat_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
