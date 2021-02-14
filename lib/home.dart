import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var api = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail";
  var res, drinks;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    res = await http.get(api);
    drinks = jsonDecode(res.body)["drinks"];
    print(drinks..toString);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" FLURRER STAGGERED GRID VIEW"),
      ),
      body: drinks != null
          ? StaggeredGridView.countBuilder(
              itemCount: drinks.length,
              crossAxisCount: 4,
              itemBuilder: (context, index) {
                var drink = drinks[index];
                return Container(
                  color: Colors.green,
                  child: new Center(
                    child: Image.network(
                      drink["strDrinkThumb"],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
    );
  }
}
