import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/screens/addproductscreen.dart';
import 'package:tokoonline/screens/editscreen.dart';
import 'package:tokoonline/screens/productdetailscreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //http://127.0.0.1:8000/api/products original url
  var url = Uri.parse('http://10.0.2.2:8000/api/products');
  Future getProduct() async {
    var response = await http.get(url);
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteProduct(String id) async {
    var url2 = Uri.parse('http://10.0.2.2:8000/api/products/$id');
    var response = await http.delete(url2);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Seca Store"),
      ),
      body: FutureBuilder(
        future: getProduct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data['data'].length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(ProductDetail(),
                                    arguments:
                                        snapshot.data['data'][index] as Map);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(snapshot.data['data']
                                          [index]['image_url'])),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]['name']
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(snapshot.data['data'][index]
                                      ['description']),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Get.to(EditScreen(),
                                                arguments: snapshot.data['data']
                                                    [index] as Map);
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            deleteProduct(snapshot.data['data']
                                                        [index]['id']
                                                    .toString())
                                                .then((value) {
                                              setState(() {});
                                              Get.showSnackbar(
                                                GetBar(
                                                  message:
                                                      'Produk berhasil hapus',
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                            });
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                        Text(
                                          snapshot.data['data'][index]['price'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            );
          } else {
            return Text('data error');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProductScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
