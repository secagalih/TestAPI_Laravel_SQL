import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tokoonline/screens/editscreen.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map dataarg = Get.arguments;
    print(dataarg);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Column(
        children: [
          Image.network(dataarg['image_url']),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dataarg['price'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              IconButton(
                onPressed: () {
                  Get.to(EditScreen(), arguments: dataarg);
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Text(dataarg['description'],
              style: TextStyle(
                fontSize: 20,
              )),
        ],
      ),
    );
  }
}
