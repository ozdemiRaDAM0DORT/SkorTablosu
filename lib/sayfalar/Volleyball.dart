import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_lcd_number/digital_lcd_number.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:score_board_2/sayfalar/Home.dart';

class VolleyballScore extends StatefulWidget {
  @override
  _VolleyballScoreState createState() => _VolleyballScoreState();
}

int sayac1 = 0;
int sayac2 = 0;
TextEditingController takim1 = TextEditingController();
TextEditingController takim2 = TextEditingController();
String takim_1 = "Takım - 1";
String takim_2 = "Takım - 2";
int set1 = 0;
int set2 = 0;
String txt = set1.toString() + "-" + set2.toString();
String txt2 = "";
int x = 0;

class _VolleyballScoreState extends State<VolleyballScore> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text("Voleybol Skor Tahtası"),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        actions: <Widget>[
          Text(
            "Set : ",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            txt,
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 406,
          )
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
      body: Center(
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
                                color: Colors.black,
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 217, 0, 255),
                                    width: 3),
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
                                      if (sayac1 < sayac2) {
                                        x = sayac2 - sayac1;
                                      } else {
                                        x = sayac1 - sayac2;
                                      }
                                      if (sayac1 < 24) {
                                        sayac1++;
                                      } else {
                                        if (x > 1) {
                                          sayac1 = 0;
                                          if (set1 != 2) {
                                            set1++;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Set bitti!"),
                                                  content: Text(
                                                    "Seti " +
                                                        takim_1 +
                                                        " kazandı.",
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            set1++;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Maç bitti!"),
                                                  content: Text(
                                                    "Maçı " +
                                                        takim_1 +
                                                        " kazandı",
                                                  ),
                                                );
                                              },
                                            );
                                            set1 = 0;
                                            set2 = 0;
                                          }
                                          sayac2 = 0;
                                        } else {
                                          sayac1++;
                                          if (sayac1 - sayac2 == 2) {
                                            sayac1 = 0;
                                            if (set1 != 2) {
                                              set1++;
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Set bitti!"),
                                                    content: Text(
                                                      "Seti " +
                                                          takim_1 +
                                                          " kazandı.",
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              set1++;
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Maç bitti!"),
                                                    content: Text(
                                                      "Maçı " +
                                                          takim_1 +
                                                          " kazandı",
                                                    ),
                                                  );
                                                },
                                              );
                                              set1 = 0;
                                              set2 = 0;
                                            }
                                            sayac2 = 0;
                                          }
                                        }
                                      }
                                    }
                                    txt =
                                        set1.toString() + "-" + set2.toString();
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
                                color: Colors.black,
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 217, 0, 255),
                                    width: 3),
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
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DigitalLcdNumber(
                                      number: (sayac1 / 10).toInt(),
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
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
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DigitalLcdNumber(
                                    number: (sayac2 / 10).toInt(),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
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
                                color: Colors.black,
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 217, 0, 255),
                                    width: 3),
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
                                      if (sayac1 < sayac2) {
                                        x = sayac2 - sayac1;
                                      } else {
                                        x = sayac1 - sayac2;
                                      }
                                      if (sayac2 < 24) {
                                        sayac2++;
                                      } else {
                                        if (x > 1) {
                                          if (set2 != 2) {
                                            set2++;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Set bitti!"),
                                                  content: Text(
                                                    "Seti " +
                                                        takim_2 +
                                                        " kazandı",
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            set2++;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Maç bitti!"),
                                                  content: Text(
                                                    "Maçı " +
                                                        takim_2 +
                                                        " kazandı",
                                                  ),
                                                );
                                              },
                                            );
                                            set1 = 0;
                                            set2 = 0;
                                          }
                                          sayac2 = 0;
                                          sayac1 = 0;
                                        } else {
                                          sayac2++;
                                          if (sayac2 - sayac1 == 2) {
                                            if (set2 != 2) {
                                              set2++;
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Set bitti!"),
                                                    content: Text(
                                                      "Seti " +
                                                          takim_2 +
                                                          " kazandı",
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              set2++;
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Maç bitti!"),
                                                    content: Text(
                                                      "Maçı " +
                                                          takim_2 +
                                                          " kazandı",
                                                    ),
                                                  );
                                                },
                                              );
                                              set1 = 0;
                                              set2 = 0;
                                            }
                                            sayac2 = 0;
                                            sayac1 = 0;
                                          }
                                        }
                                      }
                                    }
                                    txt =
                                        set1.toString() + "-" + set2.toString();
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
                                color: Colors.black,
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 217, 0, 255),
                                    width: 3),
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
                              color: const Color.fromARGB(255, 217, 0, 255),
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
                                              txt = "0-0";
                                              set1 = 0;
                                              set2 = 0;
                                              sayac2 = 0;
                                              sayac1 = 0;
                                              takim_1 = "";
                                              takim_2 = "";
                                              takim1 = TextEditingController();
                                              takim2 = TextEditingController();
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
                              color: const Color.fromARGB(255, 217, 0, 255),
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
                                                txt = "0-0";
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
    );
  }
}
