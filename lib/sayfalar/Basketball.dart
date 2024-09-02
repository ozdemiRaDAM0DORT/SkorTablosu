import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_lcd_number/digital_lcd_number.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:score_board_2/sayfalar/Home.dart';

void main() => runApp(const BasketballScore());

class BasketballScore extends StatefulWidget {
  const BasketballScore({super.key});

  @override
  State<BasketballScore> createState() => _BasketballScoreState();
}

int sayac1 = 0;
int sayac2 = 0;
TextEditingController takim1 = TextEditingController(text: "Takım-1");
TextEditingController takim2 = TextEditingController(text: "Takım-2");
String takim_1 = "Takım - 1";
String takim_2 = "Takım - 2";
int set1 = 0;
int set2 = 0;

class _BasketballScoreState extends State<BasketballScore> {
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

  int second = 60;
  int minute = 9;
  String _Second = "00";
  String _Minutes = "10";
  String txt2 = "";
  Timer? timer;
  bool started = false;
  Icon icon = Icon(
    Icons.play_arrow,
    color: const Color.fromARGB(255, 255, 17, 0),
  );
  Text txt = Text("");
  void stop() {
    started = false;
    icon = Icon(
      Icons.play_arrow,
      color: const Color.fromARGB(255, 255, 17, 0),
    );
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    icon = Icon(
      Icons.play_arrow,
      color: const Color.fromARGB(255, 255, 17, 0),
    );
    started = false;
    timer!.cancel();
    setState(() {
      sayac1 = 0;
      sayac2 = 0;
      second = 60;
      minute = 9;
      _Minutes = "10";
      _Second = "00";
      started = false;
    });
  }

  void start() {
    started = true;
    icon = Icon(
      Icons.stop,
      color: const Color.fromARGB(255, 255, 17, 0),
    );
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsecond = second - 1;
      int localminute = minute;
      setState(() {
        if (localsecond == 0) {
          if (localminute == 0) {
            started = false;
            timer.cancel();
            icon = Icon(
              Icons.play_arrow,
              color: const Color.fromARGB(255, 255, 17, 0),
            );
            txt = Text(sayac1.toString() + ":" + sayac2.toString());
            if (sayac1 > sayac2) {
              set1++;
              if (set1 == 3) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Kazanan : " + takim_1),
                      content: txt,
                      actions: <Widget>[],
                    );
                  },
                );
              } else {
                sayac1 = 0;
                sayac2 = 0;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Set bitti"),
                      content: txt,
                      actions: <Widget>[],
                    );
                  },
                );
              }
            } else if (sayac2 > sayac1) {
              set2++;
              if (set2 == 3) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Kazanan : " + takim_2),
                      content: txt,
                      actions: <Widget>[],
                    );
                  },
                );
                sayac1 = 0;
                sayac2 = 0;
                set1 = 0;
                set2 = 0;
              } else {
                sayac1 = 0;
                sayac2 = 0;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Set bitti"),
                      content: txt,
                      actions: <Widget>[],
                    );
                  },
                );
              }
            } else {
              localsecond = 59;
              localminute = 4;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Uzatmalar"),
                    actions: <Widget>[],
                  );
                },
              );
            }
            txt3 = set1.toString() + "-" + set2.toString();
          } else {
            localminute--;
            localsecond = 59;
          }
        }

        second = localsecond;
        minute = localminute;
        _Second = (second >= 10) ? "$second" : "0$second";
        _Minutes = (minute >= 10) ? "$minute" : "0$minute";
      });
    });

    if (second == 0 && minute == 0) {
      second = 60;
      minute = 9;
    }
  }

  String txt3 = set1.toString() + "-" + set2.toString();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Text("Basketbol Skor Tahtası"),
        backgroundColor: Colors.black,
        foregroundColor: const Color.fromARGB(255, 255, 17, 0),
        actions: <Widget>[
          Text(
            "Periyot : ",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            txt3,
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 60,
            height: 30,
            color: Colors.black,
            child: Center(
              child: Text(
                _Minutes + ":" + _Second,
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 255, 17, 0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 211,
          ),
          InkWell(
            onTap: () {
              takim_1 = takim1.text;
              takim_2 = takim2.text;
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
                color: const Color.fromARGB(255, 255, 17, 0),
              ),
            ),
          ),
        ],
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
                            left: 5,
                            right: 5,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (takim_1 == "") {
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
                                          sayac1 += 3;
                                        }
                                      }
                                      txt3 = set1.toString() +
                                          "-" +
                                          set2.toString();
                                    });
                                  },
                                  child: const Text(
                                    "+3",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (takim_1 == "") {
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
                                          sayac1 += 2;
                                        }
                                      }
                                      txt3 = set1.toString() +
                                          "-" +
                                          set2.toString();
                                    });
                                  },
                                  child: const Text(
                                    "+2",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (takim_1 == "") {
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
                                          sayac1++;
                                        }
                                      }
                                      txt3 = set1.toString() +
                                          "-" +
                                          set2.toString();
                                    });
                                  },
                                  child: const Text(
                                    "+1",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
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
                                      color: Colors.yellow,
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
                              Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  controller: takim1,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DigitalLcdNumber(
                                        number: (sayac1 / 100).toInt(),
                                        color: Color.fromARGB(255, 255, 0, 0),
                                      ),
                                    ),
                                    Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DigitalLcdNumber(
                                        number: ((sayac1 -
                                                    (sayac1 / 100).toInt() *
                                                        100) /
                                                10)
                                            .toInt(),
                                        color: Color.fromARGB(255, 255, 0, 0),
                                      ),
                                    ),
                                    Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DigitalLcdNumber(
                                        number: ((sayac1 -
                                                    (sayac1 / 100).toInt() *
                                                        100) %
                                                10)
                                            .toInt(),
                                        color: Color.fromARGB(255, 255, 0, 0),
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
                              height: 170,
                              child: VerticalDivider(
                                indent: 5,
                                thickness: 5,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: takim2,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 15,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DigitalLcdNumber(
                                      number: (sayac2 / 100).toInt(),
                                      color: Color.fromARGB(255, 255, 0, 0),
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DigitalLcdNumber(
                                      number: ((sayac2 -
                                                  (sayac2 / 100).toInt() *
                                                      100) /
                                              10)
                                          .toInt(),
                                      color: Color.fromARGB(255, 255, 0, 0),
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DigitalLcdNumber(
                                      number: ((sayac2 -
                                                  (sayac2 / 100).toInt() *
                                                      100) %
                                              10)
                                          .toInt(),
                                      color: Color.fromARGB(255, 255, 0, 0),
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
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (takim_2 == "") {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Eksik!"),
                                              content: Text(
                                                "Lütfen bir takım ismi giriniz.",
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        if (started) {
                                          sayac2 += 3;
                                        }
                                      }
                                      txt3 = set1.toString() +
                                          "-" +
                                          set2.toString();
                                    });
                                  },
                                  child: const Text(
                                    "+3",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (takim_2 == "") {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Eksik!"),
                                              content: Text(
                                                "Lütfen bir takım ismi giriniz.",
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        if (started) {
                                          sayac2 += 2;
                                        }
                                      }
                                      txt3 = set1.toString() +
                                          "-" +
                                          set2.toString();
                                    });
                                  },
                                  child: const Text(
                                    "+2",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (takim_2 == "") {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Eksik!"),
                                              content: Text(
                                                "Lütfen bir takım ismi giriniz.",
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        if (started) {
                                          sayac2++;
                                        }
                                      }
                                      txt3 = set1.toString() +
                                          "-" +
                                          set2.toString();
                                    });
                                  },
                                  child: const Text(
                                    "+1",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
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
                                      color: Colors.yellow,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.amber,
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
                                                txt3 = "0-0";
                                                set1 = 0;
                                                set2 = 0;
                                                sayac2 = 0;
                                                sayac1 = 0;
                                                takim_1 = "";
                                                takim_2 = "";
                                                takim1 =
                                                    TextEditingController();
                                                takim2 =
                                                    TextEditingController();
                                              });
                                              Navigator.pop(
                                                context,
                                              );
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
                                    color: Colors.black,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.amber,
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
                                                  txt3 = "0-0";
                                                  set1 = 0;
                                                  set2 = 0;
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
                                    color: Colors.black,
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
