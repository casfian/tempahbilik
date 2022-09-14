import 'package:flutter/material.dart';
import 'package:tempahbilik/bilik.dart';
import 'package:tempahbilik/details.dart';
import 'package:tempahbilik/kalendartempahan.dart';
import 'package:tempahbilik/profile.dart';
import 'package:tempahbilik/tempahansaya.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Bilik> bilik = [
    Bilik('Bilik A', 10, 'bilik_A.jpg', Colors.blue),
    Bilik('Bilik B', 15, 'bilik_B.jpg', Colors.green),
    Bilik('Bilik C', 100, 'bilik_C.jpg', Colors.yellow),
    Bilik('Bilik D', 30, 'bilik_D.jpg', Colors.pink),
    Bilik('Bilik E', 50, 'bilik_E.jpg', Colors.red),
    Bilik('Bilik F', 50, 'bilik_F.jpg', Colors.grey),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => const Home());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              title: const Text('Kalendar Tempahan'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => const KalendarTempahan());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              title: const Text('Tempahan Saya'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => const TempahanSaya());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => const ProfileCheck());
                Navigator.push(context, route);
              },
            ),
            const ListTile(
              title: Text('Logout'),
            )
          ],
        ),
      ),
      body: GridView.count(
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
        children: List.generate(bilik.length, (index) {
          return Center(
              child: InkWell(
            onTap: () {
              //code
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Details(passBilik: bilik[index]));
              Navigator.push(context, route);
              debugPrint('I Clicked ${bilik[index]}');
            },
            child: SizedBox(
                width: 180,
                height: 170,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/${bilik[index].photo}',
                      fit: BoxFit.fill,
                    ),
                    Text(bilik[index].nama),
                    Text('Muat: ${bilik[index].kapasiti.toString()}'),
                  ],
                ))),
          ));
        }),
      ),
    );
  }
}
