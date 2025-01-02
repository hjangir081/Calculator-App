import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double num1 = 0.0;
  double num2 = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var outputSize = 32.0;

  onButtonClickedValue(value){
    if(value == 'AC'){
      input = '';
      output = '';
    }else if(value == 'A'){
      if(input.isNotEmpty){
        input = input.substring(0, input.length -1);
      }
    }else if(value == '='){
      if(input.isNotEmpty){
        var userInput = input;
        userInput = input.replaceAll("", "");
        Parser P = Parser();
        Expression expression = P.parse(userInput);
        ContextModel contextModel = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, contextModel);
        output = finalValue.toString();
        if(output.endsWith('.0')){
          output = output.substring(0, output.length -2);
        }
      }
    }else{
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    output.isNotEmpty ? '=$output' : '',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      button('AC', Colors.amber, Colors.blue),
                      button('A', Colors.amber, Colors.blue),
                      button('', Colors.amber, Colors.blue),
                      button('/', Colors.amber, Colors.blue),
                    ],
                  ),
                  Row(
                    children: [
                      button('7', Colors.white, Colors.blue),
                      button('9', Colors.white, Colors.blue),
                      button('9', Colors.white, Colors.blue),
                      button('*', Colors.amber, Colors.blue),
                    ],
                  ),
                  Row(
                    children: [
                      button('6', Colors.white, Colors.blue),
                      button('5', Colors.white, Colors.blue),
                      button('4', Colors.white, Colors.blue),
                      button('-', Colors.amber, Colors.blue),
                    ],
                  ),
                  Row(
                    children: [
                      button('3', Colors.white, Colors.blue),
                      button('2', Colors.white, Colors.blue),
                      button('1', Colors.white, Colors.blue),
                      button('+', Colors.amber, Colors.blue),
                    ],
                  ),
                  Row(
                    children: [
                      button('%', Colors.amber, Colors.blue),
                      button('0', Colors.white, Colors.blue),
                      button('.', Colors.amber, Colors.blue),
                      button('=', Colors.amber, Colors.blue),
                    ],
                  ),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }

  button(text, textColor, color){
    return Expanded(child:
    Container(

      padding: EdgeInsets.all(MediaQuery.of(context).size.width*.02),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width*.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          foregroundColor: color
        ),
          onPressed: (){onButtonClickedValue(text);},
          child: Text(
              text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: textColor),
          )
      ),
    ));
  }

}
