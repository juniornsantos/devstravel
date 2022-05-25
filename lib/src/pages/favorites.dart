import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class FavoritesPage extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  

  TextStyle styles = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue'
  );


  @override
  Widget build(BuildContext context){
    return Consumer<AppData>(
      builder: (ctx, appdata, child) {

        List favorites = appdata.favoritesCities();
        // print( favorites );


        return Scaffold(        
          key: _scaffoldKey,
          appBar: CustomAppBar(
            scaffoldKey: _scaffoldKey,
            pageContext: context,
            title: 'Cidades Salvas',
          ),
          drawer: CustomDrawer(
            pageContext: context
          ),
          backgroundColor: Colors.white,
          body: GridView.count(
              crossAxisCount: 2,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                children: List.generate(favorites.length, (index) {
                  return Citybox(
                    data: favorites[index],
                    onTap: (cityData){
                      // print(cityData['name']);
                      Navigator.pushNamed(context, '/city', arguments: cityData);
                    }
                  );
                }),
              )  
        );
      }
    );
  }
}
