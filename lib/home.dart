import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lottie/lottie.dart';
import 'package:wheel_of_names/constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isEntriesSelected = true;
  final TextEditingController _nameController = TextEditingController(
      text: "Ali\nHusnain\nUsman\nFarhan\nNoman"); // Default names
  List<String> entries = [];
  String winner = '';
  final StreamController<int> _selectedController = StreamController<int>();
  final List<Color> colors = [
    const Color(0xFF4CB050),
    const Color(0xFF009788),
    const Color(0xFF00BCD5),
    const Color(0xFF02AAF5),
    const Color(0xFF2196F3),
    const Color(0xFF3F51B5),
    const Color(0xFF693BB8),
    const Color(0xFF9C28B1),
    const Color(0xFFEA1E63),
    const Color(0xFFF44236),
    const Color(0xFFFF5823),
    const Color(0xFFFF9700),
    const Color(0xFFFEC107),
    const Color(0xFFDBC400),
    const Color(0xFFCCDC33),
    const Color(0xFF89C34A)
  ];

  @override
  void initState() {
    super.initState();
    _updateEntriesFromController(); // Initialize entries from default text
  }

  void toggleSelection(bool isEntries) {
    setState(() {
      isEntriesSelected = isEntries;
    });
  }

  void _updateEntriesFromController() {
    setState(() {
      entries = _nameController.text
          .split('\n')
          .where((name) => name.isNotEmpty)
          .toList();
    });
  }

  void addEntry(String name) {
    if (name.isNotEmpty) {
      setState(() {
        entries.add(name);
        _nameController.clear(); // Clear input after adding
      });
    }
  }

  void _spinWheel() {
    _updateEntriesFromController(); // Ensure latest entries are updated
    if (entries.isNotEmpty) {
      final selectedIndex = Random().nextInt(entries.length);
      _selectedController.add(selectedIndex); // Random spin selection

      // Show winner dialog after a delay to simulate the spin duration
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          winner = entries[selectedIndex];
          isEntriesSelected = false; // Switch to Result view
        });
        _showWinnerDialog();
      });
    }
  }

  void _showWinnerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: AppColors.darkColor, width: 3)
            ),
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LottieBuilder.asset(
                  "assets/lottie/done.json",
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 21,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "The Winner is $winner!",
                  style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 15,
                      color: AppColors.darkColor),
                ),
                const SizedBox(
                  height: 3,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.darkColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.lightColor)),
                    child: const Center(
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RubikMedium',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01)
              ],
            ),
          ),
        );
      },
    );
  }

  void resetController() {
    setState(() {
      // Reset the name controller to the default value
      _nameController.text =
          "Ali\nHusnain\nUsman\nFarhan\nNoman"; // Default names

      // Reset entries to default
      entries = _nameController.text
          .split('\n')
          .where((name) => name.isNotEmpty)
          .toList();

      // Reset winner to empty
      winner = '';

      // Reset to show the Entries tab
      isEntriesSelected = true;
    });
  }

  @override
  void dispose() {
    _selectedController.close();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: mq.height * 0.04),
              Container(
                constraints: const BoxConstraints(maxWidth: 700),
                height: mq.height * 0.08,
                width: mq.width * 0.95,
                decoration: BoxDecoration(
                  color: AppColors.darkColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const Text(
                      "WHEEL OF NAMES",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // s
                  ],
                ),
              ),
              SizedBox(height: mq.height * 0.01),
              nameContainer(),
              SizedBox(height: mq.height * 0.01),
              resetButton(),
              SizedBox(height: mq.height * 0.01),
              spinner()
            ],
          ),
        ),
      ),
    );
  }

  Widget resetButton() {
    final mq = MediaQuery.of(context).size;
    return InkWell(
      onTap: resetController,
      child: Container(
        height: mq.height * 0.055,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.darkColor,
            borderRadius: BorderRadius.circular(40)),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Reset",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget spinner() {
    final mq = MediaQuery.of(context).size;
    return SizedBox(
      height: mq.height * 0.4, // Fixed height for the wheel container
      child: Stack(
        alignment: Alignment.center,
        children: [
          FortuneWheel(
            // styleStrategy: FortuneBar.kDefaultStyleStrategy,
            animateFirst: false,
            physics: DirectionalPanPhysics.horizontal(),
            selected: _selectedController.stream,
            items: [
              for (int i = 0; i < entries.length; i++)
                FortuneItem(
                  child: Text(
                    entries[i],
                    style: const TextStyle(fontFamily: 'Rubik'),
                  ),
                  style: FortuneItemStyle(
                    color: colors[i % colors.length], // Assign color
                    borderColor: Colors.white.withOpacity(0),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          ElevatedButton(
            onPressed: _spinWheel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20), // Make the button big enough
            ),
            child: const Text(
              "Spin",
              style: TextStyle(
                  fontFamily: 'RubikMedium',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameContainer() {
    final mq = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => toggleSelection(true),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                height: mq.height * 0.05,
                width: 80,
                decoration: BoxDecoration(
                  color: isEntriesSelected
                      ? AppColors.darkColor
                      : AppColors.lightColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Entries",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: isEntriesSelected
                          ? AppColors.lightColor
                          : AppColors.darkColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => toggleSelection(false),
              child: Container(
                height: mq.height * 0.05,
                width: 80,
                decoration: BoxDecoration(
                  color: !isEntriesSelected
                      ? AppColors.darkColor
                      : AppColors.lightColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Result",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: !isEntriesSelected
                          ? AppColors.lightColor
                          : AppColors.darkColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        Container(
          height: mq.height * 0.3,
          width: mq.width * 0.95,
          decoration: const BoxDecoration(
            color: AppColors.darkColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.lightColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isEntriesSelected
                    ? TextField(
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                        ),
                        controller: _nameController,
                        maxLines: null,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          _updateEntriesFromController();
                        },
                      )
                    : Center(
                        child: Text(
                          winner.isNotEmpty
                              ? "Winner: $winner"
                              : "No winner yet",
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            color: AppColors.darkColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
