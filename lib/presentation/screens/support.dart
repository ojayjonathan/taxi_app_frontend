import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/presentation/widgets/paints/bezier_container.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _call(String url) async {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {}
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: "page_paint",
                child: BezierContainer(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/graphics/contact.svg", width: 300),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                        color: Palette.dark[2],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                InkWell(
                  onTap: () => _call("tel:0716539104"),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 2,
                    shadowColor: Colors.grey[250],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.phone,
                              size: 20,
                              color: Palette.accentColor,
                            ),
                          ),
                          SelectableText("0716539104")
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  elevation: 2,
                  shadowColor: Colors.grey[250],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.email,
                            size: 20,
                            color: Palette.accentColor,
                          ),
                        ),
                        InkWell(
                          onTap: () => _call("mailto:matndogo254@gmail.com"),
                          child: const Text("matndogo254@gmail.com"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        height: 50,
        backgroundColor: Palette.accentColor,
        items: <Widget>[
          Icon(
            Icons.person,
            size: 30,
            color: Palette.dark[2],
          ),
          Icon(Icons.home, size: 30, color: Palette.dark[2]),
          Icon(Icons.phone, size: 30, color: Palette.dark[2]),
        ],
        onTap: (index) {
          if (index == 0) {
            context.pushNamed(AppRoutes.account);
          } else if (index == 1) {
            context.pushNamed(AppRoutes.home);
          }
        },
      ),
    );
  }
}
