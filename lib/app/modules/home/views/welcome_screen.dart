// import 'package:firebase_with_getx_todo/app/modules/home/views/home_view.dart';
// import 'package:firebase_with_getx_todo/app/widgets/myButton.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[500],
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 50),
//               child: Container(
//                 child: Lottie.network(
//                     'https://lottie.host/d869db68-6c5e-46f6-acd7-197b7f2da684/zAzdU7PHxR.json'),
//                 height: 160,
//               ),
//             ),
//             Center(
//               child: Text(
//                 "Welcome to",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w300,
//                   fontSize: 22,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Center(
//               child: Text(
//                 "Todo_App",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               alignment: Alignment.center,
//               margin: const EdgeInsets.symmetric(
//                 horizontal: 10,
//               ),
//               child: Text(
//                 "",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),
//             ),
//             SizedBox(height: 50),
//             MyButton(
//               height: 50.0,
//               onPressed: () {
//                 Get.to(() => HomeScreen());
//               },
//               color: Colors.blue,
//               title: 'Add Todo',
//               icon: Icons.add,
//             ),
//             SizedBox(height: 20),
//             MyButton(
//               height: 50.0,
//               onPressed: () {
//                 // Get.to(() => MyTodosScreen());
//               },
//               title: 'My Todos',
//               icon: Icons.task,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_with_getx_todo/app/modules/home/controllers/auth_controller.dart';
import 'package:firebase_with_getx_todo/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_with_getx_todo/app/utils/constants.dart';
import 'package:firebase_with_getx_todo/app/widgets/todo_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.put(AuthController());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TodoLogo(),
            Padding(padding:  EdgeInsets.all(8.0),
            child: SizedBox(
              width: 50,
              child: LinearProgressIndicator(),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
