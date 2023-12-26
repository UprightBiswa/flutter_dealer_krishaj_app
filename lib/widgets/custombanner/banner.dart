// class PromoCard extends StatelessWidget {
//   const PromoCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 150,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: const LinearGradient(
//                 colors: [Color(0xff53E88B), Color(0xff15BE77)])),
//         child: Stack(
//           children: [
//             Opacity(
//               opacity: .5,
//               child: Image.asset(AppAssets.banner1, fit: BoxFit.cover),
//             ),
//             Image.asset(AppAssets.banner2),
//             const Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: EdgeInsets.all(25.0),
//                 child: Text(
//                   "Crop Protection",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }