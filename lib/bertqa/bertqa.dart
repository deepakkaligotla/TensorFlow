import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tensorflow/bertqa/qa.dart';
import 'package:tensorflow/bertqa/ui/qa_detail.dart';

class BertQA extends StatefulWidget {
  const BertQA({super.key, required this.title});
  final String title;

  @override
  State<BertQA> createState() => _BertQAState();
}

class _BertQAState extends State<BertQA> {
  QA? _qa;

  @override
  void initState() {
    _jsonDecode();
    super.initState();
  }

  void _jsonDecode() async {
    String qaJson = await rootBundle.loadString("assets/qa.json");
    setState(() {
      _qa = QA.fromJson(json.decode(qaJson));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/banner_lite.png"),
                  const Positioned(
                      top: 76,
                      left: 32,
                      child: Text(
                        "TFL Question and Answer",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Please select an article below.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              Expanded(
                  child: ListView.separated(
                itemCount: _qa?.titles?.length ?? 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_qa?.titles![index].toString() ?? ""),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        if (_qa != null) {
                          return QaDetail(
                              title: _qa!.titles![index],
                              content: _qa!.contents![index],
                              questions: _qa!.questions![index]);
                        } else {
                          return const Text("No data to display");
                        }
                      }));
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 1, color: Colors.grey.shade100);
                },
              )),
            ],
          ),
        ));
  }
}
