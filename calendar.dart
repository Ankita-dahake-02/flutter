import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String month = "DM_DIV_DAY_";
  List monthlist = [
    "DM_DIV_DAY_",
    "DM_DIV_DAY_2",
  ];

  List studentname = [
    "Anisha Iyengar",
    "Anjali Iyer",
    "Aparajita Jagga",
    "Aparna Jain",
    "Apurva Jani",
  ];
  String attendance = "In";
  List attendancelist = [
    "row1",
    "row2",
    "row3",
    "row4",
    "row5",
  ];

  bool isbutton2 = false;

  DateTime todays_date = DateTime.now();
  DateTime? select_date;
  CalendarFormat format_of_calender = CalendarFormat.month;
  void _onDaySelected(DateTime selectedDay, List events) {
    setState(() {
      select_date = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 233, 233),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(bottom: 5, left: 7),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 40,
                  ),
                  value: month,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "DM_DIV_DAY_",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      value: "DM_DIV_DAY_2",
                    ),
                    DropdownMenuItem(
                      child: Text("DM_DIV_DAY_2",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      value: "DM_DIV_DAY_",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      month = value.toString();
                    });
                  }),
            ),
          ),
          Icon(
            Icons.more_vert,
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 50,
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ATTENDANCE",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 5),
                    ),
                  ],
                )),
            Container(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: todays_date,
                calendarFormat: format_of_calender,
                rowHeight: 40,
                headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(color: Colors.white),
                    titleTextFormatter: (date, locale) {
                      return DateFormat.yM(locale).format(date);
                    },
                    leftChevronIcon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )),
                calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.black),
                    selectedTextStyle: TextStyle(color: Colors.black),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey,
                    )),
                daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) {
                    return DateFormat.E(locale).format(date)[0];
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(select_date, selectedDay)) {
                    setState(() {
                      select_date = selectedDay;
                      todays_date = focusedDay;
                    });
                  }
                },
                selectedDayPredicate: (day) {
                  return isSameDay(select_date, day);
                },
                onFormatChanged: (format) {
                  if (format_of_calender != format) {
                    setState(() {
                      format_of_calender = format;
                    });
                  }
                },
                enabledDayPredicate: (date) {
                  // return !day.isAfter(todays_date);
                  return date.isBefore(TableCalendar.of(context)
                      .focusedDay
                      .add(Duration(days: 1)));
                },
              ),
            ),
            if (select_date != null) ...[
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Sent to the server",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Icon(
                      Icons.circle,
                      size: 15,
                      color: const Color.fromARGB(255, 78, 182, 131),
                    )
                  ],
                ),
              ),
              Container(
                height: 270,
                width: 375,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext, index) {
                      return Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              studentname[index],
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: Colors.blueAccent,
                                  value: "In",
                                  groupValue: attendancelist[index],
                                  onChanged: (value) {
                                    setState(() {
                                      attendancelist[index] = value;
                                      isbutton2 = false;
                                    });
                                  }),
                            ],
                          ),
                          Text("In",
                              style: TextStyle(color: Colors.blueAccent)),
                          Radio(
                              activeColor: Colors.blueAccent,
                              value: "Out",
                              groupValue: attendancelist[index],
                              onChanged: (value) {
                                setState(() {
                                  attendancelist[index] = value;
                                  isbutton2 = attendancelist[index] == "Out";
                                });
                              }),
                          Text("Out",
                              style: TextStyle(color: Colors.blueAccent)),
                          Radio(
                              activeColor: Colors.blueAccent,
                              value: "Absent",
                              groupValue: attendancelist[index],
                              onChanged: (value) {
                                setState(() {
                                  attendancelist[index] = value;
                                  isbutton2 = attendancelist[index] == "Absent";
                                });
                              }),
                          Text("Absent",
                              style: TextStyle(color: Colors.blueAccent)),
                        ],
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                      child: Text(
                        'Done',
                        style:
                            TextStyle(fontSize: 18, color: Colors.blueAccent),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      child: Text(
                        "End of class",
                        style:
                            TextStyle(fontSize: 18, color: Colors.blueAccent),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.only(left: 10, right: 10)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      onPressed: isbutton2
                          ? () {
                              print("hii");
                            }
                          : null,
                    )
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
