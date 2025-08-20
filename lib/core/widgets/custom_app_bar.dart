import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final Color backgroundColor;
  final Widget? backIcon;
  final Widget? backButtonWidget;
  final Widget? trailingWidget;
  final Widget? actionWidget;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBack,
    this.backgroundColor = Colors.transparent,
    this.backIcon,
    this.backButtonWidget,
    this.trailingWidget,
    this.actionWidget,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: backButtonWidget,
        actions: actionWidget != null ? [actionWidget!] : []);
  }
}