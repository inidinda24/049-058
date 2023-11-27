import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ZonaWaktu extends StatefulWidget {
  @override
  _ZonaWaktuState createState() => _ZonaWaktuState();
}

class _ZonaWaktuState extends State<ZonaWaktu> {
  late String selectedTimeZone;
  late DateTime currentTime;

  @override
  void initState() {
    super.initState();
    selectedTimeZone = 'Asia/Jakarta';
    currentTime = DateTime.now().toLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zona Waktu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildCurrentTimeCard('WIB'),
            buildTimeZoneSelector(),
            buildSelectedTimeCard(),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentTimeCard(String zoneName) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              zoneName,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              DateFormat('HH:mm:ss').format(currentTime),
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeZoneSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildTimeZoneButton('WIT'),
        buildTimeZoneButton('WITA'),
        buildTimeZoneButton('GMT'),
      ],
    );
  }

  Widget buildTimeZoneButton(String zoneName) {
    return ElevatedButton(
      onPressed: () {
        handleTimeZoneChange(zoneName);
      },
      child: Text('Pilih $zoneName'),
    );
  }

  Widget buildSelectedTimeCard() {
    DateTime convertedTime = currentTime.toLocal();

    if (selectedTimeZone != 'WIB') {
      int offset = 0;

      if (selectedTimeZone == 'WITA') {
        offset = 1;
      } else if (selectedTimeZone == 'WIT') {
        offset = 2;
      } else if (selectedTimeZone == 'GMT') {
        offset = -7; // GMT has no offset
      }

      convertedTime = currentTime.add(Duration(hours: offset));
    }

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Waktu di $selectedTimeZone',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              DateFormat('HH:mm:ss').format(convertedTime),
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  void handleTimeZoneChange(String timeZone) {
    setState(() {
      selectedTimeZone = timeZone;
    });
  }
}
