import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({required this.msg, this.isError = false, Key? key})
      : super(key: key);

  final String msg;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
                color: kBlackColor.withOpacity(0.25),
                blurRadius: 6,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isError
                    ? Colors.red.withOpacity(0.2)
                    : Colors.green.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Container(
                  width: 24,
                  height: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration: BoxDecoration(
                    color: isError ? Colors.red : Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    child: Icon(
                      isError ? Icons.close : Icons.done_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    alignment: Alignment.center,
                  )),
            ),
            Text(msg, style: blackTextStyle.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
