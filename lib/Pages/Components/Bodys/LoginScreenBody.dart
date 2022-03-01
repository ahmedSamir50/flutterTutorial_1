import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class LoginVM{
  var emailCtr = TextEditingController();
  var passwordCtr = TextEditingController();
}
class LoginScreenBody {
  static LoginVM frmCRT = LoginVM();
  static getLoginScreenBody()=>Container(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              const Text("Login" , style: TextStyle(
                  fontSize: 30 ,
                  fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              TextFormField(
                controller: frmCRT.emailCtr,
                onFieldSubmitted:(String val)=> onEmailFieldSubmitted(val,"Submitted"),
                onChanged: (String val)=> onEmailFieldSubmitted(val,"Changed"),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "user email address",
                    labelText:"User Email",
                    prefixIcon: Icon( Icons.email),
                    suffixIcon: Icon(Icons.alternate_email),
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                obscureText: true,
                controller: frmCRT.passwordCtr,
                onFieldSubmitted:(String val)=> onPassFieldSubmitted(val,"Submitted"),
                onChanged: (String val)=> onPassFieldSubmitted(val,"Changed"),
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    hintText: "user password",
                    labelText:"Password",
                    prefixIcon: Icon( Icons.password),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20,),
              MaterialButton(
                  onPressed: submitForm ,
                  color: Colors.teal,
                  child:  Container(
                    alignment: Alignment.center ,
                    width: double.infinity,
                    child: const Text(" Go On " ,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold ,
                          fontSize: 20 ),),
                  )
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text("Don't have an account ! "),
                  TextButton(child: const Text("Register Now! "),
                      onPressed: ()=>{
                        print("Don't have an account pressed")
                      }),
                ],
              )
            ],
          ),
        ),
      )
    ),
  );

  static onEmailFieldSubmitted(inputVal,action){
         if (kDebugMode) {
           print(action+": "+inputVal);
         }
  }

  static onPassFieldSubmitted(inputVal,action){
    if (kDebugMode) {
      print(action+": "+inputVal);
    }
  }

  static submitForm(){
    if (kDebugMode) {
      print("Form Submitted :"+frmCRT.emailCtr.text+"&&"+frmCRT.passwordCtr.text);
    }
  }
}