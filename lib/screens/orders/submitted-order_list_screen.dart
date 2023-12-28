// import 'package:flutter/material.dart';
// import 'package:krishajdealer/screens/sidebar/sidebar_drawer.dart';
// class SubmittedOrderListScreen extends StatelessWidget {
//   const SubmittedOrderListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Submitted Order List')),
//       drawer: const DrawerWidget(  ),
//       body: const Center(child: Text('Submitted Order List Screen')),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:krishajdealer/utils/assets.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/search_product/search_button.dart';

class SubmittedOrderListScreen extends StatelessWidget {
  const SubmittedOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.kAppBackground,
        // appBar: AppBar(title: const Text(' Order Page')),
        // drawer: const DrawerWidget(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                TopBar(),
                SearchButton(),
                BannerCard(),
                // PromoCard(),
                Headline(),
                CardListView(),
                SHeadline(),
                CardListView(),
              ],
            ),
          ),
        ));
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Find your Products",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.25)),
          ]),
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.agriculture,
              size: 25,
              color: Color(0xff53E88B),
            ),
          ),
        )
      ],
    );
  }
}



class BannerCard extends StatelessWidget {
  const BannerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(AppAssets.banner),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class Headline extends StatelessWidget {
  const Headline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fungicides",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            // Text(
            //   "The best P close to you",
            //   style: TextStyle(
            //       color: Colors.grey,
            //       fontSize: 12,
            //       fontWeight: FontWeight.normal),
            // ),
          ],
        ),
        Text(
          "View More",
          style: TextStyle(
              color: Color(0xff15BE77), fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class SHeadline extends StatelessWidget {
  const SHeadline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular Menu",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            // Text(
            //   "The best food for you",
            //   style: TextStyle(
            //       color: Colors.grey,
            //       fontSize: 12,
            //       fontWeight: FontWeight.normal),
            // ),
          ],
        ),
        Text(
          "View More",
          style: TextStyle(
              color: Color(0xff15BE77), fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class CardListView extends StatelessWidget {
  const CardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 175,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            Card("Direct", "assets/images/Direct.jpg",
                "Cymoxanil 8% + Mancozeb 64% WP"),
            Card("Kursor ", "assets/images/Koup01.png", "thifluzamide 24% SC"),
            Card("Kure", "assets/images/PRIVINTAL-BV.png",
                "Tebuconazole 25.9% EC"),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;

  const Card(this.text, this.imageUrl, this.subtitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 15),
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          border: Border.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imageUrl, height: 70, fit: BoxFit.cover),
            const Spacer(),
            Text(text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
