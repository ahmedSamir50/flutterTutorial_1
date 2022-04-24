import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_tutorial_learn1/models/loginvm.dart';
import 'package:my_flutter_tutorial_learn1/modules/login/LogInScreen.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/MyAppBar.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/MyAppBarActions.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/components.dart';

class LoginScreenStateFulState extends State<LoginScreenStateFul> {
  late LoginVM frmCRT;
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();

  @override
  void initState() {
    frmCRT = LoginVM();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MyAppBar(
            leading: const Icon(Icons.menu),
            title: const Text("App Login Simple ....."),
            barActions: MyAppBarActions.getAppBarActions()),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: frmKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextInput(
                          fromController: frmCRT.emailCtr,
                          keyboardType: TextInputType.emailAddress,
                          hint: "user email address",
                          label: "User Email",
                          prefixIcon: Icons.email,
                          suffixIcon: Icons.alternate_email,
                          onChange: (String val) =>
                              onEmailFieldSubmitted(val, "Changed"),
                          onFieldSubmit: (String val) =>
                              onEmailFieldSubmitted(val, "Submitted"),
                          validationCallBack: (value) =>
                              validateEmptyStr(value)),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextInput(
                          isObscureText: !frmCRT.displayPassField,
                          fromController: frmCRT.passwordCtr,
                          keyboardType: TextInputType.visiblePassword,
                          hint: "user password",
                          label: "Password",
                          prefixIcon: Icons.password,
                          suffixIcon: frmCRT.displayPassField
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          onChange: (String val) =>
                              onPassFieldSubmitted(val, "Changed"),
                          onFieldSubmit: (String val) =>
                              onPassFieldSubmitted(val, "Submitted"),
                          validationCallBack: (value) =>
                              validateEmptyStr(value),
                          suffixPressed: () => {
                                setState(() => {
                                      frmCRT.displayPassField =
                                          !frmCRT.displayPassField
                                    })
                              }),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          onPressed: submitForm,
                          color: Colors.teal,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: const Text(
                              " Go On ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("Don't have an account ! "),
                          TextButton(
                              child: const Text("Register Now! "),
                              onPressed: () => {
                                    if (kDebugMode)
                                      print("Don't have an account pressed")
                                  }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  onEmailFieldSubmitted(inputVal, action) {
    if (kDebugMode) {
      print(action + ": " + inputVal);
    }
  }

  static onPassFieldSubmitted(inputVal, action) {
    if (kDebugMode) {
      print(action + ": " + inputVal);
    }
  }

  submitForm() {
    var validate = frmKey.currentState?.validate();
    if (validate != null && validate) {
      if (kDebugMode) {
        print("Form Submitted :" +
            frmCRT.emailCtr.text +
            "&&" +
            frmCRT.passwordCtr.text);
      }
    }
  }

  String? validateEmptyStr(String? value,
      {String notValeidMSG = "Field Can't be null "}) {
    if (value == null || value.isEmpty) {
      return notValeidMSG;
    }
    return null;
  }
}
