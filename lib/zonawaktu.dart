import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZonaWaktu extends StatefulWidget {
  @override
  _ZonaWaktuState createState() => _ZonaWaktuState();
}

class _ZonaWaktuState extends State<ZonaWaktu> {
  String _selectedItemHour = '00';
  String _selectedItemMinute = '00';
  String _selectedTime = 'WITA';
  String _minuteConvert = '00';
  String _WITTime = "01";
  String _WITATime = "00";
  String _WIBTime = "23";
  String _GMTTime = "16";
  List<String> waktuJam = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
  ];
  List<String> waktuMenit = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59'
  ];
  late String selectedTimeZone;
  late DateTime currentTime;

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zona Waktu', style: GoogleFonts.libreFranklin(
          textStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold
          ),
        ), ),
      ),
      body:
      SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.075),
            child: Center(
              child: Column(
                children: [
                  Container(
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              icon: Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              itemHeight: 100,
                              menuMaxHeight: 100,
                              focusColor: Colors.black,
                              value: _selectedItemHour,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedItemHour = newValue!;
                                });
                              },
                              items: waktuJam.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                            ),
                            Text(
                              ".",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                              icon: Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              itemHeight: 100,
                              menuMaxHeight: 100,
                              focusColor: Colors.black,
                              value: _selectedItemMinute,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedItemMinute = newValue!;
                                });
                              },
                              items: waktuMenit.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                            ),
                            Text(
                              " ",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                              icon: Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              itemHeight: 100,
                              menuMaxHeight: 100,
                              focusColor: Colors.black,
                              value: _selectedTime,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedTime = newValue!;
                                });
                              },
                              items: <String>[
                                'WIT',
                                'WITA',
                                'WIB',
                                "GMT",
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          convertTime();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.lightBlueAccent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.change_circle_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Convert",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WIT",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${_WITTime}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "." ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "${_minuteConvert}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WITA",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,  fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${_WITATime}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "." ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "${_minuteConvert}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WIB",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${_WIBTime}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "." ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "${_minuteConvert}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "GMT",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,  fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${_GMTTime}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "." ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "${_minuteConvert}" ?? "NULL",
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void convertTime() {
    int selectedHour = int.parse(_selectedItemHour);
    _minuteConvert = _selectedItemMinute;
    String selectedTime = _selectedTime;

    if (selectedTime == 'WIT') {
      _WITTime = _selectedItemHour;

      int WITATime = (selectedHour + 23) % 24;
      _WITATime = (WITATime < 10) ? '0$WITATime' : WITATime.toString();

      int WIBTime = (selectedHour + 22) % 24;
      _WIBTime = (WIBTime < 10) ? '0$WIBTime' : WIBTime.toString();

      int GMTTime = (selectedHour + 15) % 24;
      _GMTTime = (GMTTime < 10) ? '0$GMTTime' : GMTTime.toString();
    }
    else if (selectedTime == 'WITA') {
      _WITATime = _selectedItemHour;

      int WITTime = (selectedHour + 1) % 24;
      _WITTime = (WITTime < 10) ? '0$WITTime' : WITTime.toString();

      int WIBTime = (selectedHour + 23) % 24;
      _WIBTime = (WIBTime < 10) ? '0$WIBTime' : WIBTime.toString();

      int GMTTime = (selectedHour + 16) % 24;
      _GMTTime = (GMTTime < 10) ? '0$GMTTime' : GMTTime.toString();
    } else if (selectedTime == 'WIB') {
      _WIBTime = _selectedItemHour;

      int WITATime = (selectedHour + 1) % 24;
      _WITATime = (WITATime < 10) ? '0$WITATime' : WITATime.toString();

      int WITTime = (selectedHour + 2) % 24;
      _WITTime = (WITTime < 10) ? '0$WITTime' : WITTime.toString();

      int GMTTime = (selectedHour + 17) % 24;
      _GMTTime = (GMTTime < 10) ? '0$GMTTime' : GMTTime.toString();
    } else if (selectedTime == 'GMT') {
      _GMTTime = _selectedItemHour;

      int WITATime = (selectedHour + 8) % 24;
      _WITATime = (WITATime < 10) ? '0$WITATime' : WITATime.toString();

      int WIBTime = (selectedHour + 7) % 24;
      _WIBTime = (WIBTime < 10) ? '0$WIBTime' : WIBTime.toString();

      int WITTime = (selectedHour + 9) % 24;
      _WITTime = (WITTime < 10) ? '0$WITTime' : WITTime.toString();
    }

    setState(() {
      _WITTime = _WITTime;
      _WITATime = _WITATime;
      _WIBTime = _WIBTime;
      _GMTTime = _GMTTime;
      _minuteConvert = _selectedItemMinute;
    }
    );
  }
}
