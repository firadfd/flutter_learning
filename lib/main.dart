import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  StreamController<int> streamController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count++;
          streamController.sink.add(count);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data.toString());
              }else{
                return const Text('No data');
              }
            }),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function(String)? onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!(text);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class CustomTextInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final Icon? prefixIcon;

  const CustomTextInputField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomTextInputFieldState createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  bool _obscureText = true; // Controls whether the text is hidden or visible

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
