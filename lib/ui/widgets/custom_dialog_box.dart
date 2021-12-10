import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/utils/province_helper.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
    return SingleChildScrollView(
      child: ResponsiveGridRow(
          children: ProvinceHelper.provinceList.map((e) {
        var index = ProvinceHelper.provinceList.indexOf(e);
        return ResponsiveGridCol(
            xs: 6,
            md: 3,
            sm: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 12),
              child: _buildProvinceCard(index),
            ));
      }).toList()),
    );
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
