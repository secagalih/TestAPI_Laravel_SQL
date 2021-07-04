import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:tokoonline/screens/homepage.dart';

class EditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map dataarg = Get.arguments;
    final _fromkey = GlobalKey<FormState>();
    TextEditingController _namectrl = TextEditingController();
    TextEditingController _desctrl = TextEditingController();
    TextEditingController _pricectrl = TextEditingController();
    TextEditingController _iamgectrl = TextEditingController();
    var url = Uri.parse('http://10.0.2.2:8000/api/products/${dataarg['id']}');

    Future updateData() async {
      var response = await http.put(url, body: {
        'name': _namectrl.text,
        'description': _desctrl.text,
        'price': _pricectrl.text,
        'image_url': _iamgectrl.text,
      });
      // print(json.decode(response.body));
      return json.decode(response.body);
    }

    print(dataarg);
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
                  controller: _namectrl..text = '${dataarg['name']}',
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _desctrl..text = '${dataarg['description']}',
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product Description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pricectrl..text = '${dataarg['price']}',
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product Price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _iamgectrl..text = '${dataarg['image_url']}',
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
                        Get.showSnackbar(GetBar(
                          message: 'Produk berhasil diubah',
                          duration: Duration(seconds: 1),
                        ));
                        updateData().then((value) => Get.offAll(MyHomePage()));
                      }
                    },
                    child: Text('Save'))
              ],
            )),
      ),
    );
  }
}
