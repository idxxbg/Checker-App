import 'package:checker_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hinttext,
    required this.icon,
    required this.textController,
    required this.screenW,
    required this.inputType,
  });

  final double screenW;
  final TextInputType inputType;
  final TextEditingController textController;
  final String hinttext;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: screenW * 0.9,
        constraints: const BoxConstraints(
          maxHeight: 150,
          minHeight: 50,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: paddingSmall,
          child: TextFormField(
            keyboardType: inputType,
            controller: textController,
            minLines: 1,
            maxLines: 3,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade700,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 10),
              prefixIcon: Icon(
                icon,
                color: Colors.green.shade400,
                size: 35,
              ),
              hintText: hinttext,
              hintStyle:
                  GoogleFonts.roboto(fontSize: 18, color: Colors.black26),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}