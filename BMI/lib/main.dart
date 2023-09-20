import 'dart:ffi';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aladhami Week4'),
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
  final TextEditingController _weightController = TextEditingController();
  List<int> feet = [4, 5, 6, 7];
  List<int> inches = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  int selectNumber = 4;
  int numberSelected = 1;
  int weightloss = 0;

  void _handleSubmit() {
    setState(() {
      weightloss = int.tryParse(_weightController.text) ?? 0;
      if (weightloss < 1) {
        final snackBar = SnackBar(
          content: Text("The amount should be more than Zero"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      CalculateBMI calculateBMI =
          CalculateBMI(selectNumber, numberSelected, weightloss);
      var sum = calculateBMI.CalculateWeight().truncate();
      //double sum = CalculateBMI.CalculateWeight();
      final snackBar = SnackBar(
        content: Text("Your BMI is: $sum"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text('BMI Calculator',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Weight"),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                DropdownButton<int>(
                  value: selectNumber,
                  onChanged: (int? newValue) {
                    setState(() {
                      if (newValue != null) {
                        selectNumber = newValue;
                      }
                    });
                  },
                  items: feet.map<DropdownMenuItem<int>>((menuItem) {
                    return DropdownMenuItem<int>(
                        value: menuItem, child: Text(menuItem.toString()));
                  }).toList(),
                ),
                const Text("Feet"),
                SizedBox(
                  width: 20,
                ),
                DropdownButton(
                  value: numberSelected,
                  onChanged: (int? newestValue) {
                    setState(() {
                      if (newestValue != null) {
                        numberSelected = newestValue;
                      }
                    });
                  },
                  items: inches.map<DropdownMenuItem<int>>((menuItem) {
                    return DropdownMenuItem<int>(
                        value: menuItem, child: Text(menuItem.toString()));
                  }).toList(),
                ),
                const Text("Inches"),
              ],
            ),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculateBMI {
  int feet;
  int inches;
  int weightloss;
  CalculateBMI(this.feet, this.inches, this.weightloss);

  double CalculateWeight() {
    double sum;
    int number = 703;

    sum = number *
        (weightloss / (((feet * 12) + inches) * ((feet * 12) + inches)));

    return sum;
  }
}
