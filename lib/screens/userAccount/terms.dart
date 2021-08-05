import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';

// ignore: must_be_immutable
class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Title(
          child: Text(
            "Terms and conditions",
            
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding:EdgeInsets.all(15),
        child: ListView(children: getTerms()),
      ),
    );
  }

  List<Widget> getTerms() {
    List<Widget> items=[];
    final Map<String, List<String>> terms = {
      "Data and information": [
        "1. Mat’Ndogo terms and condition is cemented to hold and protect the information of our customers when they use our services and our mobile services.",
        "2. The information below may be disclosed to certain third-party services such as; name, email, location, phone number, and other relevant information as you use our services.",
        "3. This information is shared to personalize the app for you, perform behavioral analysis, scaling our product and services, and periodically send our new updates to our new product and services.",
        "4. Mat’Ndogo does not offer parcel services "
      ],
      "Security ": [
        "1. Mat’Ndogo is dedicated to ensuring that our current information is secure.",
        "2. To prevent unauthorized access, we have a physical and suitable electronic management procedure that will safeguard and collect online. ",
        "3 Children below the age of 13years will not be allowed to use our services without a guardian.",
      ],
      "Payments ": [
        "1. Only the verified payment model will be accepted in settling payments.",
        "2. The company will only accept the valid currency as stated by the constitution.",
        "3. Refunds will only be done on successful claims.",
        "4. Any person above the age of 6 years will be required to pay for a seat."
      ]
    };
    for (var key in terms.keys) {
      Widget column = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              key,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.dark[2],
                  fontSize: 15),
            ),
          ),
          ...terms[key].map((e) => Padding(
                padding: EdgeInsets.only(left: 30,top: 10),
                child: Text(e,textAlign: TextAlign.left,),
              ))
        ],
      );
      items.add(column);
    }
    return items;
  }
}
