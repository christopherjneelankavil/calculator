import 'package:calculator/buttons_list.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1="";
  String operator="";
  String number2="";
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //o/p
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child:  Text(

                    "$number1$operator$number2".isEmpty?
                    "0":
                    "$number1$operator$number2",


                    style:const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            //i/p
            Wrap(
              children: Btn.btnVal
                  .map(
                    (val) => SizedBox(
                      width: val == Btn.num0
                          ? (screenSize.width / 2)
                          : (screenSize.width / 4),
                      height: screenSize.width / 5,
                      child: buildBtn(val),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBtn(val) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color: btnColor(val),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white30),
          borderRadius: BorderRadius.circular(90),
        ),
        child: InkWell(
          onTap: () => findVal(val),
          child: Center(
            child: Text(
              val,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color btnColor(val) {
    return [Btn.delete, Btn.clear, Btn.ans].contains(val)
        ? Colors.blueGrey
        : [Btn.add, Btn.subtract, Btn.multiply, Btn.divide, Btn.percent]
                .contains(val)
            ? Colors.orange
            : Colors.black87;
  }


  void findVal(String val){

    if(val!=Btn.dec&&int.tryParse(val)==null){
      if(operator.isNotEmpty && number2.isNotEmpty){

      }
      operator=val;
    }
    else if(number1.isEmpty || operator.isEmpty){

      if(val==Btn.dec && number1.contains(Btn.dec)){
        return;
      }
      if(val==Btn.dec && (number1.isEmpty || number1==Btn.num0)){
        val="0.";
      }
      number1+=val;

    }
    else if(number2.isEmpty || operator.isNotEmpty){

      if(val==Btn.dec && number2.contains(Btn.dec)){
        return;
      }
      if(val==Btn.dec && (number2.isEmpty || number2==Btn.num0)){
        val="0.";
      }
      number2+=val;

    }

    setState(() {
      number1+=val;
      operator+=val;
      number2+=val;
    });
  }
}
