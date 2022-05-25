import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/course.dart';
import 'package:uni/model/entities/course_unit.dart';
import 'package:uni/model/entities/moodle/moodle_course_unit.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/curricular_unit_card.dart';
import 'package:uni/utils/constants.dart' as Constants;


/// Manages the 'schedule' sections of the app
class UcsPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UcsPageViewState();
}

/// Tracks the state of `ExamsLists`.
class UcsPageViewState extends SecondaryPageViewState {
  final double borderRadius = 10.0;

  @override
  Widget getBody(BuildContext context) {
    return StoreConnector<AppState, Tuple2<List<CourseUnit>, Map<int, MoodleCourseUnit>>>(
      converter: (store) {
        return Tuple2(store.state.content['currUcs'], store.state.content['moodleCourseUnitsMap']);
      },
      builder: (context, tuple) {
        return UcsList(ucs: tuple.item1,
                       moodleCourseUnitsMap: tuple.item2);
      },
    );
  }
}

/// Manages the 'Exams' section in the user's personal area and 'Exams Map'.
class UcsList extends StatelessWidget {
  final List<CourseUnit> ucs;
  final Map<int, MoodleCourseUnit> moodleCourseUnitsMap;
  UcsList({Key key, @required this.ucs, @required this.moodleCourseUnitsMap}) : super(key: key);
  
  List<CurricularUnitCard> createAllUnitCards(){
      final List<CurricularUnitCard> curricularUnitCards = [];
      for (var courseUnit in ucs) {
        Logger().i('Create unit cards');
          curricularUnitCards
              .add(CurricularUnitCard(courseUnit, moodleCourseUnitsMap[courseUnit.moodleId]));
      }
      return curricularUnitCards;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
          child: 
         
            Text(
              Constants.ucs, 
              style:
                Theme.of(context).textTheme.headline6.apply(fontSizeFactor: 1.3),)
          
          ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            //TODO - Por a retornar uma lista de cards
            children: createAllUnitCards(),
          ),
        ),
        
      
      ],
    );
  }


}