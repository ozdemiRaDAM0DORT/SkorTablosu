import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:score_board_2/sayfalar/Basketball.dart';
import 'package:score_board_2/sayfalar/Football.dart';
import 'package:score_board_2/sayfalar/Volleyball.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde yatay (landscape) moda kilitle
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
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
    var ekranBoyutu = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 75,
        horizontal: 20,
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 20,
              child: const Text(
                "Skor tablosuna",
                style: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.none,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.white,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 20,
              child: const Text(
                "hoşgeldiniz",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.white,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Expanded(
              flex: 150,
              child: Container(
                width: ekranBoyutu.width * 0.9,
                height: ekranBoyutu.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: ekranBoyutu.width * 0.9,
                        height: ekranBoyutu.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FootballScore()),
                            );
                          },
                          child: const Text(
                            "=>Futbol skor tahtası<=",
                            style: TextStyle(
                              fontSize: 30,
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Container(
                        width: ekranBoyutu.width * 0.9,
                        height: ekranBoyutu.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BasketballScore()),
                          ),
                          child: const Text(
                            "->Basketbol skor tahtası<-",
                            style: TextStyle(
                              fontSize: 30,
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        width: ekranBoyutu.width * 0.9,
                        height: ekranBoyutu.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VolleyballScore(),
                              ),
                            );
                          },
                          child: const Text(
                            "=>Voleybol skor tahtası<=",
                            style: TextStyle(
                              fontSize: 30,
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
