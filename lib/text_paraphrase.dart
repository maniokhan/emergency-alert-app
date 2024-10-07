import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TextParaphrasingPage extends StatefulWidget {
  const TextParaphrasingPage({super.key});

  @override
  _TextParaphrasingPageState createState() => _TextParaphrasingPageState();
}

class _TextParaphrasingPageState extends State<TextParaphrasingPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

 Future<void> paraphraseText(String text) async {
    final url = Uri.parse('https://api-inference.huggingface.co/models/t5-base');
    
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer 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', // Replace with your token
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'inputs': text,
        'options': {'wait_for_model': true},
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      // Extract the paraphrased text from the response
      setState(() {
        _result = data[0]['generated_text'].trim();
      });
      print("Given Text Input: ${_controller.text}");
      print("Output Text: $_result");
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
        title: Text('AI Text Paraphraser'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Enter text to paraphrase'),
                maxLines: 5, // Allow multiple lines for input
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  paraphraseText(_controller.text);
                },
                child: Text('Paraphrase Text'),
              ),
              SizedBox(height: 16),
              Text('Result: $_result'),
            ],
          ),
        ),
      ),
    );
  }
}


