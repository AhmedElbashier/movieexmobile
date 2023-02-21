import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
            child: Text(
              'Contact Us',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.grey),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: mediaQueryH / 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                  child: ListTile(
                    onTap: () {
                      launch('tel://+249967771111');
                    },
                    tileColor: Colors.grey[900],
                    leading: Icon(
                      Icons.call,
                      color: Colors.green[700],
                    ),
                    title: Text(
                      'Call',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQueryH / 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                  child: ListTile(
                    onTap: () {},
                    tileColor: Colors.grey[900],
                    leading: SizedBox(
                      height: mediaQueryH / 35,
                      child: Image.asset("assets/whatsapp.png"),
                    ),
                    title: Text(
                      'Whatsapp',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQueryH / 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                  child: ListTile(
                    onTap: () {
                      launch(
                          'https://www.facebook.com/profile.php?id=100087672577607');
                    },
                    tileColor: Colors.grey[900],
                    leading: SizedBox(
                      height: mediaQueryH / 35,
                      child: Image.asset("assets/facebook.png"),
                    ),
                    title: Text(
                      'Facebook',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQueryH / 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                  child: ListTile(
                    onTap: () {
                      launch(
                          'https://twitter.com/MovieexSD?t=fUpJ9lvra8pei4orYa1zCA&s=08');
                    },
                    tileColor: Colors.grey[900],
                    leading: SizedBox(
                      height: mediaQueryH / 35,
                      child: Image.asset("assets/twitter.png"),
                    ),
                    title: Text(
                      'Twitter',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQueryH / 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                  child: ListTile(
                    onTap: () {
                      launch(
                          'https://www.instagram.com/invites/contact/?i=4oeg04ioo58t&utm_content=puxykg0');
                    },
                    tileColor: Colors.grey[900],
                    leading: SizedBox(
                      height: mediaQueryH / 35,
                      child: Image.asset("assets/instagram.png"),
                    ),
                    title: Text(
                      'Instagram',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQueryH / 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                  child: ListTile(
                    onTap: () {
                      launch(
                          'https://www.tiktok.com/@movieexsd?_t=8XBtGQKPlpu&_r=1');
                    },
                    tileColor: Colors.grey[900],
                    leading: SizedBox(
                      height: mediaQueryH / 35,
                      child: Image.asset("assets/tik-tok.png"),
                    ),
                    title: Text(
                      'TikTok',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
