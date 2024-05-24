import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        this.onPress,
        this.backgroundColor,
        this.height,
        this.width,
        this.radius,
        this.buttonText,
        this.textColor,
        this.src,this.isShowIcon,this.enableButton});

  final void Function()? onPress;
  final dynamic backgroundColor;
  final dynamic height;
  final dynamic width;
  final dynamic radius;
  final dynamic buttonText;
  final dynamic textColor;
  final dynamic src;
  final bool?isShowIcon;
  final bool?enableButton;

  @override
  Widget build(BuildContext context) {
    return _customButton(
        onPress, backgroundColor, height, width, buttonText, textColor, src,isShowIcon,enableButton,radius);
  }
}

Widget _customButton(void Function()? onPress, backgroundColor, height, width,
    buttonText, textColor, src,isShowIcon,enableButton,radius) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
      onPressed: enableButton?onPress:null,
      style: ElevatedButton.styleFrom(
        // Text color
        backgroundColor: backgroundColor,
        elevation: 0.0, // Elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0), // Button padding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(visible: isShowIcon??false, child: Image.asset(src ?? '')),
          const SizedBox(width: 8.0),
          Text(buttonText ?? '', style: TextStyle(color: textColor ?? '')),
        ],
      ),
    ),
  );
}
