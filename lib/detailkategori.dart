import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ta_aplikasi_berita/halamantambahan.dart';
import 'package:ta_aplikasi_berita/halamanutama.dart';
import 'package:ta_aplikasi_berita/kategori.dart';
import 'package:ta_aplikasi_berita/profil.dart';
import 'package:ta_aplikasi_berita/widget/custom_navigation_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:google_fonts/google_fonts.dart';

class DetailKategori extends StatefulWidget {
  final String url;

  DetailKategori(this.url, {Key? key}) : super(key: key);

  @override
  State<DetailKategori> createState() => _DetailKategoriState();
}

class _DetailKategoriState extends State<DetailKategori> {
  int currentIndex = 1;
  late Future<dynamic> data;

  @override
  void initState() {
    super.initState();
    data = fetchData(widget.url);
    timeago.setLocaleMessages('id', timeago.IdMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Kategori", style: GoogleFonts.libreFranklin(fontSize: 25),),
      ),
      body: FutureBuilder<dynamic>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Implementasi detail kategori menggunakan data dari snapshot
            // Sesuaikan dengan struktur sebenarnya dari respons JSON
            log(snapshot.data.toString());

            // Contoh tampilan daftar berita dalam bentuk list dan dibungkus oleh card
            List<dynamic> beritaList = snapshot.data['data']['posts'];
            return ListView.builder(
              itemCount: beritaList.length,
              itemBuilder: (BuildContext context, int index) {
                var parsedDate = DateTime.parse(beritaList[index]['pubDate']);
                var formattedDate = timeago.format(parsedDate, locale:'id');
                return Card(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)
                          ),
                          child: Container(
                            height: 170,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(beritaList[index]['thumbnail']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  formattedDate,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Implementasi logika favorit di sini
                                },
                                child: Icon(Icons.bookmark_outline_rounded),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                              beritaList[index]['title'] ?? 'Tidak ada judul'),
                          subtitle: Text(beritaList[index]['description'] ??
                              'Tidak ada deskripsi'),
                          // Tambahkan widget lain sesuai kebutuhan
                        ),
                      ],
                    )
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
  }

