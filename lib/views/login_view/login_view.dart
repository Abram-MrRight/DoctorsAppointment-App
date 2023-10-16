import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       padding: EdgeInsets.all(8),
       child: Column(
         children: [
           Expanded(child: Container(
             color: Colors.red,
           )),
           Expanded(
               flex: 2,
               child: Container(
             color: Colors.green,
             child: Form(
               child: Column(
                 children: [
                   TextFormField(
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: "Enter your email",
                     ),
                   )
                 ],
               ),
             ),
           ))
         ],
       ),
     ),
    );
  }
}
