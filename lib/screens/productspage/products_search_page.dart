import 'package:flutter/material.dart';
import 'package:krishajdealer/providers/productProvider/allproducts.dart';
import 'package:krishajdealer/screens/productspage/productdetailspage.dart';
import 'package:krishajdealer/services/api/peoducts_api_responce_model.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/cardwidget/custom_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum SearchPageState {
  Loading,
  Data,
  Error,
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  List<ProductItem> products = [];
  final AllProductViewProvider _productProvider = AllProductViewProvider();
  SearchPageState _pageState = SearchPageState.Loading;
  List<String> filteredProductNames = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    loadSearchHistory();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadProducts() async {
    try {
      setState(() {
        _pageState = SearchPageState.Loading;
      });

      ApiResponseModelProducts response =
          await _productProvider.getProducts(context);

      setState(() {
        products = response.products;
        _pageState = SearchPageState.Data;
      });
    } catch (e) {
      setState(() {
        _pageState = SearchPageState.Error;
      });
    }
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    filteredProductNames = products
        .where((product) =>
            product.productName.toLowerCase().contains(query))
        .map((product) => product.productName)
        .toList();

    setState(() {});
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
    switch (_pageState) {
      case SearchPageState.Loading:
        return _buildLoadingState();
      case SearchPageState.Data:
        return _buildDataState();
      case SearchPageState.Error:
        return _buildErrorState();
    }
  }

  Widget _buildLoadingState() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildDataState() {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreen.withOpacity(0.5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        toolbarHeight: 60,
        elevation: 0,
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (recentSearches.isNotEmpty) ...[
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
                    const SizedBox(height: 8),
                  ],
                ]),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (filteredProductNames.isEmpty) {
                    return ListTile(
                      title: Text('No products found with this name.'),
                    );
                  }

                  return ListTile(
                    title: Text(filteredProductNames[index]),
                    onTap: () {
                      _searchController.text = filteredProductNames[index];
                      // You can navigate or perform any other action here
                    },
                  );
                },
                childCount: filteredProductNames.length,
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
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
                          'product-image-${products[index].productName}-$index-${products[index].id}',
                      child: CardWidget(
                        products[index].productName,
                        products[index].productImageUrl,
                        products[index].userId,
                      ),
                    ),
                  );
                },
                childCount: products.length,
              ),
            ),
          ],
        ),
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
}
