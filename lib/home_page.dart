import 'dart:developer';

import 'package:animation_on_number_counting_in_flutter/widgets/text_card_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final List<int> targetValues = [117, 25, 348];
  List<int> currentValues = [0, 0, 0];

  late List<AnimationController> controllers;

  late AnimationController _animationController;
  late Animation<double> _listAnimation;
  final List<String> items = List.generate(3, (index) => 'Item $index');


  ///Second List Animation
  bool isAnimationStart = false;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isAnimationStart = true;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _listAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();


    ///counting animation
    controllers = List.generate(
      targetValues.length,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      ),
    );
    for (int i = 0; i < targetValues.length; i++) {
      controllers[i].forward();
      controllers[i].addListener(() {
        setState(() {
          currentValues[i] = (targetValues[i] * controllers[i].value).round();
        });
      });
    }




  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Counting Animation', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                targetValues.length,
                    (index) => AnimatedBuilder(
                  animation: controllers[index],
                  builder: (context, child) {
                    return CardWidget(size: size, value: currentValues[index].toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return buildItem(items[index], index);
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return buildItem2(items[index], index, size);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildItem(String item, int index) {
    // _animationController.forward(from: 0.0);

    return FadeTransition(
      opacity: _listAnimation,
      child: Card(
        child: ListTile(
          title: Text(item),
          onTap: () {
            // Handle item tap
            log('Item $index tapped');
          },
        ),
      ),
    );
  }
  Widget buildItem2(String item, int index, Size size) {
    // _animationController.forward(from: 0.0);

    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 900 + (index * 700)),
      transform: Matrix4.translationValues(isAnimationStart ? 0 : size.width, 0, 0),
      child: Card(
        child: ListTile(
          title: Text(item),
          onTap: () {
            // Handle item tap
            log('Item $index tapped');
          },
        ),
      ),
    );
  }
}
