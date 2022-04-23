import 'package:flutter/material.dart';
import 'package:translator_app/component/text_theme.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget? widget;
  final TextEditingController? controller;

  const CustomInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.widget,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: CustomTextTheme().body1Style,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            readOnly: widget == null ? false : true,
            controller: controller,
            autofocus: false,
            style: CustomTextTheme().body2Style,
            decoration: InputDecoration(
              suffixIcon: widget ?? const SizedBox.shrink(),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.blue,
                  )),
              hintText: hint,
              hintStyle: widget == null
                  ? CustomTextTheme().body2Style.apply(
                        color: Colors.black.withOpacity(0.6),
                      )
                  : CustomTextTheme().body2Style,
            ),
          )
        ],
      ),
    );
  }
}
