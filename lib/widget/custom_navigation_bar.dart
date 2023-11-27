import 'package:flutter/material.dart';
import 'package:ta_aplikasi_berita/halamanutama.dart';
import 'package:ta_aplikasi_berita/kategori.dart';
import 'package:ta_aplikasi_berita/profil.dart';
import 'package:ta_aplikasi_berita/kesansaran.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onIndexChanged;

  CustomNavigationBar({Key? key, required this.currentIndex, this.onIndexChanged})
      : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      fixedColor: Colors.lightBlueAccent,
      unselectedItemColor: Colors.grey,
      currentIndex: widget.currentIndex,
      onTap: (int index) {
        // Panggil callback jika ada
        if (widget.onIndexChanged != null) {
          widget.onIndexChanged!(index);
        }
      },
      items: [
        _buildBottomNavigationBarItem(Icons.home_rounded, "Home", 0),
        _buildBottomNavigationBarItem(Icons.category_rounded, "Category", 1),
        _buildBottomNavigationBarItem(Icons.add_circle, "Tambahan", 2),
        _buildBottomNavigationBarItem(Icons.person_3_rounded, "Profile", 3),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    // Tentukan warna ikon berdasarkan nilai currentIndex
    Color iconColor =
    widget.currentIndex == index ? Colors.blue : Colors.grey;

    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: label,
    );
  }
}
