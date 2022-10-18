import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikidados_teste/models/userAuth.dart';
import 'package:wikidados_teste/pages/login.dart';
import 'package:wikidados_teste/pages/map.dart';
import 'package:wikidados_teste/pages/vehiclePage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Builder for each item list
  Widget buildMenuItem(
      {required Icon icon,
      required String text,
      required VoidCallback? onClick}) {
    //
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      contentPadding: EdgeInsets.all(10),
      leading: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: icon,
      ),
      title: Text(
        text,
      ),
      onTap: (onClick),
    );
  }

  // Changes pages
  void goToPage(BuildContext context, int index) {
    // Removes current page from the stack, it closes the drawer
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MapPage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VehiclePage()));
        break;
    }
  }

  // Logout
  void logout(
    BuildContext context,
  ) {
    Provider.of<UserAuth>(context, listen: false).logout();

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Material Container
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.only(top: 35, left: 15, bottom: 15, right: 15),
          children: [
            // User Logged
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Column(children: [
                CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        "https://scontent.fcac4-1.fna.fbcdn.net/v/t1.18169-9/29542503_1624814830973352_1362956203500990247_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeE_OWhm1mD3wu5OOjki1FGRUyCejWKBh4NTIJ6NYoGHg86Yt1hnZ4lPisB0oSQVvrsUewFMTsvykWLWR9io2KcZ&_nc_ohc=X6dnMW0IkAIAX9lRYza&_nc_ht=scontent.fcac4-1.fna&oh=00_AT_hhGR3jitAgTq7yJmKlq0NFwEgZPR-Ondv6MvmktiyGQ&oe=6373559D")),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Worst One",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "luccagabriel12@hotmail.com",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontStyle: FontStyle.italic),
                )
              ]),
            ),

            Divider(
              color: Colors.white,
            ),

            // Menu Itens
            buildMenuItem(
                icon: Icon(Icons.map),
                text: "Mapas",
                onClick: (() => goToPage(context, 0))),
            buildMenuItem(
                icon: Icon(Icons.directions_car),
                text: "Veículos",
                onClick: (() => goToPage(context, 1))),

            // Logout button
            buildMenuItem(
                icon: Icon(Icons.logout),
                text: "Logout",
                onClick: (() => logout(context)))
          ],
        ),
      ),
    );
  }
}
