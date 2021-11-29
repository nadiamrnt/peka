import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/kelola_panti/register_page.dart';
import 'package:peka/ui/widgets/button.dart';

class IntroKelolaPage extends StatefulWidget {
  const IntroKelolaPage({Key? key}) : super(key: key);

  @override
  State<IntroKelolaPage> createState() => _IntroKelolaPageState();
}

//INI ADALAH HALAMAN KELOLA PANTI 1
class _IntroKelolaPageState extends State<IntroKelolaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ILLUSTRASI KELOLA PANTIA ASUHAN
                Center(
                  child: SizedBox(
                    width: 312,
                    height: 211,
                    child: Image.asset(
                      'assets/images/ill_kelola.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //TEXT SEGERA DAFTARKAN PANTI ASUHANMU
                Center(
                  child: Text(
                    "Segera daftarkan \npanti asuhanmu",
                    style: blackTextStyle.copyWith(
                      fontSize: 24.0,
                      fontWeight: semiBold,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                //TEXT DESKRIPSI PERSETUJUAN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Center(
                    child: Text(
                      "Anda dapat mendaftarkan panti asuhan serta mendeskripsikan kebutuhan. Namun pihak Peka tidak menjamin seluruh kebutuhan dapat terpenuhi. Dengan melanjutkan, Anda setuju untuk mengisi data dengan sebenar-benarnya.",
                      style: greyTextStyle.copyWith(
                        fontSize: 14.0,
                        fontWeight: regular,
                      ),
                      maxLines: 7,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                //BUTTON DAFTAR PANTI
                Button(
                  textButton: "Daftar",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
