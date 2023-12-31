// import 'package:flutter/material.dart';

// class CardWidget extends StatelessWidget {
//   final String text;
//   final String imageUrl;
//   final String subtitle;

//   const CardWidget(this.text, this.imageUrl, this.subtitle, {Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4, right: 4, left: 4, top: 4),
//       child: Container(
//         width: 170,
//         height: 170,
//         padding: const EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(12.5),
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(4, 4),
//               blurRadius: 1,
//               spreadRadius: 2,
//               color: Colors.green.withOpacity(.40),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Image.network(imageUrl, height: 70, fit: BoxFit.cover),
//             Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             // const SizedBox(height: 8),
//             Text(
//               subtitle,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontWeight: FontWeight.normal,
//                 fontSize: 12,
//               ),
//             ),
//             // const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class Card extends StatelessWidget {
//   final String text;
//   final String imageUrl;
//   final String subtitle;

//   const Card(this.text, this.imageUrl, this.subtitle, {Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15, right: 15),
//       child: Container(
//         width: 150,
//         height: 150,
//         padding: const EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.5),
//           border: Border.all(color: Colors.grey),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(10, 20),
//                 blurRadius: 10,
//                 spreadRadius: 0,
//                 color: Colors.grey.withOpacity(.05)),
//           ],
//         ),
//         child: Column(
//           children: [
//             Image.asset(imageUrl, height: 70, fit: BoxFit.cover),
//             const Spacer(),
//             Text(text,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 )),
//             const SizedBox(
//               height: 5,
//             ),
//             Text(
//               subtitle,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.normal,
//                   fontSize: 12),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;

  const CardWidget(this.text, this.imageUrl, this.subtitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, right: 4, left: 4, top: 4),
      child: Container(
        width: 170,
        height: 170,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 1,
              spreadRadius: 2,
              color: Colors.grey.withOpacity(.05),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 70,
                    fit: BoxFit.cover,
                  )
                : Shimmer.fromColors(
                    baseColor:
                        Colors.green[300]!, // Change to your desired base color
                    highlightColor: Colors.green[100]!,
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                  ),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
