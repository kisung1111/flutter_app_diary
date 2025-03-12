import 'package:flutter/material.dart';
import '../constants.dart';
import '../db_helper.dart';

class FrontView extends StatefulWidget {
  final int monthIndex;
  const FrontView({Key? key, required this.monthIndex}) : super(key: key);

  @override
  _FrontViewState createState() => _FrontViewState();
}

class _FrontViewState extends State<FrontView> {
  int diaryCount = 0;

  @override
  void initState() {
    super.initState();
    _loadDiaryCount();
  }

  Future<void> _loadDiaryCount() async {
    int count = await DBHelper().getDiaryCountForMonth(widget.monthIndex);
    setState(() {
      diaryCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xFF9B00D4),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8.0),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.monthIndex}',
              textScaleFactor: 3.5,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              months[widget.monthIndex]!.keys.toList()[0],
              textScaleFactor: 2.5,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ 여기에 다이어리 개수 반영
                      Text(
                        '$diaryCount/${months[widget.monthIndex]!.values.toList()[0]}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Container(
                        width: double.infinity,
                        height: 3.0,
                        color: Colors.white30,
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: diaryCount /
                              months[widget.monthIndex]!.values.toList()[0],
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 30.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
