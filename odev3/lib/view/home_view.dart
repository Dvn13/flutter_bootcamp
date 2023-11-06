import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odev3/_widget/custom_chip.dart';
import 'package:odev3/constants/color/const_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //Loalizations
    var localizations = AppLocalizations.of(context);

    //Screen Info
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWeight = screenInfo.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations!.purchase,
          style:
              const TextStyle(color: ConstColors.white, fontFamily: 'Pasific'),
        ),
        backgroundColor: ConstColors.lightNavy,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: screenWeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'img/login.png',
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      packetType(
                          title: localizations.simpleSecurityTitle,
                          desc: localizations.simpleSecurityDesc,
                          chipBgcolor: ConstColors.azure),
                      packetType(
                          title: localizations.mediumSecurityTitle,
                          desc: localizations.mediumSecurityDesc,
                          chipBgcolor: ConstColors.macaroniAndCheese),
                      packetType(
                          title: localizations.highSecurityTitle,
                          desc: localizations.highSecurityDesc,
                          chipBgcolor: ConstColors.coral),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButton(
                      buttonText: localizations.freeTrial,
                      screenWeight: screenWeight,
                      bgColor: ConstColors.cobalt,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    buildButton(
                      buttonText: localizations.starMembership,
                      screenWeight: screenWeight,
                      bgColor: ConstColors.azure,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(
      {required String buttonText,
      required double screenWeight,
      required Color bgColor}) {
    return Expanded(
      child: SizedBox(
        child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: bgColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 18, color: ConstColors.white),
            )),
      ),
    );
  }

  Widget packetType(
      {required String title,
      required String desc,
      required Color chipBgcolor}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomChip(
            text: title,
            textColor: ConstColors.white,
            bcColor: chipBgcolor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(desc),
          )
        ],
      ),
    );
  }
}
