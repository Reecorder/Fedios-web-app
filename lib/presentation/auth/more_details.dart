import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_auth_title.dart';
import '../../model/color.dart';

class MoreRestaurantDetails extends StatefulWidget {
  const MoreRestaurantDetails({super.key});

  @override
  State<MoreRestaurantDetails> createState() => _MoreRestaurantDetailsState();
}

class _MoreRestaurantDetailsState extends State<MoreRestaurantDetails> {
  final List<Map<String, dynamic>> _dataArray = [
    {'value': '', 'id': 0}
  ];
  final List<String> extraList = [];
  final List<TextEditingController> _controllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // image
            Image.asset(
              "assets/auth_screen.png",
              fit: BoxFit.cover,
              height: 200,
              width: Get.width,
            ),

            // Title text
            const CommonAuthTtile(
                titleText: "India's #1 Food Video and Delivery App"),
            const SizedBox(height: 20),

            ...List.generate(_dataArray.length, (index) => form(index)),

            const SizedBox(height: 10),
            Visibility(
              visible: _dataArray.isNotEmpty,
              child:
                  Text("${_dataArray.map((item) => item['value']).join(', ')}"),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _addMore,
              child: Text("Add More"),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget form(int key) {
    TextEditingController controller;
    if (key >= _controllers.length) {
      controller = TextEditingController();
      _controllers.add(controller);
    } else {
      controller = _controllers[key];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26),
                ),
                suffixIcon: key > 0
                    ? IconButton(
                        icon: Icon(Icons.cancel_outlined),
                        onPressed: () => _removeField(key),
                      )
                    : SizedBox(),
                hintText: 'Serving ${key + 1}',
                label: Text(
                  'Serving ${key + 1}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              onChanged: (val) => _onUpdate(key, val),
            ),
          ),
        ],
      ),
    );
  }

  void _onUpdate(int key, String val) {
    _dataArray[key]['value'] = val;
    extraList.clear();
    for (var item in _dataArray) {
      extraList.add(item['value']);
    }
    log("Extra List: $extraList");
    setState(() {});
  }

  void _addMore() {
    final newKey = _dataArray.length;
    _dataArray.add({'value': '', 'id': newKey});
    _controllers.add(TextEditingController());
    setState(() {});
  }

  void _removeField(int key) {
    _dataArray.removeAt(key);
    _controllers.removeAt(key);
    setState(() {});
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
