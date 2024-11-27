import 'dart:async';
import 'dart:math';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:wheel_of_names/constant.dart';
import 'package:wheel_of_names/dialogs.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final ScrollController _scrollController = ScrollController();
  bool isEntriesSelected = true;
  bool _isSpinning = false; // Track spinning state
  final TextEditingController _nameController = TextEditingController(
      text: "Mitchell\nRoman\nPreston\nCooley\nMargaret"); // Default names
  List<String> entries = [];
  String winner = '';
  List<String> winners = [];
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
    if (_isSpinning) return; // Prevent multiple spins
    _updateEntriesFromController();

    // Ensure latest entries are updated
    if (entries.isNotEmpty) {
      setState(() {
        _isSpinning = true; // Disable the button
      });

      final selectedIndex = Random().nextInt(entries.length);
      _selectedController.add(selectedIndex); // Random spin selection

      // Show winner dialog after a delay to simulate the spin duration
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          winner = entries[selectedIndex];
          winners.add(winner);
          isEntriesSelected = false; // Switch to Result view
          _isSpinning = false; // Re-enable the button
        });
        AppDialogs().showWinnerDialog(context, winner);
        print(winners);
      });
    }
  }

  // void _playClickSound() {
  //   _audioPlayer.play(AssetSource("sound/click.wav"));
  // }
  void excludethewinner() {
    List<String> names = _nameController.text.split('\n');
    names.remove(winner);
    _nameController.text = names.join('\n');
    _updateEntriesFromController();
    setState(() {
      winner = '';
    });
  }

  void resetController() {
    setState(() {
      // Reset the name controller to the default value
      _nameController.text = ""; // Default names

      // Reset entries to default
      entries = [];

      isEntriesSelected = true;
    });
  }

  void resetWinner() {
    setState(() {
      // Reset the name controller to the default value
      winners.clear();
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
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            nameContainer(),
            SizedBox(height: mq.height * 0.02),
            spinner(),
            SizedBox(
              height: mq.height * 0.02,
            ),
            winner != ''
                ? InkWell(
                    focusColor: AppColors.darkColor,
                    splashColor: AppColors.darkColor,
                    hoverColor: AppColors.darkColor,
                    highlightColor: AppColors.darkColor,
                    overlayColor: MaterialStateProperty.all(
                      AppColors.darkColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    onTap: excludethewinner,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: Text(
                          "Exclude the Winner",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "RubikMedium",
                              // fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
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
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(0, 5),
                        blurRadius: 20)
                  ]),
                  child: FortuneWheel(
                    hapticImpact: HapticImpact.heavy,
                    // onFocusItemChanged: (index) {
                    //   // Play click sound each time an item crosses the endpoint
                    //   _playClickSound();
                    // },
                    indicators: const [
                      FortuneIndicator(child: SizedBox()),
                    ],
                    curve: FortuneCurve.spin,
                    animateFirst: false,
                    selected: _selectedController.stream,
                    items: [
                      if (entries.length > 1)
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
                          )
                      else if (entries.isEmpty)
                        for (int i = 0; i < 2; i++)
                          FortuneItem(
                            child: const Text(
                              " ", // Default text for the entry
                              style: TextStyle(fontFamily: 'Rubik'),
                            ),
                            style: FortuneItemStyle(
                              color: colors[0], // Default color
                              borderColor: Colors.white.withOpacity(0),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      else if (entries.length == 1)
                        for (int i = 0; i < 1; i++) ...[
                          FortuneItem(
                            child: Text(
                              entries[0], // The single entry
                              style: const TextStyle(fontFamily: 'Rubik'),
                            ),
                            style: FortuneItemStyle(
                              color:
                                  colors[0], // Assign color to the single entry
                              borderColor: Colors.white.withOpacity(0),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FortuneItem(
                            child: const Text(
                              " ", // The second item is blank
                              style: TextStyle(fontFamily: 'Rubik'),
                            ),
                            style: FortuneItemStyle(
                              color: colors[1 %
                                  colors
                                      .length], // Assign a different color for the blank
                              borderColor: Colors.white.withOpacity(0),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ]
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2)),
                  child: ElevatedButton(
                    onPressed: () {
                      if (entries.length <= 1 || entries.isEmpty) {
                        AppDialogs()
                            .alert(context, "Please enter atleast 2 entries.");
                      } else {
                        _spinWheel();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(
                          15), // Make the button big enough
                    ),
                    child: const Text(
                      "SPIN",
                      style: TextStyle(
                          letterSpacing: 0.75,
                          fontFamily: 'Spin',
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0, // You can adjust position as needed
            child: Image.asset(
              'assets/images/pointer.png', // Pointer image
              width: 40, // Adjust width
              height: 40, // Adjust height
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
        Stack(
          children: [
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
                padding: const EdgeInsets.all(6.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Scrollbar(
                        scrollbarOrientation: ScrollbarOrientation.right,
                        controller: _scrollController,
                        thumbVisibility:
                            true, // Ensures the scrollbar is always visible

                        // interactive: true,
                        thickness: 8, // Adjust thickness of the scrollbar
                        radius: const Radius.circular(4),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 0),
                            child: isEntriesSelected
                                ? TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(
                                      fontFamily: 'Rubik',
                                    ),
                                    controller: _nameController,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Add minimum 2 Entries here...",
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      _updateEntriesFromController();
                                    },
                                  )
                                : winners.isNotEmpty
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Table(
                                          border: TableBorder.all(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.grey,
                                              width: 0.25),
                                          columnWidths: const {
                                            0: FractionColumnWidth(
                                                0.2), // Adjust column width as needed
                                            1: FractionColumnWidth(0.8),
                                          },
                                          children: [
                                            const TableRow(
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightColor),
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "No.",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Winners",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Loop over winners with an index
                                            for (int i = 0;
                                                i < winners.length;
                                                i++)
                                              TableRow(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "# ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          (i + 1)
                                                              .toString(), // index + 1 for numbering
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      winners[i], // Winner name
                                                      style: const TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      )
                                    : const Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Text(
                                            "No winner yet",
                                            style: TextStyle(
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
                    )),
              ),
            ),
            isEntriesSelected
                ? Positioned(
                    bottom: 12,
                    right: 12,
                    child: InkWell(
                      onTap: () {
                        AppDialogs().delete(
                            context, "This will delete all your entries.", () {
                          resetController();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.darkColor),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            color: AppColors.lightColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 12,
                    right: 12,
                    child: InkWell(
                      onTap: () {
                        AppDialogs().delete(
                            context, "This will remove all the winners.", () {
                          resetWinner();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.darkColor),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            color: AppColors.lightColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
