import 'package:flutter/material.dart';

class KonversiMataUang extends StatefulWidget {
  @override
  _KonversiMataUangState createState() => _KonversiMataUangState();
}

class _KonversiMataUangState extends State<KonversiMataUang> {
  String selectedCurrency = 'Dollar';
  TextEditingController inputController = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.4),
              ),
              child: Icon(
                Icons.attach_money_outlined,
                color: Colors.white,
                size: 60.0,
              ),
            ),
            SizedBox(height: 25.0),
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedCurrency,
              onChanged: (String? value) {
                setState(() {
                  selectedCurrency = value!;
                });
              },
              items: ['Dollar', 'Yen', 'Euro', 'Won'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                convertCurrency();
              },
              child: Text('Konversi'),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                result,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void convertCurrency() {
    double inputValue = double.tryParse(inputController.text) ?? 0.0;
    double conversionRate;

    // Set nilai konversi berdasarkan mata uang yang dipilih
    switch (selectedCurrency) {
      case 'Dollar':
        conversionRate = 0.000064;
        break;
      case 'Yen':
        conversionRate = 0.0096;
        break;
      case 'Euro':
        conversionRate = 0.000059;
        break;
      case 'Won':
        conversionRate = 0.084;
        break;
      case 'Rupiah':
        conversionRate = 1;
        break;
      default:
        conversionRate = 0.0;
    }

    double resultValue = inputValue * conversionRate;
    setState(() {
      result = 'Hasil konversi: ${resultValue.toStringAsFixed(2)} $selectedCurrency';
    });
  }
}
