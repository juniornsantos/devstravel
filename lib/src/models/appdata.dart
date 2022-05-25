import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppData with ChangeNotifier {
  var data = [];
  var favorites = [];

  List favoritesCities(){
    List result = [];

    for (var favorite in favorites){
      List foundCities = this.searchCity(favorite);
      if(foundCities.length > 0){
        result.add(foundCities[0]);
      }
    }


    return result;
  }

  List searchCity(text){
    List result = [];

    text = text.trim().toLowerCase();
    if(text == ''){
      return result;
    }

    for(var continents in data){
      for (var country in continents['countries']){
        for (var city in country['cities']){
          if (city['name'].toLowerCase().contains(text)){
            result.add(city);
          }
        }
      }
    }
    return result;
  }

  bool hasFavorite(cityname){
    return favorites.contains(cityname);
  }

  bool favorite(cityname){
    if (this.hasFavorite(cityname)){
      //remover
      favorites.remove(cityname);

      return false;
    }else{
      //adcionar
      favorites.add(cityname);
      return true;
    }    
  }

  void setData(newData) {
    data = newData;
    notifyListeners();
  }


  Future<bool> requestData() async {
    final res = await http.get(Uri.parse('https://api.b7web.com.br/flutter1wb/'));

    if (res.statusCode == 200) {
      // inserir os dados em DATA
      // print(res.body);
      // setData(res.body);

      setData(jsonDecode(res.body));
      return true;
    } else {
      return false;
    }
  }
}
