import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoForm extends StatefulWidget {
  const VideoForm({super.key});

  @override
  State<VideoForm> createState() => _VideoFormState();
}
/** 
class _VideoFormState extends State<VideoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _youtubeUrlController = TextEditingController();

  bool _isLoading = false;

  Future<void> _saveVideo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final url = Uri.parse('http://localhost:5000/api/videos');
      final body = jsonEncode({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': double.tryParse(_priceController.text) ?? 0.0,
        'imageUrl': _imageUrlController.text,
        'youtubeUrl': _youtubeUrlController.text,
      });
      print("body $body");
      print("url $url");
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
       // print("response ${response[acknowledged]}");
         // if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          print("successs ");
       // if(response.statusCode){
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context, rootNavigator: true).showSnackBar(
            const SnackBar(content: Text('Video saved successfully!')),
          );
          _formKey.currentState!.reset();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save video: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Enter title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) => value == null || value.isEmpty ? 'Enter image URL' : null,
              ),
              TextFormField(
                controller: _youtubeUrlController,
                decoration: const InputDecoration(labelText: 'YouTube URL'),
                validator: (value) => value == null || value.isEmpty ? 'Enter YouTube URL' : null,
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveVideo,
                      child: const Text('Save Video'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
class _VideoFormState extends State<VideoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _youtubeUrlController = TextEditingController();

  bool _isLoading = false;
  String? _message; // Add this line

  Future<void> _saveVideo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _message = null; // Clear previous message
      });
      final url = Uri.parse('http://localhost:5000/api/videos');
      final body = jsonEncode({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': double.tryParse(_priceController.text) ?? 0.0,
        'imageUrl': _imageUrlController.text,
        'youtubeUrl': _youtubeUrlController.text,
      });
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          setState(() {
            _message = 'Video saved successfully!';
          });
          _formKey.currentState!.reset();
        } else {
          setState(() {
            _message = 'Failed to save video: ${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          _message = 'Error: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_message != null) // Show message if present
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    _message!,
                    style: TextStyle(
                      color: _message == 'Video saved successfully!' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Enter title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) => value == null || value.isEmpty ? 'Enter image URL' : null,
              ),
              TextFormField(
                controller: _youtubeUrlController,
                decoration: const InputDecoration(labelText: 'YouTube URL'),
                validator: (value) => value == null || value.isEmpty ? 'Enter YouTube URL' : null,
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveVideo,
                      child: const Text('Save Video'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}