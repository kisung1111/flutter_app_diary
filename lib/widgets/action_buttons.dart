import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActionButtons extends StatefulWidget {
  final Function change;
  const ActionButtons({super.key, required this.change});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isFront = true;

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat("MMM d, yyyy").format(DateTime.now()); // 오늘 날짜 자동 설정

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // today chip (오늘 날짜)
          Container(
            width: 155.0,
            height: 50.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wb_sunny_rounded),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        todayDate, // ✅ 오늘 날짜 표시
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // edit button
          Container(
            width: 50.0,
            height: 50.0,
            decoration: const BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mode_edit_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10.0),
          // calendar switch button
          GestureDetector(
            onTap: () {
              widget.change();
              setState(() {
                isFront = !isFront;
              });
            },
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: isFront ? Colors.black87 : Color(0xFF9B00D4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFront ? Icons.calendar_month_rounded : Icons.undo_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
