import 'package:flutter/material.dart';
import 'package:test_task/auth/auth_service.dart';
import 'package:test_task/components/my_button.dart';
import 'package:test_task/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();
    if (_passwordController.text == _confirmPwController.text) {
      try {
        _auth.signInWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_open,
              size: 60,
              color: Colors.grey[600],
            ),
            Text(
              "Create an acoount",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextfield(
              hintText: 'Name',
              obscureText: false,
              controller: _nameController,
            ),
            SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: 'Comfirm password',
              obscureText: true,
              controller: _confirmPwController,
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(onTap: () => register(context), text: 'Register'),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:test_task/components/my_button.dart';
// import 'package:test_task/components/my_textfield.dart';
// import 'package:test_task/pages/profile_page.dart';

// class RegisterPage extends StatelessWidget {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPwController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();

//   final void Function()? onTap;

//   RegisterPage({super.key, required this.onTap});

//   Future<void> register(BuildContext context) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//     if (_passwordController.text == _confirmPwController.text) {
//       try {
//         // Create user with email and password
//         UserCredential userCredential =
//             await _auth.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );

//         // Get the current user
//         User? user = userCredential.user;

//         // Save the user's name and email in Firestore
//         if (user != null) {
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(user.uid)
//               .set({
//             'name': _nameController.text.trim(),
//             'email': _emailController.text.trim(),
//             'uid': user.uid,
//           });
//         }

//         // Navigate to the ProfilePage and pass the name and email
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProfilePage(
//               name: _nameController.text.trim(),
//               email: _emailController.text.trim(),
//             ),
//           ),
//         );
//       } catch (e) {
//         // Handle errors
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text("Error"),
//             content: Text(e.toString()),
//           ),
//         );
//       }
//     } else {
//       // Show password mismatch error
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Passwords don't match!"),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.lock_open,
//               size: 60,
//               color: Colors.grey[600],
//             ),
//             Text(
//               "Create an account",
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             MyTextfield(
//               hintText: 'Name',
//               obscureText: false,
//               controller: _nameController,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextfield(
//               hintText: 'Email',
//               obscureText: false,
//               controller: _emailController,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextfield(
//               hintText: 'Password',
//               obscureText: true,
//               controller: _passwordController,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextfield(
//               hintText: 'Confirm password',
//               obscureText: true,
//               controller: _confirmPwController,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             MyButton(onTap: () => register(context), text: 'Register'),
//             SizedBox(
//               height: 25,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Already have an account?'),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 GestureDetector(
//                   onTap: onTap,
//                   child: Text(
//                     "Login now",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
