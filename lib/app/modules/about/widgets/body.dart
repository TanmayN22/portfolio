import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/animations/memoji.gif', height: 100),
            Text(
              "Hey There! My Name is",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Tanmay Nayak",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 27, 42, 131),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "I’m a 21‑year‑old, 4th‑year student at Thakur College of Engineering & Technology in Mumbai and a passionate Flutter developer who loves bringing app ideas to life and learning something new every day. When I’m not building , you’ll find me playing chess or going for a run—I enjoy challenging problems, clear design, and turning ideas into polished experiences.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.blueGrey,
                height: 1.4,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Want to Hire or collabrate with me!",
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 139, 139, 139),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.hovered)) {
                    return const Color.fromARGB(255, 189, 220, 246);
                  }
                  return Colors.transparent;
                }),
              ),
              child: Text(
                "Send Message 📨",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 139, 139, 139),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
