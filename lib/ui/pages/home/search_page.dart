import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearch(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
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
    return Center(
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
}
