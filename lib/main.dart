import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restapidemofluter/ApiCall.dart';

import 'model/ProductListModel.dart';

void main() {
  //	CERTIFICATE_VERIFY_FAILED: certificate has expired
  HttpOverrides.global =MyHttOverrides();
  runApp(const MyApp());
}

class MyHttOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)..badCertificateCallback=(X509Certificate cert,String host,int port)=>true;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Product> product=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicall();
  }
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rest Api Demo"),),
      //display data
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red,
        onTap: (index){
          selectedIndex=index;
          switch(index){
            case 0:
            //get request
              apicall();
              break;
            case 1:
              //post method
              apicallPost();
              break;
            case 2:
              //put request
              apiCallPut();
              break;
            case 3:
              //delete request
            apiCallDelete();
              break;
          }

        },
        unselectedItemColor: Colors.black,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.interests,color: Colors.black,),label: "get",),
        BottomNavigationBarItem(icon: Icon(Icons.interests,color: Colors.black),label: "post"),
        BottomNavigationBarItem(icon: Icon(Icons.interests,color: Colors.black),label: "put"),
        BottomNavigationBarItem(icon: Icon(Icons.interests,color: Colors.black),label: "delete"),
      ],
      ),
      body: product.isEmpty?Center(child: CircularProgressIndicator(),):ListView.builder(itemCount: product.length, itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product[index].images[0]),
          ),
          title: Text("${product[index].title!}"),
        );
      },),
    );
  }

  void apicall  ()async {
    var dataResponse=await ApiCall().sendApiRequest(url:"https://dummyjson.com/products?skip=5&limit=10",method:"get",bodyParameter:{},);
    // print("response $dataResponse");
    product.clear();
    if(dataResponse!=null){
      ProductListModel model=productListModelFromJson(dataResponse);
      product.addAll(model.products);
    }
    setState(() {});
  }
  void apicallPost  ()async {
    //this post method
      var data=Product(id: "2",title: "demo", description: "description", price: "100", discountPercentage: "10.0", rating: "35", stock: "4", brand: "brand", category: Category.LAPTOPS, thumbnail: "thumbnail", images: [""]);
      var body =jsonDecode(productListModelToJson(ProductListModel(products: [data], total: 10, skip: 1, limit: 10)))['products'][0];
      print(body);
    var dataResponse=await ApiCall().sendApiRequest(url:"https://dummyjson.com/products/add",method:"post",bodyParameter:body,);
    print("response $dataResponse");
    // apicall();
    // setState(() {});
    //it is for test so not show in there database
  }

  void apiCallPut()async {
    //this put method
    var data=Product(id: "6",title: "demo", description: "description", price: "100", discountPercentage: "10.0", rating: "35", stock: "4", brand: "brand", category: Category.LAPTOPS, thumbnail: "thumbnail", images: [""]);
    var body =jsonDecode(productListModelToJson(ProductListModel(products: [data], total: 10, skip: 1, limit: 10)))['products'][0];
    print(body);
    var dataResponse=await ApiCall().sendApiRequest(url:"https://dummyjson.com/products/6",method:"put",bodyParameter:body,);
    print("response $dataResponse");
    // apicall();
  // setState(() {});
  //it is for test so not show in there database
  }

  void apiCallDelete()async {
    //this delete method
    var data=Product(id: "6",title: "demo", description: "description", price: "100", discountPercentage: "10.0", rating: "35", stock: "4", brand: "brand", category: Category.LAPTOPS, thumbnail: "thumbnail", images: [""]);
    var body =jsonDecode(productListModelToJson(ProductListModel(products: [data], total: 10, skip: 1, limit: 10)))['products'][0];
    print(body);
    var dataResponse=await ApiCall().sendApiRequest(url:"https://dummyjson.com/products/6",method:"delete",bodyParameter:body,);
    print("response $dataResponse");
    // apicall();
    // setState(() {});
    //it is for test so not show in there database
  }
}
