import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KesanSaran extends StatefulWidget {
  const KesanSaran({Key? key}) : super(key: key);

  @override
  State<KesanSaran> createState() => _KesanSaranState();
}

class _KesanSaranState extends State<KesanSaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kesan dan Saran', style: GoogleFonts.libreFranklin(
          textStyle: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold
          ),
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Kesan:',
                    style: GoogleFonts.libreFranklin(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Selama mengikuti mata kuliah Pemrograman Aplikasi Mobile, saya merasa sangat terbantu dan mendapatkan banyak pemahaman baru terkait pengembangan aplikasi mobile. Dosen memberikan penjelasan dengan baik dan materi perkuliahan sangat relevan dengan perkembangan teknologi saat ini. Saya senang dengan pendekatan praktis yang diterapkan dalam setiap sesi, yang memberikan pengalaman langsung dalam mengembangkan aplikasi mobile.',
                    style: GoogleFonts.libreFranklin(
                      textStyle: TextStyle(
                        fontSize: 18.0,

                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Saran:',
                    style: GoogleFonts.libreFranklin(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Saya berharap dapat lebih mendalami beberapa topik spesifik dalam mata kuliah ini.',
                    style: GoogleFonts.libreFranklin(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
