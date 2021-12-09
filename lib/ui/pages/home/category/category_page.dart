import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../../common/navigation.dart';
import '../../../../services/firebase/firestore/firestore.dart';
import '../../detail/detail_page.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/category-page';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _category =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              _buildHeader(_category),
              const SizedBox(height: 20),
              Expanded(child: _buildGridView(context, _category)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigation.back();
                },
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 32,
                ),
              ),
              Expanded(
                child: Text(
                  category['name'],
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

  Widget _buildGridView(BuildContext context, Map<String, dynamic> category) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream:
          Firestore.firebaseFirestore.collection('panti_asuhan').snapshots(),
      builder: (_, snapshot) {
        List<PantiAsuhanModel> listPantiAsuhan = [];

        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isNotEmpty) {
          for (var data in snapshot.data!.docs) {
            PantiAsuhanModel dataPanti = PantiAsuhanModel.fromDatabase(data);
            for (var itemKebutuhan in dataPanti.kebutuhan) {
              if (itemKebutuhan.name == category['name']) {
                listPantiAsuhan.add(dataPanti);
              }
            }
          }

          return snapshot.hasData
              ? ResponsiveGridRow(
                  children: listPantiAsuhan.map((pantiAsuhan) {
                  return ResponsiveGridCol(
                      xs: 6,
                      md: 3,
                      sm: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigation.intentWithData(
                                DetailPage.routeName, pantiAsuhan);
                          },
                          child: _pantiCard(pantiAsuhan),
                        ),
                      ));
                }).toList())
              : const CircularProgressIndicator();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _pantiCard(PantiAsuhanModel pantiAsuhan) {
    return Container(
      height: 205,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: kWhiteBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: 131,
              height: 134,
              child: Image.network(
                pantiAsuhan.imgUrl,
                height: 135,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 6),
            child: Text(
              pantiAsuhan.name,
              overflow: TextOverflow.visible,
              maxLines: 1,
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4, left: 10.0, right: 6.0, bottom: 8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/ic_location.png',
                  width: 11,
                  height: 14,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    pantiAsuhan.address.split(', ')[4],
                    style:
                        greyTextStyle.copyWith(fontWeight: light, fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
