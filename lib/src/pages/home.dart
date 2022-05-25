import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';

class HomePage extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  

  TextStyle styles = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue'
  );


  @override
  Widget build(BuildContext context){
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(        
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          pageContext: context,
          title: 'Pagina Home',
        ),
        drawer: CustomDrawer(
          pageContext: context
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text("Bem vindo(a) ao:", style: styles,)
              ),
              Image.asset('lib/assets/devstravel_logo.png', width: 200,),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: 
                Text("Seu guia de viagem perfeito", style: styles,
              )
            )
          ],
        )
        ),
      )
    );
  }
}
