import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => VideoShopData(),
      child: const VideoShopApp(),
    ),
  );
}

class VideoShopData extends ChangeNotifier {
  final List<Video> _videos = [
    Video(
      title: 'Flutter UI Masterclass',
      description: 'Learn to build beautiful UIs with Flutter.',
      price: 19.99,
      imageUrl: 'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    ),
    Video(
      title: 'Dart Programming for Beginners',
      description: 'Get started with Dart and Flutter development.',
      price: 9.99,
      imageUrl: 'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    ),
    Video(
      title: 'State Management in Flutter',
      description: 'Explore different state management solutions in Flutter.',
      price: 24.99,
      imageUrl: 'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    ),
  ];

  List<Video> get videos => _videos;

  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Video video) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.video.title == video.title);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity++;
    } else {
      _cartItems.add(CartItem(video: video, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  double get cartTotal {
    double total = 0;
    for (var item in _cartItems) {
      total += item.video.price * item.quantity;
    }
    return total;
  }

  void checkout() {
    // Simulate checkout process
    _cartItems.clear();
    notifyListeners();
  }
}

class Video {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String youtubeUrl;

  Video({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.youtubeUrl,
  });
}

class CartItem {
  final Video video;
  int quantity;

  CartItem({required this.video, required this.quantity});
}

class VideoShopApp extends StatelessWidget {
  const VideoShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VideoListScreen(),
    );
  }
}

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoShopData = Provider.of<VideoShopData>(context);
    final videos = videoShopData.videos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return VideoCard(video: video);
        },
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    final videoShopData = Provider.of<VideoShopData>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              video.imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Text(
              video.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(video.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${video.price.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    videoShopData.addToCart(video);
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                final Uri url = Uri.parse(video.youtubeUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch video')),
                  );
                }
              },
              child: const Text('Watch on YouTube'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoShopData = Provider.of<VideoShopData>(context);
    final cartItems = videoShopData.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemCard(item: item);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: \$${videoShopData.cartTotal.toStringAsFixed(2)}'),
                      ElevatedButton(
                        onPressed: () {
                          videoShopData.checkout();
                          Navigator.pop(context);
                        },
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({Key? key, required this.item}) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final videoShopData = Provider.of<VideoShopData>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              item.video.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.video.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('\$${item.video.price.toStringAsFixed(2)}'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          videoShopData.decreaseQuantity(item);
                        },
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          videoShopData.increaseQuantity(item);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                videoShopData.removeFromCart(item);
              },
            ),
          ],
        ),
      ),
    );
  }
}