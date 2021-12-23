import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/ui/widgets/card_grid_panti_asuhan.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../../common/navigation.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../detail/detail_page.dart';

class CategoryPage extends StatefulWidget {
  static const routeName = '/category-page';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isFromFilter = false;

  @override
  Widget build(BuildContext context) {
    final _category =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (_category.keys.first == 'address') {
      setState(() {
        _isFromFilter = true;
      });
    }

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
                  _isFromFilter ? category['address'] : category['name'],
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
        List<PantiAsuhanModel> approvedPantiAsuhan = [];

        if (snapshot.data == null) {
          return Center(
              child: LottieBuilder.asset(
            'assets/raw/loading.json',
            width: 200,
          ));
        }

        if (snapshot.data!.docs.isNotEmpty) {
          for (var data in snapshot.data!.docs) {
            PantiAsuhanModel dataPanti = PantiAsuhanModel.fromDatabase(data);
            if (_isFromFilter) {
              if (dataPanti.address.split(', ').last == category['address']) {
                listPantiAsuhan.add(dataPanti);
              }
            } else {
              for (var itemKebutuhan in dataPanti.kebutuhan) {
                if (itemKebutuhan.name == category['name']) {
                  listPantiAsuhan.add(dataPanti);
                }
              }
            }
          }

          for (var item in listPantiAsuhan) {
            if (item.approved == true) {
              approvedPantiAsuhan.add(item);
            }
          }

          return !snapshot.hasData
              ? LottieBuilder.asset(
                  'assets/raw/loading.json',
                  width: 200,
                )
              : approvedPantiAsuhan.isNotEmpty
                  ? SingleChildScrollView(
                      child: ResponsiveGridRow(
                          children: approvedPantiAsuhan.map((pantiAsuhan) {
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
                              child:
                                  CardGridPantiAsuhan(pantiAsuhan: pantiAsuhan),
                            ),
                          ),
                        );
                      }).toList()),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          Image.asset(
                            'assets/images/no_data.png',
                            width: 180,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Belum ada panti asuhan',
                            style: greyTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    );
        } else {
          return Center(
            child: Image.asset(
              'assets/images/no_data.png',
              width: 180,
            ),
          );
        }
      },
    );
  }
}
