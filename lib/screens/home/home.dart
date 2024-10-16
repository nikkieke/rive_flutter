import 'package:flutter/material.dart';
import 'package:rive_flutter/screens/screens.dart';
import 'package:rive_flutter/widgets/options.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rive x Flutter",
              style: TextStyle(color: Colors.white, fontSize: 30)),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const SideDrawer(),
        body: ListView(
          shrinkWrap: false,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 30,
            ),
            Options(
              title: 'Archery Pull to refresh',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArcheryScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Options(
              title: 'Tree Planting Timer',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TreePlantingScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Options(
              title: 'Bottom Nav Icons',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BottomNav()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Options(
              title: 'Delivery tracker',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DeliveryScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Options(
              title: 'Star Rating',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StarRatingScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 200,
        backgroundColor: Colors.black,
        child: Container(
            padding: const EdgeInsets.only(top: 50),
            child: Column(children: [
              ListTile(
                  leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                  title: const Text("Archery Pull to refresh",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ArcheryScreen()));
                  }),
              ListTile(
                  leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                  title: const Text("Tree Planting Timer",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TreePlantingScreen()));
                  }),
              ListTile(
                  leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                  title: const Text("Bottom Nav Icons",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNav()));
                  }),
              ListTile(
                  leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                  title: const Text("Delivery tracker",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeliveryScreen()));
                  }),
              ListTile(
                  leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                  title: const Text("Star Rating",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StarRatingScreen()));
                  }),
            ])));
  }
}
