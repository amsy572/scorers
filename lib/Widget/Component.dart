import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomWidget{
  static void showSnackbar(BuildContext context, String? message, {Color? backgroundColor}) {
    final snackBar = SnackBar(
      content: Text(message!),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  static void showGetSnackbar(String? message,String Title, {Color? backgroundColor,Color? textColor}) {
    final snackBar = SnackBar(
      content: Text(message!),
      backgroundColor: backgroundColor,
    );
    Get.snackbar(
      Title,
      message,
      snackPosition: SnackPosition.BOTTOM, // SnackBar position
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: 10, // Border radius
      margin: EdgeInsets.all(10), // Margin around the SnackBar
      duration: Duration(seconds: 3), // Duration for how long the SnackBar is displayed
      // You can also add more options like 'onClose', 'overlayBlur', etc.
    );
  }



  static Widget CText(String? text, {TextStyle? style}) {
    // Check if the text is null and provide a default value if necessary
    final displayText = text ?? 'Default Text'; // Fallback if text is null

    // Return a Text widget with the optional style
    return Text(
      displayText,
      style: style,
      overflow: TextOverflow.ellipsis,
    );
  }



}


/// Custom Row Widget inside a Container
class CustomRowContainer extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double padding;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomRowContainer({
    Key? key,
    required this.children,
    this.spacing = 8.0,
    this.padding = 16.0,
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(width: spacing),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Custom Column Widget inside a Container
class CustomColumnContainer extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double padding;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomColumnContainer({
    Key? key,
    required this.children,
    this.spacing = 8.0,
    this.padding = 16.0,
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: spacing),
            children[i],
          ],
        ],
      ),
    );
  }
}




