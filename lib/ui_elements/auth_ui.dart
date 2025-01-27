// import 'package:MetaBit/custom/box_decorations.dart';
// import 'package:MetaBit/custom/device_info.dart';
// import 'package:MetaBit/helpers/shared_value_helper.dart';
// import 'package:MetaBit/my_theme.dart';
// import 'package:flutter/material.dart';

// class AuthScreen {
//   static Widget buildScreen(
//       BuildContext context, String headerText, Widget child) {
//     return Directionality(
//       textDirection:
//           app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         //key: _scaffoldKey,
//         //drawer: MainDrawer(),
//         backgroundColor: Colors.white,
//         //appBar: buildAppBar(context),

//         body: Stack(
//           children: [
//             Container(
//               height: DeviceInfo(context).height! / 3,
//               width: DeviceInfo(context).width,
//               color: MyTheme.accent_color,
//               alignment: Alignment.topRight,
//               child: Image.asset(
//                 "assets/background_1.png",
//               ),
//             ),
//             Positioned(
//               top: MediaQuery.of(context).padding.top + 10,
//               right: 10,
//               child: IconButton(
//                 icon: Icon(Icons.close, color: MyTheme.white, size: 24),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   print('click');
//                 },
//               ),
//             ),
//             CustomScrollView(
//               //controller: _mainScrollController,
//               physics: const BouncingScrollPhysics(
//                   parent: AlwaysScrollableScrollPhysics()),
//               slivers: [
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                     [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 48.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 12),
//                               width: 72,
//                               height: 72,
//                               decoration: BoxDecoration(
//                                   color: MyTheme.white,
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: Image.asset(
//                                   'assets/login_registration_form_logo.png'),
//                             ),
//                           ],
//                           mainAxisAlignment: MainAxisAlignment.center,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 20.0, top: 10),
//                         child: Text(
//                           headerText,
//                           style: TextStyle(
//                               color: MyTheme.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 20),
//                           decoration:
//                               BoxDecorations.buildBoxDecoration_1(radius: 16),
//                           child: child,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:MetaBit/custom/box_decorations.dart';
import 'package:MetaBit/custom/device_info.dart';
import 'package:MetaBit/helpers/shared_value_helper.dart';
import 'package:MetaBit/my_theme.dart';
import 'package:flutter/material.dart';

class AuthScreen {
  static Widget buildScreen(
      BuildContext context, String headerText, Widget child) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background container
            Container(
              height: DeviceInfo(context).height! / 3,
              width: DeviceInfo(context).width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 19, 84, 107),
                    Color.fromARGB(255, 32, 179, 228),
                    Color.fromARGB(255, 153, 177, 113),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/background_1.png",
              ),
            ),
            // CustomScrollView
            CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 48.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: MyTheme.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.asset(
                                  'assets/logo-removebg-preview.png'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                        child: Text(
                          headerText,
                          style: TextStyle(
                              color: MyTheme.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration:
                              BoxDecorations.buildBoxDecoration_1(radius: 16),
                          child: child,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Cross Button
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red
                        .withOpacity(0.7), // Optional background color
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
