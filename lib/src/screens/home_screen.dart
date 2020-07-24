import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
 HomeScreen
({Key key}) : super(key: key);

  @override
   HomeScreenState createState() =>  HomeScreenState();
}
class DemoInfo{
  final String name;
  final int votes;
  DemoInfo({
    this.name, this.votes}
  );
}
class  HomeScreenState extends State<HomeScreen> {
  final List<DemoInfo> _bandList = [
    DemoInfo(name:'Nombre demo', votes:0),
    DemoInfo(name:'Nombre demo', votes:2),
    DemoInfo(name:'Nombre demo', votes:3),
    DemoInfo(name:'Nombre demo', votes:4),
    DemoInfo(name:'Nombre demo', votes:5),
  ];

  @override
  void initState() {
    super.initState();

    Firestore.instance
    .collection('bandnames')
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) => print(doc['name'])));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Band Names Survey'),

            ),
            SliverSafeArea(
              sliver: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('bandnames').snapshots(),
                builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData) return SliverToBoxAdapter(
                      child: CupertinoActivityIndicator());
                      return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index){
                                return _buildListItem(context,snapshot.data.documents[index]);
                                                
                                                
                              },childCount: snapshot.data.documents.length,
                                
                            ),
                      );
                },) 
                              )
                            ],
                          )
                        ),
    );
  }
                  
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {

      return ListTile(
        title: Text(document['name']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(document['votes'].toString()),
            Icon(CupertinoIcons.right_chevron),

        ],),
      );

  }
}

 /*SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                    return _buildListItem(context,_bandList[index]);
                                    
                                    
                  },childCount: _bandList.length
                    
                                  ),
                                ),
                              )*/