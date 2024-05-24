import 'package:flutter/material.dart';

class DecoratedListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final BoxDecoration decoration;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? margin;
  final void Function()? onPressTile;

  const DecoratedListTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.decoration,
    this.contentPadding,
    this.margin,
    this.onPressTile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressTile,
      child: Container(
        decoration: decoration,
        margin: margin,
        child: ListTile(
          title: title,
          subtitle: subtitle,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
