import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ഒരു അൽകുൽത്ത് നോമ്പോറ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CalculatorPage(),
      },
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '0';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '0';
      } else if (buttonText == '=') {
        try {
          _result = _calculate(_expression);
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  String _calculate(String expression) {
    try {
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(20.0),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ഒരു അൽകുൽത്ത് നോമ്പോറ'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 24.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('÷', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('×', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('C', color: Colors.red),
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('+', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('=', color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
