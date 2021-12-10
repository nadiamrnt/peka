import 'package:flutter/material.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';

import '../../common/styles.dart';

class CardGridPantiAsuhan extends StatefulWidget {
  final PantiAsuhanModel pantiAsuhan;
  const CardGridPantiAsuhan({Key? key, required this.pantiAsuhan})
      : super(key: key);

  @override
  State<CardGridPantiAsuhan> createState() => _CardGridPantiAsuhanState();
}

class _CardGridPantiAsuhanState extends State<CardGridPantiAsuhan> {
  @override
  Widget build(BuildContext context) {
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
              width: double.infinity,
              height: 134,
              child: Image.network(
                widget.pantiAsuhan.imgUrl,
                height: 135,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 6),
            child: Text(
              widget.pantiAsuhan.name,
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
                    widget.pantiAsuhan.address.split(', ')[4],
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
