import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState()=> _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  
  var list = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void doSearch (pageContext, text) async {
    var newList = await Provider.of<AppData>(pageContext, listen:false).searchCity(text);

    setState(() {
      list = newList;
    });
  }
  

  @override
  Widget build(BuildContext context){
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          pageContext: context,
          title: 'Busque uma cidade',
          hideSearch: true
        ),
        drawer: CustomDrawer(
          pageContext: context
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                onChanged: (text){
                  doSearch(context, text);
                },
                
                decoration: InputDecoration(
                  hintText: 'Digite o nome de uma cidade',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search, size: 32,)
                ),
              ),
            ),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                children: List.generate(list.length, (index) {
                  return Citybox(
                    data: list[index],
                    onTap: (cityData){
                      // print(cityData['name']);
                      Navigator.pushNamed(context, '/city', arguments: cityData);
                    }
                  );
                }),
              )
            )
          ],
        )
      )
    );
  }
}
