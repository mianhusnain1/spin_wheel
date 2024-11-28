import 'package:flutter/material.dart';
import 'package:wheel_of_names/constant.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    const threshhold = 450;
    return Scaffold(
        backgroundColor: AppColors.darkColor,
        body: Container(
          width: mq.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  child: mq.width < threshhold
                      ? Image.asset("assets/images/mobile.png",
                          width: mq.width,
                          // height: mq.height * 0.4,
                          fit: BoxFit.fitWidth)
                      : Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: mq.width * 0.09),
                          child: Image.asset(
                            "assets/images/tab.png",
                            width: mq.width * 0.82,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      height: mq.height * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Get in Touch",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: 'Product-Sans'),
                          ),
                          const Text(
                            "If you have ant question feel free to contact us!",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Product-Sans',
                                fontSize: 18),
                          ),
                          SizedBox(height: mq.height * 0.05),
                          Text(
                            "Email:",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Product-Sans",
                                fontSize: 18),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 7),
                                  child: Text(
                                    "whatagreatquery@gmail.com",
                                    style: TextStyle(
                                        letterSpacing: 0.75,
                                        fontSize: 18,
                                        fontFamily: 'Product-Sans',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              //
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  // Center(
                  //   child: Container(
                  //     height: mq.height * 0.3,
                  //     width: mq.width * 0.95,te
                  //     constraints: const BoxConstraints(maxWidth: 700),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.darkColor,
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         const Text(
                  //           "GET IN TOUCH",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontFamily: 'RubikMedium',
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         SizedBox(
                  //           height: mq.width * 0.03,
                  //         ),
                  //         const Text(
                  //           "If you have any question feel free to contact us!",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontFamily: 'RubikMedium',
                  //             fontSize: 12,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: mq.width * 0.08,
                  //         ),
                  //         Container(
                  //           height: mq.height * 0.05,
                  //           width: mq.width * 0.8,
                  //           constraints: const BoxConstraints(maxWidth: 600),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: const Center(
                  //             child: Text(
                  //               "Email: writeagreatquery@gmail.com",
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontFamily: 'RubikMedium',
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: mq.height * 0.1,
                  // ),
                  // const Text(
                  //   "Connect with us",
                  //   style: TextStyle(
                  //       color: AppColors.darkColor,
                  //       fontFamily: "RubikMedium",
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     InkWell(
                  //         onTap: () => _launchURL(context, linkedInUrl),
                  //         child: const CircleAvatar()),
                  //     const SizedBox(
                  //       width: 15,
                  //     ),
                  //     InkWell(
                  //         onTap: () => _launchURL(context, facebookUrl),
                  //         child: const CircleAvatar())
                  //   ],
                  // )
                ],
              ),
            ],
          ),
        ));
  }
}
