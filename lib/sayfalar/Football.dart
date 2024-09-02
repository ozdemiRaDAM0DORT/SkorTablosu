import 'dart:async';
//import 'dart:js';

// import 'package:cosmos/cosmos.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:digital_lcd_number/digital_lcd_number.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:score_board_2/sayfalar/Home.dart';
//import 'package:score_board_2/main.dart';
//import 'package:score_board_2/sayfalar/Home.dart';

void main() {
  runApp(FootballScore());
}

class FootballScore extends StatefulWidget {
  @override
  State<FootballScore> createState() => _FootballScoreState();
}

int sayac1 = 0;
int sayac2 = 0;
TextEditingController takim1 = TextEditingController();
TextEditingController takim2 = TextEditingController();
String takim_1 = "Takım - 1";
String takim_2 = "Takım - 2 ";

class _FootballScoreState extends State<FootballScore> {
  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde yatay (landscape) moda kilitle
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Yönlendirme tercihlerini varsayılana döndür
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  int second = 0;
  int minute = 0;
  int uzatma = 0;
  int uzatma1 = 44;
  int uzatma2 = 89;
  String _Second = "00";
  String _Minutes = "00";
  String txt2 = "";
  Timer? timer;
  bool started = false;
  Icon icon = Icon(
    Icons.play_arrow,
    color: Colors.white,
  );
  Text txt = Text("");
  void stop() {
    started = false;
    icon = Icon(
      Icons.play_arrow,
      color: Colors.white,
    );
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    icon = Icon(
      Icons.play_arrow,
      color: Colors.white,
    );
    started = false;
    timer!.cancel();
    setState(() {
      sayac1 = 0;
      sayac2 = 0;
      second = 0;
      minute = 0;
      _Minutes = "00";
      _Second = "00";
      started = false;
    });
  }

  void start() {
    started = true;
    icon = Icon(
      Icons.stop,
      color: Colors.white,
    );
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsecond = second + 1;
      int localminute = minute;
      if (localminute < uzatma1 + 1) {
        if (localsecond > 59) {
          if (localminute == uzatma1) {
            localsecond = 0;
            localminute++;
            timer.cancel();
            icon = Icon(
              Icons.play_arrow,
              color: Colors.white,
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("İlk yarı bitti!"),
                  actions: <Widget>[],
                );
              },
            );
          } else {
            localminute++;
            localsecond = 0;
          }
        }
      } else {
        if (localsecond > 59) {
          if (localminute == uzatma2) {
            localsecond = 0;
            localminute++;
            timer.cancel();
            icon = Icon(
              Icons.play_arrow,
              color: Colors.white,
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("İkinci yarı bitti"),
                  content: txt,
                  actions: <Widget>[],
                );
              },
            );
          } else {
            localminute++;
            localsecond = 0;
          }
        }
      }
      setState(() {
        if (sayac1 > sayac2) {
          txt = Text(
            takim_1 + " Kazandı",
            style: TextStyle(fontSize: 30),
          );
        } else if (sayac2 > sayac1) {
          txt = Text(
            takim_2 + " Kazandı",
            style: TextStyle(fontSize: 30),
          );
        } else {
          txt = Text(
              "Berabere - " + sayac1.toString() + " : " + sayac2.toString());
        }
        if (_Minutes == "00" && _Second == "00") {
          txt2 = "";
        }
        second = localsecond;
        minute = localminute;
        _Second = (second >= 10) ? "$second" : "0$second";
        _Minutes = (minute >= 10) ? "$minute" : "0$minute";
        started = true;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text("Futbol Skor Tahtası"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: <Widget>[
          Container(
            width: 60,
            height: 30,
            color: Colors.black,
            child: Center(
              child: Text(
                _Minutes + ":" + _Second,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.black,
            child: Center(
              child: Text(
                txt2,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          DropdownMenu(
            textStyle: TextStyle(color: Colors.white54),
            width: 140,
            label: const Text(
              'Uzatma',
              style: TextStyle(color: Colors.white54),
            ),
            dropdownMenuEntries: <DropdownMenuEntry<int>>[
              DropdownMenuEntry(value: 0, label: "0"),
              DropdownMenuEntry(value: 1, label: "+1"),
              DropdownMenuEntry(value: 2, label: "+2"),
              DropdownMenuEntry(value: 3, label: "+3"),
              DropdownMenuEntry(value: 4, label: "+4"),
              DropdownMenuEntry(value: 5, label: "+5"),
            ],
            onSelected: (int? uzatma3) {
              setState(() {
                if (minute < 46) {
                  uzatma1 += uzatma3!;
                } else {
                  uzatma2 += uzatma3!;
                }
                uzatma = uzatma3;
                if (started) {
                  if (uzatma != 0) {
                    txt2 = "+" + uzatma.toString();
                  } else {
                    txt2 = "";
                  }
                } else {
                  txt2 = "";
                }
              });
            },
          ),
          SizedBox(
            width: 126,
          ),
          InkWell(
            onTap: () {
              if (takim_1 == "" && takim_2 == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Eksik!"),
                        content: Text(
                          "Lütfen bir takım ismi giriniz.",
                        ),
                      );
                    });
              } else {
                if (started) {
                  started = false;
                } else {
                  started = true;
                }
                setState(() {
                  if (started) {
                    start();
                  } else {
                    stop();
                  }
                });
              }
            },
            child: Container(
              width: 50,
              height: 50,
              color: Color.fromARGB(255, 0, 0, 0),
              child: icon,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: reset,
            child: Container(
              width: 50,
              height: 50,
              color: Color.fromARGB(255, 0, 0, 0),
              child: Icon(
                Icons.restore,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: AlertDialog(
                        title: Text("Takım isimleri:"),
                        actions: <Widget>[
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      controller: takim1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      controller: takim2,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    takim_1 = takim1.text;
                                    takim_2 = takim2.text;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text("Düzenle"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 221, 155),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    "Takım ismi düzenle",
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Geri"),
            )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 100,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 15,
                            right: 15,
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (sayac1 != 99 && started) {
                                        sayac1++;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "+",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (sayac1 != 0) {
                                        sayac1--;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              Text(
                                takim_1,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 10,
                                  bottom: 15,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 145, 153, 153),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DigitalLcdNumber(
                                        number: (sayac1 / 10).toInt(),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 145, 153, 153),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DigitalLcdNumber(
                                        number: (sayac1 % 10).toInt(),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 200,
                              child: VerticalDivider(
                                indent: 5,
                                thickness: 5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              takim_2,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 10,
                                bottom: 15,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 145, 153, 153),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DigitalLcdNumber(
                                      number: (sayac2 / 10).toInt(),
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 145, 153, 153),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DigitalLcdNumber(
                                      number: (sayac2 % 10).toInt(),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 15,
                            right: 15,
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (sayac2 != 99 && started) {
                                        sayac2++;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "+",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (sayac2 != 0) {
                                        sayac2--;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 0, 0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Uyarı!",
                                        ),
                                        content: Text(
                                          "Sıfırlamak istediğine emin misin?",
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                sayac2 = 0;
                                                sayac1 = 0;
                                                takim_1 = "";
                                                takim_2 = "";
                                                txt2 = "";
                                                takim1 =
                                                    TextEditingController();
                                                takim2 =
                                                    TextEditingController();
                                              });
                                              Navigator.pop(
                                                context,
                                              );
                                              reset();
                                            },
                                            child: Text("evet"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("hayır"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  "Sıfırla",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 0, 0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Geri dönmek istediğinize emin misiniz?"),
                                        content: Text(
                                          "Tüm veriler silinecek!",
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  sayac2 = 0;
                                                  sayac1 = 0;
                                                  takim_1 = "";
                                                  takim_2 = "";
                                                  takim1 =
                                                      TextEditingController();
                                                  takim2 =
                                                      TextEditingController();
                                                },
                                              );
                                              //reset();
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage()),
                                              );
                                            },
                                            child: Text("evet"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("hayır"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  "geri dön",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
