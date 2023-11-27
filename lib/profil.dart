// profile.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ta_aplikasi_berita/halamantambahan.dart';
import 'package:ta_aplikasi_berita/halamanutama.dart';
import 'package:ta_aplikasi_berita/kategori.dart';
import 'package:ta_aplikasi_berita/login.dart';
import 'package:ta_aplikasi_berita/widget/custom_navigation_bar.dart';
import 'user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel? user;
  int currentIndex = 3;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? emailUser = prefs.getString('user');

    final users = Hive.box<UserModel>('userBox').values;

    for (UserModel userModel in users) {
      if (userModel.email == emailUser) {
        setState(() {
          user = userModel;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil', style: GoogleFonts.libreFranklin(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body:
    // Center(
    //     child: user == null
    //         ? CircularProgressIndicator()
    //         :
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto profil
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage:
                      AssetImage("assets/images/profilepic.jpg"),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      '${user?.firstName}',
                      style: TextStyle(fontSize: 30,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Sub bagian PROFIL
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                child: _buildSectionTitle('Profil'),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_2_rounded,
                              color: Colors.grey[600],),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama Lengkap',
                                  style: TextStyle(fontSize: 14),),
                                Text(
                                  '${user?.firstName} ${user?.lastName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                        Row(
                          children: [
                            Icon(Icons.email_rounded,
                            color: Colors.grey[600],),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email',
                                  style: TextStyle(fontSize: 14),),
                                Text(
                                    user!.email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                        Row(
                          children: [
                            Icon(Icons.interests_rounded,
                              color: Colors.grey[600],),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Minat',
                                  style: TextStyle(fontSize: 14),),
                                Text(
                                    user!.interests.join(', '),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Text(
                        //   'Minat',
                        //   style: TextStyle(
                        //       fontSize: 14, fontWeight: FontWeight.bold),
                        // ),
                        // Text(
                        //   user!.interests.join(', '),
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                child: _buildSectionTitle('Hubungi Kami', ),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_2_rounded,
                              color: Colors.grey[600],),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Help Center',
                                  style: TextStyle(fontSize: 14),),
                                Text(
                                    '+514 328',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                        Row(
                          children: [
                            Icon(Icons.email_rounded,
                              color: Colors.grey[600],),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Alamat Kantor',
                                  style: TextStyle(fontSize: 14),),
                                Text(
                                    "Jl. Mawar No. 12, Bekasi, Indonesia",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Sub bagian HUBUNGI KAMI
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final userBox =
                        await Hive.openBox<UserModel>('userBox');
                        await userBox
                            .clear(); // Logout: hapus data pengguna dari Hive
                        Navigator.pop(
                            context); // Kembali ke halaman sebelumnya
                      },
                      child: ElevatedButton(
                        onPressed: () async {
                          final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                          await prefs.remove('user');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.1)
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.libreFranklin(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      // ),
      bottomNavigationBar: CustomNavigationBar(currentIndex: currentIndex, onIndexChanged: handlePageChange),
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

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Divider(
              color: Colors.grey,
              height: 1,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

