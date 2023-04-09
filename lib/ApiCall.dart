
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCall{

  sendApiRequest({required String url, required String method, Map? bodyParameter})async{

    http.Response? response;
    var header={'Content-Type':"application/json"};
    //call method
    switch(method){
      case "get":
        response=await http.get(Uri.parse(url));
        print("==get method call== url:$url");
        break;
      case "post":
        //if api support raw data than pass as strinng other wise map data and pass header in content type application/json
        response=await http.post(Uri.parse(url),body:jsonEncode(bodyParameter!),);
        print("==post method call== url:$url Body Parameter $bodyParameter");
        break;
      case "put":
        response=await http.put(Uri.parse(url),body:jsonEncode(bodyParameter!),);
        print("==put method call== url:$url Body Parameter $bodyParameter");
        break;
      case "delete":
        response=await http.delete(Uri.parse(url));
        print("==delete method call== url:$url");
        break;
    }
   if(response!=null){
     switch(response.statusCode){
       case 200:
         return response.body;
         break;
       case 400:
         //call your specific code handle for 401 code
         break;
       case 401:
         //call authentication error
         break;
     }
   }
   return null;

  }

}