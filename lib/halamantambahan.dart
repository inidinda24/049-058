import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ta_aplikasi_berita/halamanutama.dart';
import 'package:ta_aplikasi_berita/kategori.dart';
import 'package:ta_aplikasi_berita/kesansaran.dart';
import 'package:ta_aplikasi_berita/konversi.dart';
import 'package:ta_aplikasi_berita/profil.dart';
import 'package:ta_aplikasi_berita/widget/custom_navigation_bar.dart';
import 'package:ta_aplikasi_berita/zonawaktu.dart';

class HalamanTambahan extends StatefulWidget {
  const HalamanTambahan({Key? key}) : super(key: key);

  @override
  _HalamanTambahanState createState() => _HalamanTambahanState();
}

class _HalamanTambahanState extends State<HalamanTambahan> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Halaman Tambahan', style: GoogleFonts.libreFranklin(fontSize: 25, fontWeight: FontWeight.bold))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: [
              buildCard(
                context,
                'Konversi Mata Uang',
                Icons.attach_money_outlined,
                KonversiMataUang(),
              ),
              buildCard(
                context,
                'Zona Waktu',
                Icons.access_time,
                ZonaWaktu(),
              ),
              buildCard(
                context,
                'Kesan & Saran',
                Icons.feedback_outlined,
                KesanSaran(),
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(currentIndex: 2, onIndexChanged: (index) {
        // Handle perubahan indeks jika diperlukan
        handlePageChange(index);
      },),
    );
  }

  Widget buildCard(BuildContext context, String title, IconData icon, Widget page) {
    return Container(
      height: 300.0,
      child: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.white.withOpacity(0.3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.lightBlueAccent),
                ),
                child: ItemWidget(
                  name: title,
                  icon: icon,
                  page: page,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void handlePageChange(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HalamanUtama()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Kategori()),
        );
        break;
      case 2:
      // Stay on the current page (HalamanTambahan)
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
        break;
    }
  }
}

class ItemWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final Widget page;

  const ItemWidget({
    required this.name,
    required this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80.0,
            color: Colors.blue,
          ),
          SizedBox(height: 16.0),
          Text(
            name,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
