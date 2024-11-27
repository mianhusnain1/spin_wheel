import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wheel_of_names/constant.dart';

class AppDialogs {
  void showWinnerDialog(BuildContext context, String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "The Winner is $winner!",
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 15,
                      color: AppColors.darkColor,
                      overflow: TextOverflow.ellipsis, // Show dots for overflow
                    ),
                  ),
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

  void alert(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 1,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 15,
                      color: AppColors.darkColor),
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

  void delete(BuildContext context, String text, VoidCallback ontap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 1,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 15,
                      color: AppColors.darkColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: 60,
                        decoration: BoxDecoration(
                            color: AppColors.lightColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.darkColor)),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: AppColors.darkColor,
                              fontFamily: 'RubikMedium',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: ontap,
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
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01)
              ],
            ),
          ),
        );
      },
    );
  }
}
