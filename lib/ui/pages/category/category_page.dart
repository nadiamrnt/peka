import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/utils/panti_helper.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Expanded(child: _buildGridView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                //TODO:: navigation back
                onTap: () {},
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 32,
                ),
              ),
              Expanded(
                child: Text(
                  'Beras',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.73,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15),
      itemBuilder: (context, index) {
        return pantiCard(index);
      },
      itemCount: PantiHelper.pantiFromLocal.length,
    );
  }

  Widget pantiCard(int index) {
    return Container(
      height: 219,
      width: 144,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: kWhiteBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              PantiHelper.pantiFromLocal[index]['image'],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              PantiHelper.pantiFromLocal[index]['name'],
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/ic_location.png',
                  width: 10.2,
                ),
                const SizedBox(width: 5),
                Text(
                  PantiHelper.pantiFromLocal[index]['location'],
                  style:
                      greyTextStyle.copyWith(fontWeight: light, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}