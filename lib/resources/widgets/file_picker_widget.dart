import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
             
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(66, 152, 69, 1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          getImageAsset('Image3.png'),
                          width: 80,
                        ),
                      ),
                      Text(
                        'Tải file',
                        style: GoogleFonts.mulish(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Nhấn để tải lên',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 12,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )
                    ],
                  ));
  }
}
