import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  AuthTitle(key,this.title):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.libreBaskerville(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            
          ),
        ),
        Text(
          'your Account',
          style: GoogleFonts.libreBaskerville(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
