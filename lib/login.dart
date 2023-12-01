import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ta_aplikasi_berita/halamanutama.dart';
import 'package:ta_aplikasi_berita/registrasi.dart';
import 'package:ta_aplikasi_berita/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    checkAndNavigate();
  }

  Future<void> checkAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Mengambil data user yang login
    String? user = prefs.getString('user');

    if (user != null) {
      // Jika ada user yang login, navigate ke halaman utama
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HalamanUtama()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/news.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: appBarHeight + 16),
          child: Column(
            children: [
              Expanded(
                child:
                Container(), // Spasi kosong untuk melarikan konten ke bawah
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                color: Colors.white.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Username
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.lightBlueAccent,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.lightBlueAccent,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 32),

                      // Tombol Login
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _validateLogin(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      // Text "Belum punya akun?"
                      Text(
                        _isError
                            ? 'Email atau password tidak valid, coba lagi.'
                            : 'Belum punya akun?',
                        style: TextStyle(
                          color: _isError ? Colors.red : Colors.black,
                        ),
                      ),

                      SizedBox(height: 8),

                      // Tombol Registrasi kecil
                      TextButton(
                        onPressed: () async {
                          // Navigasi ke halaman registrasi
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registrasi()),
                          );

                          // Cek hasil registrasi dan update formulir login jika diperlukan
                          if (result != null && result is UserModel) {
                            setState(() {
                              _emailController.text = result.email;
                              _passwordController.text = result.password;
                              _isError = false;
                            });
                          }
                        },
                        child: Text(
                          'Registrasi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateLogin(BuildContext context) async {
    // Memeriksa email dan password
    if (_isUserDataValid(
      email: _emailController.text,
      password: _passwordController.text,
    )) {
      // Menyimpan email user yang login
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', _emailController.text);

      // Logika jika login berhasil
      _isError = false;
      // Navigasi ke halaman utama
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HalamanUtama()),
      );
    } else {
      // Menampilkan pesan kesalahan jika login gagal
      setState(() {
        _isError = true;
      });
    }
  }

  bool _isUserDataValid({String? email, String? password}) {
    final users = Hive.box<UserModel>('userBox').values.cast();

    bool isValid(String cryptFormatHash, String enteredPassword) =>
        Crypt(cryptFormatHash).match(enteredPassword);

    for (UserModel user in users) {
      if (user.email == email && isValid(user.password, password!) == true ) {
        return true;
      }
    }

    return false;
  }
}

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}
