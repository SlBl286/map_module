import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  const TextFieldWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: GoogleFonts.mulish(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 14,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          cursorColor: Color.fromRGBO(0, 0, 0, 1),
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(12),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.25,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.25,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              hintStyle: GoogleFonts.mulish(
                  color: Color.fromARGB(255, 117, 117, 117),
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1)),
          style: GoogleFonts.mulish(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ]),
    );
  }
}
