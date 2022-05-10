import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/time_utilities.dart';
import 'package:uni/model/entities/section.dart';

class SectionCard extends StatefulWidget{
  
  final Section section;
  SectionCard(this.section, {Key key}) : super(key: key); 

  @override
  State<StatefulWidget> createState() {
    return SectionCardState();
  }

  Widget buildCardContent(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Divider(
              color: Colors.grey.shade500
          ),
        Row(
          children: <Widget>[
            Flexible( 
              child: Text(this.section.description,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade, 
            ))]),

        Row(
          children: <Widget>[
            Text(this.section.activity)]),
      ]
    ); 
    
  }

  String getTitle() => this.section.name;

}

class SectionCardState extends State<SectionCard> {
  final double borderRadius = 10.0;
  final double padding = 12.0;

  @override
  Widget build(BuildContext context) {
    return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Color.fromARGB(0, 0, 0, 0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(this.borderRadius)),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(0x1c, 0, 0, 0),
                        blurRadius: 7.0,
                        offset: Offset(0.0, 1.0))
                  ],
                  color: Theme.of(context).dividerColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(this.borderRadius))),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 60.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(this.borderRadius))),
                  width: (double.infinity),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                            child: Text(widget.getTitle(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .apply(
                                        fontSizeDelta: -53,
                                        fontWeightDelta: -3)),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.only(top: 15, bottom: 10),
                          )),
                          /*Container(
                            child: this.getMoveIcon(context),
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 8),
                          ),
                          Flexible(
                            child: Container(
                              child: this.getDeleteIcon(context),
                              alignment: Alignment.centerRight,
                              height: 32,
                            )),*/
                        ].where((e) => e != null).toList(),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: this.padding,
                          right: this.padding,
                          bottom: this.padding,
                        ),
                        child: widget.buildCardContent(context),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}