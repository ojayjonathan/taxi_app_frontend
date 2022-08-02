import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/data/models/models.dart';
import 'package:taxi_app/data/rest/client.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/presentation/widgets/paints/curvePaint.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<TravelRoute>? operationRoutes;
  //for filtering in search
  List<TravelRoute>? operationRoutesAll;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final res = await Client.customer.routes();
    res.when(
      (error) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message,
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          duration: const Duration(seconds: 10000),
          action: SnackBarAction(label: "retry", onPressed: fetchData),
        ),
      ),
      (data) {
        setState(
          () {
            operationRoutes = data.toList();
            operationRoutesAll = data.toList();
          },
        );
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    );
  }

  Future<void> refreshData() async {
    fetchData();
  }

  void filterData(String text) {
    text = text.toLowerCase();
    Iterable<TravelRoute> routesFiltered = operationRoutesAll!.where(
      (item) {
        return (item.origin.name.toLowerCase().contains(text) ||
            item.destination.name.toLowerCase().contains(text));
      },
    );
    setState(
      () {
        operationRoutes = routesFiltered.toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Widget _card(TravelRoute route) {
      String label = route.available == true ? "Book Now" : "Coming Soon";
      return Card(
        elevation: 3,
        shadowColor: Colors.grey[200],
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${route.origin} - ${route.destination}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Palette.dark[2],
                      fontSize: 14)),
              Text(
                "Ksh ${route.cost}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Palette.dark[2],
                    fontSize: 15),
              ),
              actionButton(context, label, () {
                context.pushNamed(
                  AppRoutes.makeBooking,
                  extra: {"from": route.origin, "to": route.destination},
                );
              }, padding: 5)
            ],
          ),
        ),
      );
    }

    Widget curvedNavigationBar = CurvedNavigationBar(
        height: 50,
        index: 1,
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
          } else if (index == 2) {
            context.pushNamed(AppRoutes.support);
          } else {
            context.pushNamed(AppRoutes.home);
          }
        });
    return Scaffold(
      bottomNavigationBar: curvedNavigationBar,
      body: Column(
        children: [
          Stack(
            children: [
              const Positioned(
                top: 0,
                left: 0,
                child: CurvePaint(),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: height * 0.1),
                  _searchField(),
                  SizedBox(height: height * 0.08),
                ],
              )
            ],
          ),
          operationRoutes != null
              ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: refreshData,
                    child: GridView.count(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      childAspectRatio: 1.2,
                      children: [
                        // ignore: sdk_version_ui_as_code
                        ...operationRoutes!.map(
                          (item) => _card(item),
                        ),
                        operationRoutes!.isEmpty
                            ? const Center(child: Text("Nothing was found"))
                            : const SizedBox(
                                height: 0,
                              )
                      ],
                    ),
                  ),
                )
              : const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black87),
                )
        ],
      ),
    );
  }

  Container _searchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 10,
              shadowColor: Colors.grey[300],
              child: TextField(
                onChanged: filterData,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0x00ffffff),
                    hintText: "Search",
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Palette.accentColor,
                size: 40,
              ))
        ],
      ),
    );
  }
}
