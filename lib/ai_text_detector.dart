import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TextDetectionPage extends StatefulWidget {
  @override
  _TextDetectionPageState createState() => _TextDetectionPageState();
}

class _TextDetectionPageState extends State<TextDetectionPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  Future<void> detectAI(String text) async {
    final url = Uri.parse(
        'https://api-inference.huggingface.co/models/distilbert-base-uncased-finetuned-sst-2-english');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer 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',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'inputs': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      // Extract the highest scored label
      var highestScore = -1.0;
      var bestLabel = '';

      for (var item in data[0]) {
        if (item['score'] > highestScore) {
          highestScore = item['score'];
          bestLabel = item['label'];
        }
      }

      setState(() {
        _result = bestLabel;
      });
    } else {
      print('Error: ${response.statusCode} : Error ${response.body}');
      setState(() {
        _result = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Text Detection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                detectAI(_controller.text);
              },
              child: Text('Detect AI'),
            ),
            SizedBox(height: 16),
            Text('Result: $_result'),
          ],
        ),
      ),
    );
  }
}
