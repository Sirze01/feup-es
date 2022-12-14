import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/moodle/activities/moodle_label.dart';
import 'package:uni/model/entities/moodle/activities/moodle_page.dart';
import 'package:uni/model/entities/moodle/activities/moodle_resource.dart';
import 'package:uni/model/entities/moodle/activities/moodle_sigarra_course_info.dart';
import 'package:uni/model/entities/moodle/activities/moodle_url.dart';
import 'package:uni/model/entities/moodle/moodle_section.dart';
import 'package:uni/view/Pages/moodle_activity_page_view.dart';
import 'moodle/moodle_resource_widget.dart';
import 'moodle/page_activity_widget.dart';
import 'moodle/sigarra_course_info_widget.dart';
import 'moodle/url_activity_widget.dart';

class SectionCard extends StatefulWidget {
  final MoodleSection section;

  SectionCard(this.section, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SectionCardState();
  }

  Widget buildCardContent(BuildContext context) {
    return Wrap(
        children: <Widget>[
              Divider(color: Colors.grey.shade500),
              Container(
                  child: Text(
                    this.section.summary,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                  padding: EdgeInsets.only(
                    bottom: 15,
                  )),
            ] +
            createActivities(context));
  }

  List<Widget> createActivities(BuildContext context) {
    final List<Widget> widgets = [];
    if (this.section.activities == null) {
      return widgets;
    }
    this.section.activities.forEach((element) {
      if (element is MoodleResource) {
        widgets.add(Row(children: [MoodleResourceWidget(element)]));
      } else if (element is SigarraCourseInfo) {
        widgets.add(Row(children: [SigarraCourseInfoWidget(element)]));
      } else if (element is PageActivity) {
        widgets.add(Row(children: [PageActivityWidget(element)]));
      } else if (element is UrlActivity) {
        widgets.add(Row(children: [URLActivityWidget(element)]));
      } else if (element is LabelActivity) {
        widgets.add(Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Text(element.title)));
      } else {
        widgets.add(Row(
          children: <Widget>[
            Flexible(
                child: RichText(
              text: TextSpan(
                  text: element.title,
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MoodleActivityPageView(element)),
                      );
                    }),
            ))
          ],
        ));
      }
    });

    return widgets;
  }

  String getTitle() {
    return this.section.title;
  }
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
                      Expanded(
                          child: Container(
                        child: Text(widget.getTitle(),
                            style: Theme.of(context).textTheme.headline1.apply(
                                fontSizeDelta: -53, fontWeightDelta: -3)),
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
