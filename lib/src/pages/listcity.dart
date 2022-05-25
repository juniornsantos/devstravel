import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ListCityPage extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  

  TextStyle styles = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue'
  );

  void cityBoxAction (pageContext, cityData){
    // print(cityData['name']);
    Navigator.pushNamed(pageContext, '/city', arguments:cityData );

  }


  @override
  Widget build(BuildContext context){

    final Object? continetIndex = ModalRoute.of(context)?.settings.arguments;
    // print("Args: $args");


    return Consumer<AppData>(
      builder: (ctx, appdata, child) {

        var cities = [];

        for (var country in appdata.data[continetIndex as int]['countries']){
            cities.addAll(country['cities']);
        }


        return Scaffold(        
          key: _scaffoldKey,
          appBar: CustomAppBar(
            scaffoldKey: _scaffoldKey,
            pageContext: context,
            title: "${appdata.data[continetIndex as int]['name']} (${cities.length } cidades)",
            showBack: true
          ),
          drawer: CustomDrawer(
            pageContext: context
          ),
          backgroundColor: Colors.white,
          body: GridView.count(
            crossAxisCount: 3,
            children:
              List.generate(cities.length, (index) {
                return Citybox(
                  data: cities[index],
                  onTap: (cityData){
                    cityBoxAction(context, cityData);
                  },
                // ignore: dead_code
                );               
              }),
          )
        );
      }
    );
  }
}
