import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExplanationData {
  final String title;
  final String description;
  final String localImageSrc;
  final Color backgroundColor;

  ExplanationData(
      {this.title, this.description, this.localImageSrc, this.backgroundColor});
}

final List<ExplanationData> data = [
  ExplanationData(
      description:
          "Sur l'application Bricola.",
      title: "Bienvenue",
      localImageSrc: "images/asset/svg1.svg",
      backgroundColor: Colors.orange[500]),
  ExplanationData(
      description:
          "Un moyen facile de communiquer avec nos employés, restez simplement à la maison.",
      title: "Nous vous montrons",
      localImageSrc: "images/asset/svg2.svg",
      backgroundColor: Colors.orange[700]),
  ExplanationData(
      description:
          "A vous connecter avec des employés à travers le pays.",
      title: "Nous vous aidons",
      localImageSrc: "images/asset/svg3.svg",
      backgroundColor: Colors.green[800]),
];

class ExplanationPage extends StatelessWidget {
  final ExplanationData data;

  ExplanationPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 24, bottom: 16),
            child: SvgPicture.asset(data.localImageSrc,
                height: MediaQuery.of(context).size.height * 0.33,
                alignment: Alignment.center)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.title,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}