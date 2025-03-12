import 'package:flutter/material.dart';
import '../db_helper.dart';

class DiaryPage extends StatefulWidget {
  final String date;
  const DiaryPage({Key? key, required this.date}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadDiaryContent();
  }

  Future<void> _loadDiaryContent() async {
    String? content = await DBHelper().getDiaryContent(widget.date);
    if (content != null) {
      setState(() {
        _controller.text = content;
        _isEditing = true;
      });
    }
  }

  Future<void> _saveDiary() async {
    if (_controller.text.isNotEmpty) {
      await DBHelper().saveDiary(widget.date, _controller.text);
      Navigator.pop(context, true); // ✅ 저장 후 back_view로 이동
    }
  }

  Future<void> _deleteDiary() async {
    await DBHelper().deleteDiary(widget.date);
    Navigator.pop(context, true); // ✅ 삭제 후 back_view로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diary - ${widget.date.replaceFirst('2022', '2025')}"),
        backgroundColor: Color(0xFF9B00D4),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteDiary,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Write your diary...",
                  border: InputBorder.none,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _saveDiary,
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9B00D4)),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

