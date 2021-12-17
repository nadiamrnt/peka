import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../common/navigation.dart';
import '../../common/styles.dart';
import 'button.dart';
import 'custom_text_form_field.dart';
import 'custom_toast.dart';

class DialogReview extends StatefulWidget {
  const DialogReview({Key? key}) : super(key: key);

  @override
  _DialogReviewState createState() => _DialogReviewState();
}

class _DialogReviewState extends State<DialogReview> {
  final _ucapanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Pesan untuk donatur',
            style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18.0),
        ),
      ),
      content: Container(
        height: 220,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
                hintText: "Tulis ucapan kebaikan untuk donatur",
                errorText: "Tulis ucapan kebaikan untuk donatur",
                controller: _ucapanController),
            const SizedBox(height: 16),
            Button(
              textButton: 'Kirim',
              onTap: () async {
                Navigation.back();
                SmartDialog.showToast(
                  '',
                  widget: const CustomToast(
                    msg: 'Kirim ucapan telah berhasil',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
