import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchController = TextEditingController();

  var result = "";
  var bgColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: bgColor,
          child: Center(
            child: SizedBox(
              width: 350,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "BMI Calculator",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.w700,color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: weightController,
                      decoration: const InputDecoration(
                        label: Text("Enter Weight in Kgs"),
                        prefixIcon: Icon(Icons.line_weight),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: feetController,
                      decoration: const InputDecoration(
                        label: Text("Enter height in feets"),
                        prefixIcon: Icon(Icons.height),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: inchController,
                      decoration: const InputDecoration(
                        label: Text("Enter height in inches"),
                        prefixIcon: Icon(Icons.height),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        var weight = weightController.text.toString();
                        var feets = feetController.text.toString();
                        var inches = inchController.text.toString();

                        // validate empty fields
                        if (weight != "" && feets != "") {
                          var intWeight = int.parse(weight);
                          var intFeets = int.parse(feets);
                          var intInches = inches == "" ? 0 : int.parse(inches);

                          var totalInches = intFeets * 12 + intInches;
                          var totalCM = totalInches * 2.54;
                          var totalMeter = totalCM / 100;

                          var bmi = intWeight / (totalMeter * totalMeter);

                          var msg = "";

                          if (bmi > 25) {
                            msg = "You are Over Weight!!";
                            bgColor = Colors.red.shade200;
                          } else if (bmi < 18) {
                            msg = "You are Under Weight!!";
                            bgColor = Colors.orange.shade200;
                          } else {
                            msg = "You are Healty!! ";
                            bgColor = Colors.green.shade200;
                          }

                          setState(() {
                            result =
                                "$msg \nYour bmi is ${bmi.toStringAsFixed(2)} ";
                          });
                        } else {
                          setState(() {
                            result = "Please fill the required fields";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue, 
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue, width: 1),
                      ),
                      child: const Text("Calculate"),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      result,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
