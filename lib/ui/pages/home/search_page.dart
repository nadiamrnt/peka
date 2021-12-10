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

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search-page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearch(),
              (_query != null || _query == '')
                  ? SizedBox(height: defaultMargin)
                  : SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              _buildIlustration(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: EdgeInsets.only(
        top: 30,
        left: defaultMargin,
        right: defaultMargin,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _query = value;
            });
          },
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: regular,
          ),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: 'Cari Panti Asuhan',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
            ),
            contentPadding: const EdgeInsets.only(right: 8, left: 12),
            filled: true,
            fillColor: kWhiteBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 14.0,
                right: 18,
              ),
              child: Image.asset(
                'assets/icons/ic_search.png',
                width: 24,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIlustration(context) {
    return _query != null
        ? StreamBuilder<QuerySnapshot>(
            stream: Firestore.firebaseFirestore
                .collection('panti_asuhan')
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              List<PantiAsuhanModel> _listPantiAsuhan = snapshot.data!.docs
                  .map((data) => PantiAsuhanModel.fromDatabase(data))
                  .toList();
              _listPantiAsuhan = _listPantiAsuhan
                  .where((pantiAsuhan) => pantiAsuhan.name
                      .toLowerCase()
                      .contains(_query!.toLowerCase()))
                  .toList();

              return snapshot.hasData
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: defaultMargin, right: defaultMargin),
                      child: ResponsiveGridRow(
                          children: _listPantiAsuhan.map((pantiAsuhan) {
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
                                child: CardGridPantiAsuhan(
                                    pantiAsuhan: pantiAsuhan),
                              ),
                            ));
                      }).toList()),
                    )
                  : LottieBuilder.asset('assets/raw/loading.json');
            })
        : Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: Image.asset(
                'assets/images/ill_search.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
