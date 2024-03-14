// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class Healthtips extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: Builder(
//         builder: (BuildContext context) {
//           return WebView(
//             initialUrl: 'https://www.pennmedicine.org/updates/blogs/health-and-wellness/2019/april/blood-types',
//             javascriptMode: JavascriptMode.unrestricted,
//           );
//         },
//       ),
//     );
//   }

//   AppBar buildAppBar() {
//     return AppBar(
//       title: Text(
//         'Health Blogs',
//         style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
//       ),
//       backgroundColor: Colors.teal,
//       elevation: 0,

//       // IconButton(
//       //   icon: SvgPicture.asset(
//       //     'assets/icons/back.svg',
//       //     color: Colors.red,
//       //   ),
//       //   onPressed: () => '',
//       // ),
//       // actions: <Widget>[
//       //   IconButton(
//       //     icon: Icon(Icons.share),
//       //     onPressed: () {},
//       //     color: Colors.white,
//       //   ),
//       // IconButton(
//       //   icon: SvgPicture.asset("assets/icons/cart.svg"),
//       //   //   onPressed: () {},
//       //   // ),
//       //   SizedBox(width: 20 / 2)
//       // ],
//     );
//   }
// }

// class NavigationControls extends StatelessWidget {
//   const NavigationControls(this._webViewControllerFuture);

//   final Future<WebViewController> _webViewControllerFuture;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WebViewController>(
//       future: _webViewControllerFuture,
//       builder:
//           (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
//         final bool webViewReady =
//             snapshot.connectionState == ConnectionState.done;
//         final WebViewController controller = snapshot.data!;
//         return Row(
//           children: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios),
//               onPressed: !webViewReady
//                   ? null
//                   : () async {
//                 if (await controller.canGoBack()) {
//                   controller.goBack();
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text('No back history item',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(fontSize: 11.sp)),
//                         backgroundColor: Color(0xFFE02020),
//                         behavior: SnackBarBehavior.fixed,
//                         duration: const Duration(seconds: 5),
//                         // duration: Duration(seconds: 3),
//                       ));
//                   return;
//                 }
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.arrow_forward_ios),
//               onPressed: !webViewReady
//                   ? null
//                   : () async {
//                 if (await controller.canGoForward()) {
//                   controller.goForward();
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text('No forward history item',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.montserrat(fontSize: 11.sp)),
//                         backgroundColor: Color(0xFFE02020),
//                         behavior: SnackBarBehavior.fixed,
//                         duration: const Duration(seconds: 5),
//                         // duration: Duration(seconds: 3),
//                       ));
                  
//                   return;
//                 }
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.replay),
//               onPressed: !webViewReady
//                   ? null
//                   : () {
//                 controller.reload();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }