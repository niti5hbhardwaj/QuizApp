import 'package:flutter/material.dart';
import 'package:quiz_app/screens/profile/components/util_functions.dart';
import 'inplace_text_editor.dart';

class DetailFieldRow extends StatefulWidget {
  final String fieldName;
  final String fieldData;
  final bool editable;
  const DetailFieldRow({
    super.key,
    required this.fieldName,
    required this.fieldData,
    this.editable = false,
  });

  @override
  State<DetailFieldRow> createState() => _DetailFieldRowState();
}

class _DetailFieldRowState extends State<DetailFieldRow> {
  bool editing = false;
  final TextEditingController _controller = TextEditingController();

  void submit(value) async {
    if (await changePhoneNumber(context, value)) {
      setState(() {
        editing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            widget.fieldName,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.editable) {
                  setState(() {
                    editing = true;
                    if (widget.fieldData == "N.A.") {
                      _controller.text = "";
                    } else {
                      _controller.text = widget.fieldData;
                    }
                  });
                }
              },
              child: (!editing)
                  ? Text(
                      widget.fieldData,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 17,
                      ),
                    )
                  : InPlaceTextEditor(
                      controller: _controller,
                      onSubmitted: (value) {
                        submit(value);
                      },
                    ),
            ),
            (widget.editable)
                ? Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade500,
                    size: (!editing) ? 20 : 1,
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
