import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/utils/province_helper.dart';

import '../pages/home/category/category_page.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({Key? key}) : super(key: key);

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 10,
          bottom: defaultMargin,
        ),
        child: Column(
          children: [
            _closeButton(),
            const SizedBox(height: 10),
            Text('Filter berdasarkan lokasimu',
                style: blackTextStyle.copyWith(
                    fontSize: 22, fontWeight: semiBold)),
            const SizedBox(height: 20),
            Expanded(
              child: _buildProvinceList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _closeButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          Navigation.back();
        },
        icon: const Icon(
          Icons.close,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildProvinceList() {
    return GridView.builder(
        itemCount: ProvinceHelper.provinceList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return _buildProvinceCard(index);
        });
  }

  Widget _buildProvinceCard(int index) {
    return GestureDetector(
      onTap: () {
        Navigation.intentReplacementWithData(CategoryPage.routeName,
            {'name': ProvinceHelper.provinceList[index]});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: kBlueBgColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(ProvinceHelper.provinceList[index],
              textAlign: TextAlign.center,
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: regular)),
        ),
      ),
    );
  }
}
