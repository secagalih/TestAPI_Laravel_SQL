import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/screens/homepage.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _fromkey = GlobalKey<FormState>();
    TextEditingController _namectrl = TextEditingController();
    TextEditingController _desctrl = TextEditingController();
    TextEditingController _pricectrl = TextEditingController();
    TextEditingController _iamgectrl = TextEditingController();
    var url = Uri.parse('http://10.0.2.2:8000/api/products');
    Future saveProduct() async {
      var response = await http.post(url, body: {
        'name': _namectrl.text,
        'description': _desctrl.text,
        'price': _pricectrl.text,
        'image_url': _iamgectrl.text,
      });
      // print(json.decode(response.body));
      return json.decode(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _fromkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _namectrl,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _desctrl,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product Description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pricectrl,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product Price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _iamgectrl,
                  decoration: InputDecoration(labelText: 'Image Url'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product Image Url';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_fromkey.currentState!.validate()) {
                        saveProduct().then((value) => Get.offAll(MyHomePage()));
                        Get.showSnackbar(GetBar(
                          message: 'Produk berhasil ditambah',
                          duration: Duration(seconds: 1),
                        ));
                      }
                    },
                    child: Text('Save'))
              ],
            )),
      ),
    );
  }
}
