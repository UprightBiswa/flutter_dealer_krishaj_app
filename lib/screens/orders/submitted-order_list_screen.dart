import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/productProvider/allproducts.dart';
import 'package:krishajdealer/screens/productspage/productdetailspage.dart';
import 'package:krishajdealer/screens/productspage/products_search_page.dart';
import 'package:krishajdealer/services/api/peoducts_api_responce_model.dart';
import 'package:krishajdealer/utils/assets.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/cardwidget/custom_card_widget.dart';
import 'package:krishajdealer/widgets/search_product/search_button.dart';

class SubmittedOrderListScreen extends StatefulWidget {
  const SubmittedOrderListScreen({Key? key}) : super(key: key);

  @override
  State<SubmittedOrderListScreen> createState() =>
      _SubmittedOrderListScreenState();
}

enum ProductOrderPageState {
  Loading,
  Data,
  Error,
}

class _SubmittedOrderListScreenState extends State<SubmittedOrderListScreen> {
  List<ProductItem> products = [];
  final AllProductViewProvider _productProvider = AllProductViewProvider();
  ProductOrderPageState _pageState = ProductOrderPageState.Loading;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      setState(() {
        _pageState = ProductOrderPageState.Loading;
      });

      ApiResponseModelProducts response =
          await _productProvider.getProducts(context);

      setState(() {
        products = response.products;
        _pageState = ProductOrderPageState.Data;
      });
    } catch (e) {
      setState(() {
        _pageState = ProductOrderPageState.Error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_pageState) {
      case ProductOrderPageState.Loading:
        return _buildLoadingState();
      case ProductOrderPageState.Data:
        return _buildDataState();
      case ProductOrderPageState.Error:
        return _buildErrorState();
      default:
        return _buildLoadingState(); // Handle the default case or remove this line
    }
  }

  Widget _buildLoadingState() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error occurred'),
            ElevatedButton(
              onPressed: _loadProducts,
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataState() {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TopBar(),
              SearchButton(),
              BannerCard(),
              Headline(),
              CardListView(products: products),
              SHeadline(),
              CardListView(products: products),
            ],
          ),
        ),
      ),
    );
  }

  Widget TopBar() {
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

  Widget BannerCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
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

  Widget Headline() {
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
          ],
        ),
        GestureDetector(
          onTap: () {
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

  Widget SHeadline() {
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

  Widget CardListView({required List<ProductItem> products}) {
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
              child: CardWidget(
                products[index].productName,
                products[index].productImageUrl,
                products[index].userId,
              ),
            );
          },
        ),
      ),
    );
  }
}
