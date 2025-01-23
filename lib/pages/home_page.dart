// // import 'package:flutter/material.dart';
// // import 'package:test_task/components/product_card.dart';

// // class HomePage extends StatelessWidget {
// //   const HomePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Home'),
// //       ),
// //       body: Row(
// //         children: [
// //           ProductCard(
// //             name: 'Bag',
// //             description: "Cool bag",
// //             price: 3.40,
// //             imagePath: 'assets/bag.jpeg',
// //           ),
// //           ProductCard(
// //             name: 'Bag',
// //             description: "Cool bag",
// //             price: 3.40,
// //             imagePath: 'assets/bag.jpeg',
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:test_task/components/my_button.dart';
// import 'package:test_task/components/product_card.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final List<Map<String, dynamic>> _products = [
//     {
//       'image': 'assets/mug.png',
//       'name': 'Mug',
//       'description':
//           'A durable ceramic mug, perfect for coffee, tea, or any hot beverage',
//       'price': 9.99,
//     },
//     {
//       'image': 'assets/bag.jpeg',
//       'name': 'Purse',
//       'description':
//           'A stylish and compact leather purse for everyday essentials',
//       'price': 49.99,
//     },
//     {
//       'image': 'assets/tshirt.jpg',
//       'name': 'T-SHirt',
//       'description':
//           'Soft, breathable cotton T-shirt available in multiple colors and sizes.',
//       'price': 39.99,
//     },
//     {
//       'image': 'assets/hat.png',
//       'name': 'Baseball Cap',
//       'description': 'A comfortable and adjustable cap for outdoor activities',
//       'price': 19.99,
//     },
//   ];

//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _filteredProducts = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredProducts = _products;
//   }

//   void _filterProducts(String query) {
//     setState(() {
//       _filteredProducts = _products
//           .where((product) =>
//               product['name'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   void _showAddProductPopup() {
//     String image = 'assets/default.png';
//     String name = '';
//     String description = '';
//     double price = 0.0;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add Product'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Product Name'),
//                   onChanged: (value) => name = value,
//                 ),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   onChanged: (value) => description = value,
//                 ),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Price'),
//                   keyboardType: TextInputType.number,
//                   onChanged: (value) => price = double.tryParse(value) ?? 0.0,
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             MyButton(onTap: () => Navigator.of(context).pop(), text: 'Cancel'),
//             SizedBox(
//               height: 8,
//             ),
//             MyButton(
//                 onTap: () {
//                   setState(() {
//                     _products.add({
//                       'image': image,
//                       'name': name,
//                       'description': description,
//                       'price': price,
//                     });
//                     _filteredProducts = _products;
//                   });
//                   Navigator.of(context).pop();
//                 },
//                 text: 'Add'),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onChanged: _filterProducts,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Products',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 MyButton(onTap: _showAddProductPopup, text: '+ Add Product'),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                 ),
//                 itemCount: _filteredProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = _filteredProducts[index];
//                   return ProductCard(
//                     image: product['image'],
//                     name: product['name'],
//                     description: product['description'],
//                     price: product['price'],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_task/components/my_button.dart';
import 'package:test_task/components/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products from Firestore
  }

  Future<void> _fetchProducts() async {
    if (userId == null) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('products')
        .snapshots()
        .listen((snapshot) {
      final List<Map<String, dynamic>> fetchedProducts =
          snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();

      setState(() {
        _products = fetchedProducts;
        _filteredProducts = fetchedProducts;
      });
    });
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) => product['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showAddProductPopup() {
    String image = 'assets/default.png';
    String name = '';
    String description = '';
    double price = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (value) => description = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                ),
              ],
            ),
          ),
          actions: [
            MyButton(onTap: () => Navigator.of(context).pop(), text: 'Cancel'),
            const SizedBox(height: 8),
            MyButton(
              onTap: () {
                _addProductToFirestore(name, description, price, image);
                Navigator.of(context).pop();
              },
              text: 'Add',
            ),
          ],
        );
      },
    );
  }

  Future<void> _addProductToFirestore(
      String name, String description, double price, String image) async {
    if (userId == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('products')
        .add({
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: _filterProducts,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyButton(onTap: _showAddProductPopup, text: '+ Add Product'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(
                      child: Text('No products found'),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return ProductCard(
                          image: product['image'],
                          name: product['name'],
                          description: product['description'],
                          price: product['price'],
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
