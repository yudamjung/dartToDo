import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/widget/mybutton.dart';

class TaskBox extends StatefulWidget {
  const TaskBox({super.key, required this.controller, required this.onCancel});
  // TextEditingController는 TextField의 텍스트를 제어(값 읽기,수정 등)하는 데 사용되는 클래스
  final TextEditingController controller;
  final VoidCallback onCancel;

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  // 사용자가 날짜를 선택하지 않을 수도 있으므로 nullable로 선언
  DateTime? _selectedDateTime;

  Future<void> selectDateTime() async {
    // 사용자의 입력이 끝날 때까지 기다리는 Future를 반환하는 showDatePicker 함수를 사용하여 날짜 선택 다이얼로그를 표시
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      // ?? - null-aware operator는 왼쪽 피연산자가 null이 아니면 그 값을 반환하고, null이면 오른쪽 피연산자를 반환
      initialDate:
          _selectedDateTime ??
          DateTime.now(), // 이미 선택된 날짜가 있으면 그 날짜를 초기값으로, 없으면 시스템의 현재 날짜를 초기값으로 설정
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedDateTime != null
            ?
              // 시간과 분을 추출
              TimeOfDay.fromDateTime(_selectedDateTime!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combined = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          _selectedDateTime = combined;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // fromARGB -> a: alpha (투명도), r: red, g: green, b: blue
      backgroundColor: Color.fromARGB(255, 236, 230, 240),
      content: SizedBox(
        height: 380,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: selectDateTime,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width: 2),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  (_selectedDateTime == null)
                      ? "Select Date & Time"
                      : DateFormat(
                          "yyyy-MM-dd HH:mm",
                        ).format(_selectedDateTime!),
                  style: TextStyle(color: Colors.grey[800], fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // code refactoring!
                MyButton(
                  // 사용자 입력 유효성 검사
                  onPressed: () {
                    if (widget.controller.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "할 일을 입력해주세요",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      );
                      return;
                    }
                    // ??= - null-aware assignment operator는 왼쪽 피연산자가 null이면 오른쪽 피연산자를 할당하는 연산자
                    _selectedDateTime ??=
                        DateTime.now(); // 날짜가 선택되지 않은 경우 현재 날짜로 설정
                    Navigator.pop(context, {
                      'task': widget.controller.text,
                      'dateTime': _selectedDateTime,
                    });
                    widget.controller.clear(); // 텍스트 필드를 초기화하여 다음 입력을 준비
                  },
                  buttonName: "Save",
                ),
                SizedBox(width: 20),
                MyButton(onPressed: widget.onCancel, buttonName: "Cancel"),
              ],
            ),
            Lottie.asset("lottie/Checklist.json", width: 150, height: 150),
          ],
        ),
      ),
    );
  }
}
