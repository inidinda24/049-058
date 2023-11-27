import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ta_aplikasi_berita/halamantambahan.dart';
import 'package:ta_aplikasi_berita/kategori.dart';
import 'package:ta_aplikasi_berita/profil.dart';
import 'package:ta_aplikasi_berita/widget/custom_navigation_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  late Future<dynamic> data;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    data = fetchData();
    timeago.setLocaleMessages('id', timeago.IdMessages());
  }

  Future<dynamic> fetchData() async {
    final response = await http
        .get(Uri.parse('https://api-berita-indonesia.vercel.app/cnn/terbaru/'));

    if (response.statusCode == 200) {
      dynamic decodedData = json.decode(response.body);
      return decodedData;
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("News App", style: GoogleFonts.libreFranklin(fontSize: 25, fontWeight: FontWeight.bold),)),
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

            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                var parsedDate = DateTime.parse(dataList[index]['pubDate']);
                var formattedDate = timeago.format(parsedDate, locale: 'id');

                return GestureDetector(
                  onTap: () {
                    _launcher(dataList[index]['link']);
                  },
                  child: Card(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(dataList[index]['thumbnail']),
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
                              dataList[index]['title'] ?? 'Tidak ada judul'),
                          subtitle: Text(dataList[index]['description'] ??
                              'Tidak ada deskripsi'),
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

  Future<void> _launcher(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception("Gagal membuka url : $_url");
    }
  }

