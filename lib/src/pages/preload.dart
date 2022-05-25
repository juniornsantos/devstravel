import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPage createState() => _PreloadPage();
}

class _PreloadPage extends State<PreloadPage> {
  bool loading = true;


  void requestInfo() async {

    await Future.delayed(Duration(seconds: 1));


    setState(() {
      loading = true;
    });

    bool req = await Provider.of<AppData>(context, listen:false).requestData(); //mudei aqui do dele

    if(req){
      //ir para home
      //print("Deu certo!");
      //Navigator.pushNamed(context, "/home"); sem botão voltar
      Navigator.pushReplacementNamed(context, "/home");
      //Navigator.pushNamed(context, "/home");
    }else{
        setState(() {
        loading = false;
      });
    } 
  }
  
  void initState(){
    super.initState();

    requestInfo();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/devstravel_logo.png',
            width: 200,
          ),
          loading
              ? Container(
                  margin: EdgeInsets.all(30),
                  child: Text(
                    "Carregando Informações...",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              : Container(),
          loading
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                )
              : Container(),
          !loading
              ? Container(
                  margin: EdgeInsets.all(30),
                  child: RaisedButton(
                    child: Text("Tentar Novamente"),
                    onPressed: () {},
                  ))
              : Container(),
        ],
      )),
    );
  }
}
