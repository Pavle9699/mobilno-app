import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prisustvo/model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffeef444c);
  String birth = "Datum rodjenja";

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController adresaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, bottom: 15),
            height: 120,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: primary),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Student ${User.studentId}",
                style: TextStyle(
                    fontFamily: "NexaBold", fontSize: screenWidth / 18),
              )),
          const SizedBox(
            height: 24,
          ),
          textField("Ime", "Ime", imeController),
          textField("Prezime", "Prezime", prezimeController),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Datum rodjenja",
              style: TextStyle(
                fontFamily: "NexaBold",
                color: Colors.black87,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: primary,
                          secondary: primary,
                          onSecondary: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(primary: primary),
                        ),
                        textTheme: const TextTheme(
                          headline4: TextStyle(fontFamily: "NexaBold"),
                          overline: TextStyle(fontFamily: "NexaBold"),
                          button: TextStyle(fontFamily: "NexaBold"),
                        ),
                      ),
                      child: child!,
                    );
                  }).then((value) {
                setState(() {
                  birth = DateFormat("dd/MM/yyyy").format(value!);
                });
              });
            },
            child: Container(
              height: kToolbarHeight,
              width: screenWidth,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(left: 11),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black54)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  birth,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontFamily: "NexaBold",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          textField("Adresa", "Adresa", adresaController),
          GestureDetector(
            onTap: () async {
              String ime = imeController.text;
              String prezime = prezimeController.text;
              String datumRodjenja = birth;
              String adresa = adresaController.text;
              
              if(ime.isEmpty){
                showSnackBar("Ime je prazno");
              }else if(prezime.isEmpty){
                showSnackBar("Prezime je prazno");
              }else if(datumRodjenja.isEmpty){
                showSnackBar("Prazan Datum prdjenja");
              }else if(adresa.isEmpty){
                showSnackBar("Adresa je prazna");
              }

            },
            child: Container(
              height: kToolbarHeight,
              width: screenWidth,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: primary),
              child: const Center(
                child: Text(
                  "Sacuvaj",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NexaBold",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget textField(String title, String hint, TextEditingController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "NexaBold",
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontFamily: "NexaBold",
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            text,
    )));
  }
}
