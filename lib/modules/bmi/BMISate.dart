import 'package:flutter/material.dart';
import 'package:my_flutter_tutorial_learn1/models/BIMStateModel.dart';
import 'package:my_flutter_tutorial_learn1/modules/bmi/BMIApp.dart';
import 'package:my_flutter_tutorial_learn1/modules/bmi/BMIResultScreen.dart';

class BMIState extends State<BMIApp> {
  static final widgetsBGColor = Colors.grey[900];
  static const widgetsBGColorBlue = Colors.blueAccent;

  static const maleFemaleTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  late BMIStateModel stt;

  @override
  void initState() {
    stt = BMIStateModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Builder(
        builder: (context) => Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: stt.clientGender == ClientGender.MALE
                                ? widgetsBGColorBlue
                                : widgetsBGColor),
                        child: GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.male,
                                size: 80,
                              ),
                              Text(
                                "MALE",
                                style: maleFemaleTextStyle,
                              )
                            ],
                          ),
                          onTap: () => {
                            setState(
                                () => {stt.clientGender = ClientGender.MALE})
                          },
                        ),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: stt.clientGender != ClientGender.MALE
                                ? widgetsBGColorBlue
                                : widgetsBGColor),
                        child: GestureDetector(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.female, size: 80),
                              Text(
                                "FEMALE",
                                style: maleFemaleTextStyle,
                              )
                            ],
                          ),
                          onTap: () => {
                            setState(
                                () => {stt.clientGender = ClientGender.FEMALE})
                          },
                        ),
                      )),
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widgetsBGColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "HEIGHT",
                        style: maleFemaleTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(stt.clientHeight.toString(),
                              style: maleFemaleTextStyle),
                          const Text(" ~CM")
                        ],
                      ),
                      Slider(
                          value: stt.clientHeight.toDouble(),
                          min: 49,
                          max: 250,
                          onChanged: (val) => {
                                setState(() => {stt.clientHeight = val.round()})
                              })
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widgetsBGColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Wight", style: maleFemaleTextStyle),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                    child: Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle),
                                    child: MaterialButton(
                                        child: const Text("-",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () => {
                                              setState(() => stt.clientWight--)
                                            }),
                                  ),
                                )),
                                Expanded(
                                    child: Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle),
                                    child: MaterialButton(
                                        child: Text(stt.clientWight.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () => {}),
                                  ),
                                )),
                                Expanded(
                                    child: Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle),
                                    child: MaterialButton(
                                        child: const Text("+",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () => {
                                              setState(() => stt.clientWight++)
                                            }),
                                  ),
                                )),
                              ],
                            )
                          ],
                        ),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widgetsBGColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Age", style: maleFemaleTextStyle),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                    child: Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle),
                                    child: MaterialButton(
                                        child: const Text("-",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () =>
                                            {setState(() => stt.clientAge--)}),
                                  ),
                                )),
                                Expanded(
                                    child: Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle),
                                    child: MaterialButton(
                                        child: Text(stt.clientAge.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () => {}),
                                  ),
                                )),
                                Expanded(
                                    child: Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle),
                                    child: MaterialButton(
                                        child: const Text("+",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () =>
                                            {setState(() => stt.clientAge++)}),
                                  ),
                                )),
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                )),
                MaterialButton(
                    color: Colors.red,
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BMIResultsScreen(stt)))
                        },
                    child: const Text("CALCULATE ! "))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
