import 'package:crypt/crypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ta_aplikasi_berita/user_model.dart';
import 'package:ta_aplikasi_berita/login.dart';
import 'package:ta_aplikasi_berita/user_model.dart';

class Registrasi extends StatefulWidget {
  const Registrasi({Key? key}) : super(key: key);

  @override
  State<Registrasi> createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  bool _showPassword = false;
  List<String> selectedMinat = [];
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
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
          child: SingleChildScrollView(
            child: Card(
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
                    // Nama Depan
                    TextFormField(
                      controller: _firstNameController,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.lightBlueAccent,
                      decoration: InputDecoration(
                        labelText: 'Nama Depan',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Nama Belakang
                    TextFormField(
                      controller: _lastNameController,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.lightBlueAccent,
                      decoration: InputDecoration(
                        labelText: 'Nama Belakang',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Minat
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Minat',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildMinatCheckbox('Nasional'),
                        _buildMinatCheckbox('Internasional'),
                        _buildMinatCheckbox('Ekonomi'),
                        _buildMinatCheckbox('Olahraga'),
                        _buildMinatCheckbox('Teknologi'),
                        _buildMinatCheckbox('Hiburan'),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.lightBlueAccent,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlueAccent),
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
                          borderSide: BorderSide(color: Colors.lightBlueAccent),
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

                    // Tombol Registrasi
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          String pass = Crypt.sha256(_passwordController.text).toString();
                          // Logika Registrasi
                          UserModel user = UserModel()
                            ..firstName = _firstNameController.text
                            ..lastName = _lastNameController.text
                            ..interests = List.from(selectedMinat)
                            ..email = _emailController.text
                            ..password = Crypt.sha256(_passwordController.text).toString();

                          // Simpan data user menggunakan Hive
                          await _saveUserData(user);

                          // Kembalikan ke halaman login dengan objek UserModel
                          if (!_isError) Navigator.pop(context, user);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Registrasi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    // Menampilkan pesan error
                    Text(
                      _isError
                          ? 'Email telah terdaftar sebelumnya, coba lagi.'
                          : '',
                      style: TextStyle(
                        color: _isError ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMinatCheckbox(String minat) {
    return CheckboxListTile(
      title: Text(
        minat,
        style: TextStyle(color: Colors.black),
      ),
      value: selectedMinat.contains(minat),
      onChanged: (value) {
        setState(() {
          if (value!) {
            selectedMinat.add(minat);
          } else {
            selectedMinat.remove(minat);
          }
        });
      },
      activeColor: Colors.grey,
      checkColor: Colors.black,
    );
  }

  Future<void> _saveUserData(UserModel user) async {
    final userBox = Hive.box<UserModel>('userBox');

    bool isEmailDuplicate = false;
    for (UserModel userModel in userBox.values) {
      if (user.email == userModel.email) {
        setState(() {
          _isError = true;
        });
        isEmailDuplicate = true;
      }
    }

    if (!isEmailDuplicate) await userBox.add(user);
  }
}
