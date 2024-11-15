import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service/app_unity.dart';

class DialogError extends StatefulWidget {
  final TypeDialog type;
  final String msg;
  const DialogError({super.key, required this.type, required this.msg});

  @override
  State<DialogError> createState() => _DialogErrorState();
}

class _DialogErrorState extends State<DialogError> {
  Timer? t;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 120,
        //height: MediaQuery.of(context).size.width - 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildIcon(),
            /* Text(
              msg,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),*/
            buildText(),
            SelectableText(
              widget.msg,
              style: GoogleFonts.kanit(
                //fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.type == TypeDialog.questions)
              Container(
                width: 120,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            // Container(
            //   // width: 70,
            //   height: 35,
            //   margin: const EdgeInsets.symmetric(horizontal: 5),
            //   child: ElevatedButton(
            //     /*style: ElevatedButton.styleFrom(
            //     primary: Colors.redAccent,
            //   ),*/
            //     child: const Text('OK'),
            //     onPressed: () => Navigator.pop(context, true),
            //   ),
            // ),
            SizedBox(
              width: 120,
              height: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: widget.type == TypeDialog.success
                      ? Theme.of(context).primaryColor
                      : Colors.redAccent,
                ),
                child: Text(
                    widget.type == TypeDialog.success ? "Continue" : 'Close'),
                onPressed: () => Navigator.pop(context, false),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildIcon() {
    switch (widget.type) {
      case TypeDialog.error:
        return Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.redAccent),
          child: const Icon(
            Icons.close,
            size: 80,
            color: Colors.white,
          ),
        );

      case TypeDialog.warning:
        return Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.deepOrangeAccent),
          child: const Icon(
            Icons.warning_rounded,
            size: 70,
            color: Colors.white,
          ),
        );

      case TypeDialog.questions:
        return Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.indigoAccent),
          child: const Icon(
            Icons.question_mark,
            size: 80,
            color: Colors.white,
          ),
        );

      default:
        return Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xff398E3D),
          ),
          child: const Icon(
            Icons.check,
            size: 80,
            color: Colors.white,
          ),
        );
    }
  }

  Widget buildText() {
    switch (widget.type) {
      case TypeDialog.error:
        return SelectableText(
          "Error",
          style: GoogleFonts.kanit(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.redAccent),
          textAlign: TextAlign.center,
        );

      case TypeDialog.warning:
        return SelectableText(
          "Warning",
          style: GoogleFonts.kanit(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.deepOrangeAccent),
          textAlign: TextAlign.center,
        );

      case TypeDialog.questions:
        return SelectableText(
          "Questions",
          style: GoogleFonts.kanit(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.indigoAccent),
          textAlign: TextAlign.center,
        );

      default:
        return SelectableText(
          "Success",
          style: GoogleFonts.kanit(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: const Color(0xff398E3D),
          ),
          textAlign: TextAlign.center,
        );
    }
  }
}
