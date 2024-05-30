// import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import '../model/profile.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   Profile profile = Profile(email: '', password: '');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Create New Account",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.teal,
//           iconTheme: IconThemeData(color: Colors.white),
//         ),
//         body: Container(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Email",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     TextFormField(
//                       validator: MultiValidator([
//                         RequiredValidator(
//                             errorText: "Please enter your email."),
//                         EmailValidator(
//                             errorText: "Please enter a valid email."),
//                       ]),
//                       keyboardType: TextInputType.emailAddress,
//                       onSaved: (String? email) {
//                         profile.email = email ?? '';
//                       },
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       "Password",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     TextFormField(
//                       validator: RequiredValidator(
//                           errorText: "Please enter your password."),
//                       obscureText: true,
//                       onSaved: (String? password) {
//                         profile.password = password ?? '';
//                       },
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: Colors.cyan,
//                         ),
//                         child: Text(
//                           "Register",
//                           style: TextStyle(
//                               fontStyle: FontStyle.italic, fontSize: 17),
//                         ),
//                         onPressed: () {
//                           if (_formKey.currentState!.validate() ?? false) {
//                             _formKey.currentState?.save();
//                             print(
//                                 "email= ${profile.email}, profile= ${profile.password}");
//                             _formKey.currentState?.reset();
//                           }
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
