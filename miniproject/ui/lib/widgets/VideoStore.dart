import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ui/widgets/Login.dart';
import 'package:ui/widgets/VideoForm.dart';

void main(){
  runApp(const VideoStore());
}

class VideoStore extends StatelessWidget{
  const VideoStore({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(title: 'Video Store');
  }
  }
/** 
  class VideoStoreScreen extends StatelessWidget {
  final VoidCallback onLogout;
  const VideoStoreScreen({super.key, required this.onLogout});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // This will remove all previous routes and show LoginScreen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VideoForm()),
            );
          },
          child: const Text('Video Form'),
        ),
      ),
    );
  }
}
*/

class VideoStoreScreen extends StatefulWidget {
  final VoidCallback onLogout;
  const VideoStoreScreen({super.key, required this.onLogout});

  @override
  State<VideoStoreScreen> createState() => _VideoStoreScreenState();
}
/**
class _VideoStoreScreenState extends State<VideoStoreScreen> {
  late Future<List<dynamic>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = fetchVideos();
  }

  Future<List<dynamic>> fetchVideos() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/videos'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VideoForm()),
                );
              },
              child: const Text('Video Form'),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _videosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No videos found.'));
                }
                final videos = snapshot.data!;
                return ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    /**
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: video['imageUrl'] != null && video['imageUrl'].toString().isNotEmpty
                            ? Image.network(video['imageUrl'], width: 60, height: 60, fit: BoxFit.cover)
                            : const Icon(Icons.video_library, size: 60),
                        title: Text(video['title'] ?? 'No Title'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(video['description'] ?? ''),
                            Text('Price: ₹${video['price'] ?? ''}'),
                            Text('YouTube: ${video['youtubeUrl'] ?? ''}'),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  */
                return Card(
  margin: const EdgeInsets.all(8),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: video['imageUrl'] != null && video['imageUrl'].toString().isNotEmpty
              ? Image.network(video['imageUrl'], width: 60, height: 60, fit: BoxFit.cover)
              : const Icon(Icons.video_library, size: 60),
          title: Text(video['title'] ?? 'No Title'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(video['description'] ?? ''),
              Text('Price: ₹${video['price'] ?? ''}'),
              Text('YouTube: ${video['youtubeUrl'] ?? ''}'),
            ],
          ),
          isThreeLine: true,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              // Add your add-to-cart logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${video['title']} added to cart!')),
              );
            },
            child: const Text('Add To Cart'),
          ),
        ),
      ],
    ),
  ),
);



                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/

class _VideoStoreScreenState extends State<VideoStoreScreen> {
  late Future<List<dynamic>> _videosFuture;
  final List<dynamic> _cart = []; // Cart list

  @override
  void initState() {
    super.initState();
    _videosFuture = fetchVideos();
  }

  Future<List<dynamic>> fetchVideos() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/videos'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load videos');
    }
  }

  void _addToCart(dynamic video) {
    setState(() {
      _cart.add(video);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${video['title']} added to cart!')),
    );
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        if (_cart.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('Cart is empty')),
          );
        }
        return ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            final video = _cart[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: video['imageUrl'] != null && video['imageUrl'].toString().isNotEmpty
                    ? Image.network(video['imageUrl'], width: 60, height: 60, fit: BoxFit.cover)
                    : const Icon(Icons.video_library, size: 60),
                title: Text(video['title'] ?? 'No Title'),
                subtitle: Text('Price: ₹${video['price'] ?? ''}'),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'View Cart',
            onPressed: _showCart,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VideoForm()),
                );
              },
              child: const Text('Video Form'),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _videosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No videos found.'));
                }
                final videos = snapshot.data!;
                return ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: video['imageUrl'] != null && video['imageUrl'].toString().isNotEmpty
                                  ? Image.network(video['imageUrl'], width: 60, height: 60, fit: BoxFit.cover)
                                  : const Icon(Icons.video_library, size: 60),
                              title: Text(video['title'] ?? 'No Title'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(video['description'] ?? ''),
                                  Text('Price: ₹${video['price'] ?? ''}'),
                                  Text('YouTube: ${video['youtubeUrl'] ?? ''}'),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () => _addToCart(video),
                                child: const Text('Add To Cart'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}