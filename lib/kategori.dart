import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ta_aplikasi_berita/detailkategori.dart';
import 'package:ta_aplikasi_berita/halamantambahan.dart';
import 'package:ta_aplikasi_berita/halamanutama.dart';
import 'package:ta_aplikasi_berita/profil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_aplikasi_berita/widget/custom_navigation_bar.dart';

class Kategori extends StatefulWidget {
  const Kategori({Key? key});


  @override
  State<Kategori> createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  int currentIndex = 1;
  late Future<dynamic> data;
  final List<String> kategoriUrls = [
    'https://api-berita-indonesia.vercel.app/cnn/nasional/',
    'https://api-berita-indonesia.vercel.app/cnn/internasional/',
    'https://api-berita-indonesia.vercel.app/cnn/ekonomi/',
    'https://api-berita-indonesia.vercel.app/cnn/olahraga/',
    'https://api-berita-indonesia.vercel.app/cnn/teknologi/',
    'https://api-berita-indonesia.vercel.app/cnn/hiburan/',
  ];

  late String gambar;

  String extractJudulKategori(String url) {
    List<String> urlSegments = url.split('/');
    String judul = urlSegments[urlSegments.length - 2];
    return judul.substring(0, 1).toUpperCase() + judul.substring(1);
  }

  @override
  void initState() {
    super.initState();
    data = fetchData(kategoriUrls[0]);
    gambar = "assets/images/nasional.jpg";
  }

  Future<dynamic> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      dynamic decodedData = json.decode(response.body);
      return decodedData;
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  void navigateToDetailPage(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailKategori(url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Kategori", style: GoogleFonts.libreFranklin(fontSize: 25, fontWeight: FontWeight.bold),)),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<dynamic>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            log(snapshot.data['data'].toString());
            List<dynamic> dataList = snapshot.data['data']['posts'];

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 210,
              ),
              itemCount: dataList.length > 6 ? 6 : dataList.length,
              itemBuilder: (BuildContext context, int index) {
                switch (extractJudulKategori(kategoriUrls[index])) {
                  case 'Nasional':
                    gambar = "assets/images/nasional.jpg";
                    break;
                  case 'Internasional':
                    gambar = "assets/images/internasional.jpg";
                    break;
                  case 'Ekonomi':
                    gambar = "assets/images/ekonomi.jpg";
                    break;
                  case 'Olahraga':
                    gambar = "assets/images/olahraga.jpg";
                    break;
                  case 'Teknologi':
                    gambar = "assets/images/teknologi.jpg";
                    break;
                  case 'Hiburan':
                    gambar = "assets/images/hiburan.jpg";
                    break;
                  default:
                    gambar = "assets/images/default.jpg";
                }

                String title = extractJudulKategori(kategoriUrls[index]);
                return GestureDetector(
                  onTap: () {
                    navigateToDetailPage(kategoriUrls[index]);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(gambar),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.dstATop,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          title,
                          style: GoogleFonts.libreFranklin(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomNavigationBar(currentIndex: currentIndex, onIndexChanged: (index) {
        // Handle perubahan indeks jika diperlukan
        handlePageChange(index);
      },),
    );
  }

  void handlePageChange(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
      // Pindah ke HalamanUtama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HalamanUtama()),
        );
        break;
      case 1:
      // Pindah ke Kategori
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Kategori()),
        );
        break;
      case 2:
      // Pindah ke HalamanTambahan
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HalamanTambahan()),
        );
        break;
      case 3:
      // Pindah ke Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
        break;
    }
  }
}

