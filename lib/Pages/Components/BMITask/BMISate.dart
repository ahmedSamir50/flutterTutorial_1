
import 'package:flutter/material.dart';
import 'package:untitled1/Pages/Components/BMITask/BIMStateModel.dart';
import 'package:untitled1/Pages/Components/BMITask/BMIApp.dart';
import 'package:untitled1/Pages/Components/BMITask/BMIResultScreen.dart';

class BMIState extends State<BMIApp>{
  static final widgetsBGColor =  Colors.grey[900];
  static const widgetsBGColorBlue =  Colors.blueAccent;

  static const maleFemaleTextStyle = TextStyle(fontSize: 20 , fontWeight: FontWeight.bold);
  late BMIStateModel stt ;
  @override
  void initState() {
    stt =  BMIStateModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context ){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Builder(
        builder: (context)=>Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                    child:  Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(child:  Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: stt.clientGender ==
                                    ClientGender.MALE?
                                widgetsBGColorBlue: widgetsBGColor
                            ),
                            child: GestureDetector(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.male , size: 80,),
                                  Text("MALE",style: maleFemaleTextStyle,)
                                ],
                              ),
                              onTap: ()=>{
                                setState(()=>{
                                  stt.clientGender = ClientGender.MALE
                                })
                              },
                            ),
                          )),
                          const SizedBox(width: 20,),
                          Expanded(child:  Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: stt.clientGender !=
                                    ClientGender.MALE?
                                widgetsBGColorBlue: widgetsBGColor
                            ),
                            child: GestureDetector(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.female,size: 80),
                                  Text("FEMALE",style: maleFemaleTextStyle,)
                                ],
                              ),
                              onTap: ()=>{
                                setState(()=>{
                                  stt.clientGender = ClientGender.FEMALE
                                })
                              },
                            ),
                          )),

                        ],
                      ),
                    )),
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: widgetsBGColor
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("HEIGHT",style: maleFemaleTextStyle,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children:  [
                              Text(stt.clientHeight.toString(),style: maleFemaleTextStyle),
                              const Text(" ~CM" )
                            ],
                          ),
                          Slider(value: stt.clientHeight.toDouble() ,min: 49 , max: 250,
                              onChanged: (val)=>{
                                setState(()=>{
                                  stt.clientHeight = val.round()
                                })
                              })
                        ],
                      ),
                    )),
                Expanded(child: Container()),
                MaterialButton(
                    color: Colors.red,
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: ()=>{
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context)=>BMIResultsScreen(stt)
                          ) )
                    },child: Text("CALCULATE ! "))

              ],
            ),
          ),
        ),
      ),
    );
  }

}
