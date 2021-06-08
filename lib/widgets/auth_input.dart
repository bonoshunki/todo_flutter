import 'package:flutter/material.dart';

// class EmailAndPass extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Email Address',
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//               ),
//               onChanged: (String value) {
//                 newEmail = value;
//               },
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//               ),
//               onChanged: (String value) {
//                 newPass = value;
//               },
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//         ],
//       ),
//     );
//   }
// }

class InputForm {
  Widget emailAndPass(Function setEmail, Function setPass) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
          onChanged: (String value) {
            setEmail(value);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
          onChanged: (String value) {
            setPass(value);
          },
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
