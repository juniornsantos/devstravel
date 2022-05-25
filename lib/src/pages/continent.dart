import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';

import '../partials/citybox.dart';

class ContinentPage extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  

  TextStyle styles = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue'
  );

  void seeCityAction (context, continetIndex){
    print(continetIndex);
    Navigator.pushNamed(context, '/listcity', arguments: continetIndex);
  }

  void cityBoxAction (pageContext, cityData){
    // print(cityData['name']);
    Navigator.pushNamed(pageContext, '/city', arguments:cityData );
  }


  @override
  Widget build(BuildContext context){
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          pageContext: context,
          title: 'Escolha um Continente',
        ),
        drawer: CustomDrawer(
          pageContext: context
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: appdata.data.length,
          itemBuilder: (context, index){
            //appdata.data[index]['name']}


            var cities = [];
            for (var country in appdata.data[index]['countries']){
              cities.addAll(country['cities']);

            }

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                      "${appdata.data[index]['name']} (${cities.length}) ", 
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Helvetica Neue'
                      ),
                    ),
                    ),
                    FlatButton(
                      child: Text(
                        'Ver Cidades',
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                      ),
                      onPressed: (){
                        seeCityAction(context, index);
                      },
                    )
                  ],
                ),

                Container(
                  height: 150,
                  margin: EdgeInsets.only(bottom: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cities.length,
                    itemBuilder: (cityContext, cityIndex){
                      return Citybox(
                        data: cities[cityIndex],
                        onTap: (cityData){
                          cityBoxAction(context, cityData);
                        }
                      );
                    },
                  ),
                )



              ],
            );

          },
        )
      )
    );
  }
}
