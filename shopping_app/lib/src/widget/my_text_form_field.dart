import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText, labelText;
  final Icon? prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTab;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final Function(bool)? onFocusChange;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final Color? color;
  final Color? borderColor;
  final int? maxlies;
  final bool disable;
  final List<TextInputFormatter>? inputFormatters;
  const MyTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.onTab,
    this.textEditingController,
    this.readOnly = false,
    this.labelText,
    this.onChanged,
    this.validator,
    this.onFocusChange,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textAlign,
    this.focusNode,
    this.suffixIcon,
    this.initialValue,
    this.onSaved,
    this.color,
    this.borderColor,
    this.maxlies,
    this.disable = false,
    this.inputFormatters,
    // this.autofocus = false,
  });

  Color get disableTextColor => const Color(0xFFA6AAAD);

  @override
  Widget build(BuildContext context) {
    return Focus(
      //autofocus: autofocus,
      onFocusChange: onFocusChange,
      //focusNode: ,
      child: TextFormField(
        //maxLines: maxlies,
        enabled: !disable,
        readOnly: readOnly,
        key: key,
        //autofocus: autofocus,
        focusNode: focusNode,
        keyboardType: keyboardType,
        controller: textEditingController,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        onTap: onTab,
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.left,
        validator: validator,
        style: Get.textTheme.titleMedium
            ?.copyWith(color: disable ? disableTextColor : Colors.black),
        initialValue: initialValue,
        maxLength: maxlies,
        onSaved: onSaved,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          prefixIcon: prefixIcon,
          counterText: '',
          errorStyle: const TextStyle(fontSize: 11, color: Colors.redAccent),
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          filled: color != null || disable,
          fillColor: disable ? Color(0xFFEEEEEE) : color,
          contentPadding: const EdgeInsets.all(12),
          hintText: hintText,
          hintStyle: Get.textTheme.titleMedium?.copyWith(color: Colors.grey),
          //labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: color != null
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFEEEEEE)),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: color != null
                ? BorderSide.none
                : BorderSide(color: borderColor ?? Color(0xFFB7BABD)),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: color != null
                  ? BorderSide.none
                  : BorderSide(color: borderColor ?? Color(0xFFB7BABD))
              // borderSide: BorderSide(
              //     color: readOnly ? Colors.grey : const Color(0xFF000000),
              //     width: 2),
              ),
        ),
      ),
    );
  }
}

class MyTextFormFieldNumber extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool disable;
  const MyTextFormFieldNumber(
      {super.key, required this.textEditingController, this.disable = false});

  @override
  State<MyTextFormFieldNumber> createState() => _MyTextFormFieldNumberState();
}

class _MyTextFormFieldNumberState extends State<MyTextFormFieldNumber> {
  final TextEditingController _controller = TextEditingController();
  MaskTextInputFormatter inputFormatter = MaskTextInputFormatter(
    mask: '###-###-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    if (widget.textEditingController.text.isNotEmpty) {
      _controller.text =
          inputFormatter.maskText(widget.textEditingController.text);
    }

    _controller.addListener(() {
      inputFormatter.formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(text: _controller.text),
      );

      widget.textEditingController.text = _controller.text.replaceAll('-', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      keyboardType: TextInputType.number,
      textEditingController: _controller,
      disable: widget.disable,
      inputFormatters: [inputFormatter],
    );
  }
}

class MyTextFormFieldMaxLine extends StatelessWidget {
  final String? hintText, labelText;
  final Icon? prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTab;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final Function(bool)? onFocusChange;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final int maxLines;
  final Color? color;

  const MyTextFormFieldMaxLine({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.onTab,
    this.textEditingController,
    this.readOnly = false,
    this.labelText,
    this.onChanged,
    this.validator,
    this.onFocusChange,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textAlign,
    this.focusNode,
    this.suffixIcon,
    this.initialValue,
    this.onSaved,
    this.color,
    required this.maxLines,
    // this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      //autofocus: autofocus,
      keyboardType: keyboardType,
      controller: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      onTap: onTab,
      onChanged: onChanged,
      textAlign: textAlign ?? TextAlign.left,
      validator: validator,
      style: Theme.of(context).textTheme.bodyMedium,
      initialValue: initialValue,
      maxLines: maxLines,
      onSaved: onSaved,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        prefixIcon: prefixIcon,
        errorStyle: const TextStyle(fontSize: 11, color: Colors.redAccent),
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        filled: color != null,
        fillColor: color,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),

        hintText: hintText,

        hintStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
        //labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: color != null ? BorderSide.none : const BorderSide(),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: color != null ? BorderSide.none : const BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: color != null ? BorderSide.none : const BorderSide(),
          // borderSide: BorderSide(
          //     color: readOnly ? Colors.grey : const Color(0xFF000000),
          //     width: 2),
        ),
      ),
    );
  }
}

// class MyTextFormFieldBuilder extends StatelessWidget {
//   final String? hintText, labelText, initialValue;
//   final Icon? prefixIcon;
//   final bool obscureText;
//   final bool readOnly;
//   final Function()? onTab;
//   final Function(String)? onFieldSubmitted;
//   final String? Function(String?)? validator;
//   final TextInputType? keyboardType;
//   final Function(String?)? onChanged;
//   final TextEditingController? textEditingController;
//   final Function(bool)? onFocusChange;
//   final TextAlign? textAlign;
//   final FocusNode? focusNode;
//   final Widget? suffixIcon;
//   final String name;
//   final int? maxLines;

//   const MyTextFormFieldBuilder({
//     Key? key,
//     this.hintText,
//     this.prefixIcon,
//     this.obscureText = false,
//     this.onTab,
//     this.textEditingController,
//     this.readOnly = false,
//     this.labelText,
//     this.onChanged,
//     this.validator,
//     this.onFocusChange,
//     this.onFieldSubmitted,
//     this.keyboardType,
//     this.textAlign,
//     this.focusNode,
//     this.suffixIcon,
//     required this.name,
//     this.initialValue,
//     this.maxLines = 1,
//     // this.autofocus = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Focus(
//       //autofocus: autofocus,
//       onFocusChange: onFocusChange,
//       //focusNode: ,
//       child: FormBuilderTextField(
//         name: name,
//         readOnly: readOnly,
//         initialValue: initialValue,
//         focusNode: focusNode,
//         keyboardType: keyboardType,
//         controller: textEditingController,
//         //onFieldSubmitted: onFieldSubmitted,
//         obscureText: obscureText,
//         maxLines: maxLines,
//         onTap: onTab,
//         onChanged: onChanged,
//         textAlign: textAlign ?? TextAlign.left,
//         validator: validator,
//         decoration: InputDecoration(
//           suffixIcon: suffixIcon,
//           labelText: labelText,
//           prefixIcon: prefixIcon,
//           errorStyle: const TextStyle(fontSize: 11, color: Colors.redAccent),
//           filled: readOnly,
//           fillColor: readOnly == true
//               ? const Color.fromARGB(255, 219, 226, 231)
//               : null,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//           hintText: hintText,
//           hintStyle: Theme.of(context)
//               .textTheme
//               .bodySmall!
//               .copyWith(color: Colors.grey),
//           labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(),
//           errorBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(8.0),
//             ),
//             borderSide: BorderSide(
//               color: Colors.red,
//             ),
//           ),
//           focusedErrorBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(8.0),
//             ),
//             borderSide: BorderSide(
//               color: Colors.red,
//             ),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(8.0),
//             ),
//             borderSide: BorderSide(
//               color: Colors.grey,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: const BorderRadius.all(
//               Radius.circular(8.0),
//             ),
//             borderSide: BorderSide(
//                 color: readOnly ? Colors.grey : Colors.indigo, width: 2),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyFormFieldInTable extends StatelessWidget {
//   final String? hintText, labelText;
//   final Icon? prefixIcon;
//   final bool obscureText;
//   final TextAlign? textAlign;
//   final bool readOnly;
//   final Function()? onTab;
//   final Function(bool)? onFocusChange;
//   final String? Function(String?)? validator;
//   final Function(String)? onChanged;
//   final TextInputType? keyboardType;
//   final TextEditingController? textEditingController;

//   const MyFormFieldInTable({
//     Key? key,
//     this.hintText,
//     this.prefixIcon,
//     this.obscureText = false,
//     this.onTab,
//     this.textEditingController,
//     this.readOnly = false,
//     this.labelText,
//     this.onChanged,
//     this.validator,
//     this.textAlign,
//     this.onFocusChange,
//     this.keyboardType,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       //height: 50,
//       //alignment: Alignment.center,
//       //color: const Color(0xffc6c9cb),
//       child: Focus(
//         onFocusChange: onFocusChange,
//         child: TextFormField(
//           readOnly: readOnly,
//           controller: textEditingController,
//           obscureText: obscureText,
//           onTap: onTab,
//           onChanged: onChanged,
//           keyboardType: keyboardType,
//           validator: validator,
//           textAlign: textAlign ?? TextAlign.right,
//           decoration: InputDecoration(
//             //labelText: labelText,
//             prefixIcon: prefixIcon,
//             errorStyle: const TextStyle(fontSize: 11, color: Colors.redAccent),
//             filled: readOnly,
//             fillColor: readOnly == true ? const Color(0xffc6c9cb) : null,
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
//             hintText: hintText,
//             hintStyle: readOnly
//                 ? const TextStyle(color: Colors.black, fontSize: 13)
//                 : MyTextStyle.textHisText,
//             labelStyle: readOnly
//                 ? const TextStyle(
//                     color: Colors.black54,
//                   )
//                 : MyTextStyle.textHisText,
//             focusedBorder: readOnly
//                 ? const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xffc6c9cb),
//                     ),
//                   )
//                 : const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Palette.kToDark,
//                     ),
//                   ),
//             enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Color(0xffc6c9cb),
//               ),
//             ),
//             border: readOnly
//                 ? const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xffc6c9cb),
//                     ),
//                   )
//                 : const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Palette.kToDark,
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyTextFormFieldMaxLines extends StatelessWidget {
//   final String? hintText, labelText;
//   final Icon? prefixIcon;
//   final bool obscureText;
//   final int? maxLines;
//   final bool readOnly;
//   final Function()? onTab;
//   final TextEditingController? textEditingController;

//   const MyTextFormFieldMaxLines({
//     Key? key,
//     this.hintText,
//     this.prefixIcon,
//     this.obscureText = false,
//     this.onTab,
//     this.textEditingController,
//     this.readOnly = false,
//     this.maxLines,
//     this.labelText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Column(
//           children: [
//             Text(labelText ?? ''),
//             MyWidget.mySizedBox(size: 4, type: 'h'),
//           ],
//         ),
//         TextFormField(
//           readOnly: readOnly,
//           maxLines: maxLines,
//           controller: textEditingController,
//           obscureText: obscureText,
//           onTap: onTab,
//           decoration: InputDecoration(
//             //labelText: labelText,
//             prefixIcon: prefixIcon,
//             filled: readOnly,
//             fillColor: readOnly == true ? const Color(0xffc6c9cb) : null,
//             /* contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 8, vertical: 5),*/
//             hintText: hintText,
//             hintStyle: readOnly
//                 ? const TextStyle(
//                     color: Colors.black54,
//                   )
//                 : MyTextStyle.textHisText,
//             labelStyle: readOnly
//                 ? const TextStyle(
//                     color: Colors.black54,
//                   )
//                 : MyTextStyle.textHisText,
//             focusedBorder: readOnly
//                 ? const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xffc6c9cb),
//                     ),
//                   )
//                 : const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Palette.kToDark,
//                     ),
//                   ),
//             enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Color(0xffc6c9cb),
//               ),
//             ),
//             border: readOnly
//                 ? const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xffc6c9cb),
//                     ),
//                   )
//                 : const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Palette.kToDark,
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }
class MyTextFormFieldNoborder extends StatelessWidget {
  final String? hintText, labelText;
  final Icon? prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTab;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final Function(bool)? onFocusChange;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final Color? color;
  final Color? borderColor;
  final int? maxlies;
  final List<TextInputFormatter>? inputFormatters;
  const MyTextFormFieldNoborder({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.onTab,
    this.textEditingController,
    this.readOnly = false,
    this.labelText,
    this.onChanged,
    this.validator,
    this.onFocusChange,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textAlign,
    this.focusNode,
    this.suffixIcon,
    this.initialValue,
    this.onSaved,
    this.color,
    this.borderColor,
    this.maxlies,
    this.inputFormatters,
    // this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      //autofocus: autofocus,
      onFocusChange: onFocusChange,

      //focusNode: ,
      child: TextFormField(
        //maxLines: maxlies,
        readOnly: readOnly,
        key: key,
        //autofocus: autofocus,
        focusNode: focusNode,
        keyboardType: keyboardType,
        controller: textEditingController,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        onTap: onTab,
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.left,
        validator: validator,
        style: Theme.of(context).textTheme.titleMedium,
        initialValue: initialValue,
        maxLength: maxlies,
        onSaved: onSaved,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          prefixIcon: prefixIcon,
          counterText: '',
          errorStyle: const TextStyle(fontSize: 11, color: Colors.redAccent),
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          filled: color != null,
          fillColor: color,
          // contentPadding:
          //     const EdgeInsets.symmetric(horizontal: 5, vertical: 4),

          hintText: hintText,

          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey),
          //labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: const BorderRadius.all(
          //     Radius.circular(8.0),
          //   ),
          //   borderSide: color != null ? BorderSide.none : const BorderSide(),
          // ),
          // errorBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(8.0),
          //   ),
          //   borderSide: BorderSide(
          //     color: Colors.red,
          //   ),
          // ),
          // focusedErrorBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(8.0),
          //   ),
          //   borderSide: BorderSide(
          //     color: Colors.red,
          //   ),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: const BorderRadius.all(
          //     Radius.circular(8.0),
          //   ),
          //   borderSide: color != null
          //       ? BorderSide.none
          //       : BorderSide(color: borderColor ?? Colors.black),
          // ),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(8.0),
          //     ),
          //     borderSide: color != null ? BorderSide.none : const BorderSide()
          //     // borderSide: BorderSide(
          //     //     color: readOnly ? Colors.grey : const Color(0xFF000000),
          //     //     width: 2),
          //     ),
        ),
      ),
    );
  }
}
