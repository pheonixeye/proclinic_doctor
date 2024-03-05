import 'dart:math';

import 'package:page_slider/page_slider.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/SRLCP_Page/SRLCP_page.dart';
import 'package:flutter/material.dart';
// import 'package:page_slider/page_slider.dart';

List<String> headlines = [
  'sheets',
  'labs',
  'rads',
  'prescriptions',
  'comments'
];

List<Icon> _iconlist = [
  const Icon(
    Icons.contact_page,
    size: 100,
  ),
  const Icon(
    Icons.format_list_numbered,
    size: 100,
  ),
  const Icon(
    Icons.radio,
    size: 100,
  ),
  const Icon(
    Icons.description,
    size: 100,
  ),
  const Icon(
    Icons.comment_bank,
    size: 100,
  ),
];
List<ShapeBorder> shapelist = [
  RoundedRectangleBorder(
      borderRadius:
          BorderRadiusDirectional.circular(Random().nextDouble() * 35)),
  const CircleBorder(),
  const CircleBorder(),
  ContinuousRectangleBorder(
      borderRadius:
          BorderRadiusDirectional.circular(Random().nextDouble() * 77)),
  BeveledRectangleBorder(
      borderRadius:
          BorderRadiusDirectional.circular(Random().nextDouble() * 63))
];

class PaperWorkPage extends StatefulWidget {
  final String? ptname;
  final String? phone;
  final String? docname;
  final String? day;
  final String? month;
  final String? year;
  final String? visit;
  final String? procedure;
  final String? dob;
  final String? age;
  final String? cashtype;
  final String? id;

  const PaperWorkPage(
      {Key? key,
      this.ptname,
      this.phone,
      this.docname,
      this.day,
      this.month,
      this.year,
      this.visit,
      this.procedure,
      this.dob,
      this.age,
      this.cashtype,
      this.id})
      : super(key: key);
  @override
  _PaperWorkPageState createState() => _PaperWorkPageState();
}

class _PaperWorkPageState extends State<PaperWorkPage> {
  GlobalKey<PageSliderState> _sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages1 = headlines.map((e) {
      return SizedBox(
        width: 400,
        height: 400,
        child: MaterialButton(
          elevation: 5,
          hoverElevation: 30,
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          hoverColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          highlightColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          splashColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          shape: shapelist[Random().nextInt(shapelist.length)],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(arguments: {
                      'ptname': widget.ptname,
                      'docname': widget.docname,
                      'phone': widget.phone,
                      'day': widget.day,
                      'month': widget.month,
                      'year': widget.year,
                      'id': widget.id
                    }),
                    builder: (context) => SRLCP(
                          scrlp: headlines[headlines.indexOf(e)],
                        )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _iconlist[headlines.indexOf(e)],
              const SizedBox(
                width: 10,
              ),
              Text('${e.toString().toUpperCase()}', textScaleFactor: 2.0)
            ],
          ),
        ),
      );
    }).toList();
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('PaperWork :',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              backgroundColor: Colors.purple[300]?.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              leading: const SizedBox.shrink(),
            ),
            body: Card(
              elevation: 15,
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(5, 5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                )
                              ]),
                          child: MaterialButton(
                            shape: const BeveledRectangleBorder(),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.skip_previous),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Previous'),
                              ],
                            ),
                            onPressed: () {
                              if (_sliderKey.currentState!.hasPrevious) {
                                _sliderKey.currentState?.previous();
                              } else {
                                _sliderKey.currentState!
                                    .setPage(_pages1.indexOf(_pages1.last));
                                return;
                              }
                              setState(() {});
                            },
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(5, 5),
                                spreadRadius: 5,
                                blurRadius: 5,
                              )
                            ]),
                        child: PageView(
                          children: _pages1,
                          key: _sliderKey,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(5, 5),
                                spreadRadius: 5,
                                blurRadius: 5,
                              )
                            ]),
                        child: MaterialButton(
                          shape: const BeveledRectangleBorder(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Next'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.skip_next)
                            ],
                          ),
                          onPressed: () {
                            if (_sliderKey.currentState!.hasNext) {
                              _sliderKey.currentState?.next();
                            } else {
                              _sliderKey.currentState!
                                  .setPage(_pages1.indexOf(_pages1.first));
                              return;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
