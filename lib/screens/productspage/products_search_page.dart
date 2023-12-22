import 'package:flutter/material.dart';
import 'package:krishajdealer/screens/productspage/productdetailspage.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/cardwidget/custom_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  final String brand;
  final String technical;
  final String imageUrl;

  Product(
      {required this.brand, required this.technical, required this.imageUrl});
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  List<Product> products = [
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
    Product(
        brand: 'Kursor',
        technical: 'Thifluzamide 24% SC',
        imageUrl: 'assets/images/Direct.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
  }

  Future<void> loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('searchHistory') ?? [];
    });
  }

  Future<void> saveSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', recentSearches);
  }

  Future<void> clearSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('searchHistory');
    setState(() {
      recentSearches = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: AppColors.kAppBackground,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                // Add or remove 'Clear' button based on user input
              });
            },
            onSubmitted: (value) {
              if (value.isNotEmpty && !recentSearches.contains(value)) {
                setState(() {
                  recentSearches.insert(0, value);
                  if (recentSearches.length > 3) {
                    recentSearches.removeLast();
                  }
                });
                saveSearchHistory();
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade800,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey.shade500,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
              hintText: 'Search for products, brands, etc.',
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recentSearches.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Recent Searches',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      clearSearchHistory();
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        color: recentSearches.isNotEmpty
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            if (recentSearches.isNotEmpty) const SizedBox(height: 16),
            if (recentSearches.isNotEmpty)
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recentSearches.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = recentSearches[index];
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(recentSearches[index]),
                      ),
                    );
                  },
                ),
              ),
            if (recentSearches.isNotEmpty) const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'product-image-${products[index].brand}-$index',
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
          ],
        ),
      ),
    );
  }
}
