import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class DateRangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DateRangePageState();
}

class _DateRangePageState extends State<DateRangePage> {
  DateTime _firstDate;
  DateTime _lastDate;
  DatePeriod _selectedPeriod;
  Color selectedPeriodStartColor;
  Color selectedPeriodLastColor;
  Color selectedPeriodMiddleColor;
  Color todayFollowupsButton = Colors.grey;
  Color thisWeekFollowupsButton = Colors.white;

  @override
  void initState() {
    super.initState();
    _firstDate = DateTime.now().subtract(Duration(days: 3000));
    _lastDate = DateTime.now().add(Duration(days: 3000));
    DateTime selectedPeriodStart = DateTime.now();
    DateTime selectedPeriodEnd = DateTime.now();
    String startMonth = selectedPeriodStart.month.toString();
    String startDay = selectedPeriodStart.day.toString();
    if(selectedPeriodStart.month<10){
      startMonth = "0"+selectedPeriodStart.month.toString();
    }
    if(selectedPeriodStart.day<10){
      startDay = "0"+selectedPeriodStart.day.toString();
    }
    String endMonth = selectedPeriodEnd.month.toString();
    String endDay = selectedPeriodEnd.day.toString();
    if(selectedPeriodEnd.month<10){
      endMonth = "0"+selectedPeriodEnd.month.toString();
    }
    if(selectedPeriodEnd.day<10){
      endDay = "0"+selectedPeriodEnd.day.toString();
    }
    selectedPeriodStart = DateTime.parse(selectedPeriodStart.year.toString()+"-"+startMonth.toString()+"-"+startDay.toString()+" 00:00:00");
    selectedPeriodEnd = DateTime.parse(selectedPeriodEnd.year.toString()+"-"+endMonth.toString()+"-"+endDay.toString()+" 23:59:59");
    _selectedPeriod = DatePeriod(selectedPeriodStart, selectedPeriodEnd);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedPeriodLastColor = Theme.of(context).accentColor;
    selectedPeriodMiddleColor = Theme.of(context).accentColor;
    selectedPeriodStartColor = Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    String startDate = _selectedPeriod.start.year.toString()+"-"+_selectedPeriod.start.month.toString()+"-"+_selectedPeriod.start.day.toString();
    String endDate = _selectedPeriod.end.year.toString()+"-"+_selectedPeriod.end.month.toString()+"-"+_selectedPeriod.end.day.toString();
    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: selectedPeriodLastColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: selectedPeriodStartColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
          color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
    );
    return
      Column(
        children: <Widget>[
          new SizedBox(
              child: AppBar(
                  backgroundColor: Colors.blue,
                  centerTitle: true,
                  title: new Text("Date Range Picker", style: new TextStyle(color: Colors.white)),
                  automaticallyImplyLeading: false,
                  actions: <Widget>[]
              )
          ),
          MaterialButton(
            child: new Text("ቀን መምረጫ", style: new TextStyle(color: Colors.green)),
            onPressed: null
          ),
          SizedBox(height: 10),
          ExpandableNotifier(  // <-- Provides ExpandableController to its children
            initialExpanded: true,
            child: Column(
              children: [
                Expandable(           // <-- Driven by ExpandableController from ExpandableNotifier
                  collapsed: ExpandableButton(  // <-- Expands when tapped on the cover photo
                    child: Container(
                        color: Colors.blue,
                        height: 25,
                        child: new Center(child: Text(DateFormat('MMM d, y').format(_selectedPeriod.start).toString()
                            +" to "+DateFormat('MMM d, y').format(_selectedPeriod.end).toString()
                            ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white)))),
                  ),
                  expanded: Column(
                      children: [
                        ExpandableButton(       // <-- Collapses when tapped on
                          child: Center(
                              child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 150,
                                      child: RangePicker(
                                        selectedPeriod: _selectedPeriod,
                                        onChanged: _onSelectedDateChanged,
                                        firstDate: _firstDate,
                                        lastDate: _lastDate,
                                        datePickerStyles: styles,
                                      ),
                                    ),
                                    Container(
                                        height: 25,
                                        color: Colors.blue,
                                        child: new Center(child: Text(DateFormat('MMM d, y').format(_selectedPeriod.start).toString()
                                            +" to "+DateFormat('MMM d, y').format(_selectedPeriod.end).toString()
                                            ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white)))),

                                  ])
                          ),
                        ),

                      ]
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Tooltip(
                          message: "Today",
                          child: new MaterialButton(
                              height: 27,
                              color: todayFollowupsButton,
                              child: Text("Today / ዛሬ ",style: TextStyle(fontSize: 12)),onPressed: (){
                            setState(() {
                              todayFollowupsButton = Colors.grey;
                              thisWeekFollowupsButton = Colors.white;
                              DateTime startDateTime = DateTime.now();
                              DateTime endDateTime = DateTime.now();
                              String startMonth = startDateTime.month.toString();
                              String startDay = startDateTime.day.toString();
                              if(startDateTime.month<10){
                                startMonth = "0"+startDateTime.month.toString();
                              }
                              if(startDateTime.day<10){
                                startDay = "0"+startDateTime.day.toString();
                              }
                              String endMonth = endDateTime.month.toString();
                              String endDay = endDateTime.day.toString();
                              if(endDateTime.month<10){
                                endMonth = "0"+endDateTime.month.toString();
                              }
                              if(endDateTime.day<10){
                                endDay = "0"+endDateTime.day.toString();
                              }
                              startDateTime = DateTime.parse(startDateTime.year.toString()+"-"+startMonth.toString()+"-"+startDay.toString()+" 00:00:00");
                              endDateTime = DateTime.parse(endDateTime.year.toString()+"-"+endMonth.toString()+"-"+endDay.toString()+" 23:59:59");
                              _selectedPeriod = new DatePeriod(startDateTime,endDateTime);
                            });
                          }),
                        ),
                        Tooltip(
                          message: "This week",
                          child: new MaterialButton(
                              height: 27,
                              color: thisWeekFollowupsButton,
                              child: Text("This Week / ይህ ሳምንት ",style: TextStyle(fontSize: 12)),onPressed: (){
                            setState(() {
                              todayFollowupsButton = Colors.white;
                              thisWeekFollowupsButton = Colors.grey;
                              DateTime startDateTime = DateTime.now().subtract(Duration(days: DateTime.now().weekday));
                              DateTime endDateTime = startDateTime.add(Duration(days: 6));
                              String startMonth = startDateTime.month.toString();
                              String startDay = startDateTime.day.toString();
                              if(startDateTime.month<10){
                                startMonth = "0"+startDateTime.month.toString();
                              }
                              if(startDateTime.day<10){
                                startDay = "0"+startDateTime.day.toString();
                              }
                              String endMonth = endDateTime.month.toString();
                              String endDay = endDateTime.day.toString();
                              if(endDateTime.month<10){
                                endMonth = "0"+endDateTime.month.toString();
                              }
                              if(endDateTime.day<10){
                                endDay = "0"+endDateTime.day.toString();
                              }
                              startDateTime = DateTime.parse(startDateTime.year.toString()+"-"+startMonth.toString()+"-"+startDay.toString()+" 00:00:00");
                              endDateTime = DateTime.parse(endDateTime.year.toString()+"-"+endMonth.toString()+"-"+endDay.toString()+" 23:59:59");
                              _selectedPeriod = new DatePeriod(startDateTime,endDateTime);
                            });
                          }),
                        ),
                      ],
                    ),
                  ]
                ),
              ],
            ),
          ),
          Center(
            child: Wrap(
              children: [
                Text("From "+startDate.toString(),style: TextStyle(fontSize: 20,color: Colors.greenAccent),),
                Text(" to "+endDate.toString(),style: TextStyle(fontSize: 20,color: Colors.redAccent),),
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      );
  }

  void _onSelectedDateChanged(DatePeriod newPeriod){
    DateTime startDateTime = DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    DateTime endDateTime = startDateTime.add(Duration(days: 6));
    if(newPeriod.start.year==DateTime.now().year && newPeriod.start.month==DateTime.now().month && newPeriod.start.day==DateTime.now().day && newPeriod.end.year==DateTime.now().year && newPeriod.end.month==DateTime.now().month && newPeriod.end.day==DateTime.now().day){
      todayFollowupsButton = Colors.grey;
      thisWeekFollowupsButton = Colors.white;
    }else if(newPeriod.start.year==startDateTime.year && newPeriod.start.month==startDateTime.month && newPeriod.start.day==startDateTime.day && newPeriod.end.year==endDateTime.year && newPeriod.end.month==endDateTime.month && newPeriod.end.day==endDateTime.day){
      todayFollowupsButton = Colors.white;
      thisWeekFollowupsButton = Colors.grey;
    }else{
      todayFollowupsButton = Colors.white;
      thisWeekFollowupsButton = Colors.white;
    }
    DateTime startDate = newPeriod.start;
    DateTime endDate = newPeriod.end;
    String startMonth = startDate.month.toString();
    String startDay = startDate.day.toString();
    if(startDate.month<10){
      startMonth = "0"+startDate.month.toString();
    }
    if(startDate.day<10){
      startDay = "0"+startDate.day.toString();
    }
    String endMonth = endDate.month.toString();
    String endDay = endDate.day.toString();
    if(endDate.month<10){
      endMonth = "0"+endDate.month.toString();
    }
    if(endDate.day<10){
      endDay = "0"+endDate.day.toString();
    }
    startDate = DateTime.parse(startDate.year.toString()+"-"+startMonth.toString()+"-"+startDay.toString()+" 00:00:00");
    endDate = DateTime.parse(endDate.year.toString()+"-"+endMonth.toString()+"-"+endDay.toString()+" 23:59:59");
    setState(() {
      _selectedPeriod = DatePeriod(startDate, endDate);
    });
  }
}