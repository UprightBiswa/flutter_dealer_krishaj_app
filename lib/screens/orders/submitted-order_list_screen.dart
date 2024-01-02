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
import 'package:krishajdealer/screens/productspage/productdetailspage.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/utils/assets.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/cardwidget/custom_card_widget.dart';
import 'package:krishajdealer/widgets/search_product/search_button.dart';

class SubmittedOrderListScreen extends StatelessWidget {
  const SubmittedOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products4 = [
      Product(
        id: 18,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 19,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 20,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 21,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 22,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 23,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 24,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 25,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
    ];
    List<Product> products2 = [
      Product(
        id: 40,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 45,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 46,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 47,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 48,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
      Product(
        id: 49,
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg',
        price: 19.99, // Replace with the actual price for this product
      ),
    ];
    return Scaffold(
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
                CardListView(products: products4),
                SHeadline(),
                CardListView(products: products2),
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
    return GestureDetector(
      onTap: () {
        // Navigate to the new page when pressed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SearchPage(), // Replace with the actual new page widget
          ),
        );
      },
      child: Padding(
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
      ),
    );
  }
}

class Headline extends StatelessWidget {
  const Headline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
        GestureDetector(
          onTap: () {
            // Navigate to the search page when "View More" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          },
          child: Text(
            "View More",
            style: TextStyle(
              color: Color(0xff15BE77),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

class SHeadline extends StatelessWidget {
  const SHeadline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Navigate to the search page when "View More" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          },
          child: Text(
            "View More",
            style: TextStyle(
              color: Color(0xff15BE77),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

// class CardListView extends StatelessWidget {
//   const CardListView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: 175,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: const [
//             CardWidget("Direct", "assets/images/Direct.jpg",
//                 "Cymoxanil 8% + Mancozeb 64% WP"),
//             CardWidget("Kursor ", "assets/images/Koup01.png", "thifluzamide 24% SC"),
//             CardWidget("Kure", "assets/images/PRIVINTAL-BV.png",
//                 "Tebuconazole 25.9% EC"),
//           ],
//         ),
//       ),
//     );
//   }
// }
class CardListView extends StatelessWidget {
  final List<Product> products;

  const CardListView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 175,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(
                      product: products[index],
                      index: index,
                    ),
                  ),
                );
              },
              child: Hero(
                tag:
                    'product-image-${products[index].brand}-$index-${products[index].id}',
                child: CardWidget(
                  products[index].brand,
                  products[index].imageUrl,
                  products[index].technical,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
