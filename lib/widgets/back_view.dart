import 'package:flutter/material.dart';
import '../constants.dart';
import '../db_helper.dart';
import '../diary_page.dart';

class BackView extends StatefulWidget {
  final int monthIndex;
  const BackView({
    Key? key,
    required this.monthIndex,
  }) : super(key: key);

  @override
  State<BackView> createState() => _BackViewState();
}

class _BackViewState extends State<BackView> {
  Set<String> diaryDates = {};

  @override
  void initState() {
    super.initState();
    _loadDiaryDates();
  }

  // ✅ 저장된 다이어리 날짜 불러오기
  Future<void> _loadDiaryDates() async {
    List<String> dates = await DBHelper().getAllDiaryDates();
    setState(() {
      diaryDates = dates.toSet();
    });
  }

  // ✅ 다이어리 페이지 열기 (저장 후 자동 업데이트)
  void _openDiaryPage(BuildContext context, String date) async {
    bool? updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryPage(date: date),
      ),
    );

    if (updated == true) {
      _loadDiaryDates(); // ✅ 저장 후 다이어리 날짜 다시 불러오기
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8.0),
          ],
        ),
        child: Column(
          children: [
            Text(
              '${widget.monthIndex}',
              textScaleFactor: 2.5,
            ),
            const SizedBox(height: 5.0),
            Text(
              months[widget.monthIndex]!.keys.toList()[0],
              textScaleFactor: 2.0,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                itemCount: months[widget.monthIndex]!.values.toList()[0],
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (_, i) {
                  int day = i + 1;
                  String cDay = day < 10 ? '0$day' : '$day';
                  String cMonth =
                  widget.monthIndex < 10 ? '0${widget.monthIndex}' : '${widget.monthIndex}';
                  String date = '2022-$cMonth-$cDay';

                  return GestureDetector(
                    onTap: () => _openDiaryPage(context, date),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: diaryDates.contains(date)
                            ? Colors.green.shade300 // ✅ 다이어리가 있으면 초록색으로 변경
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '$day',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
