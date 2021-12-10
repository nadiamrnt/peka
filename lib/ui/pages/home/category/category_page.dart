import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/ui/widgets/card_grid_panti_asuhan.dart';
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
          return Center(child: LottieBuilder.asset('assets/raw/loading.json'));
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
              ? SingleChildScrollView(
                  child: ResponsiveGridRow(
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
                          child: CardGridPantiAsuhan(pantiAsuhan: pantiAsuhan),
                        ),
                      ),
                    );
                  }).toList()),
                )
              : LottieBuilder.asset('assets/raw/loading.json');
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
