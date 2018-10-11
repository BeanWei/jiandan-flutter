import 'package:flutter/material.dart';
import 'package:jiandan/models/meizi.dart';

class MeiziGridItem extends StatelessWidget {

  final Meizi meizi;
  final VoidCallback onTapped;
  final Size size;
  String _transparentImage = 'assets/image/1x1_transparent.png';

  MeiziGridItem({
    @required this.meizi,
    @required this.onTapped,
    this.size,
  });

  BoxDecoration _buildGradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: <double>[0.0, 0.7, 0.7],
        colors: <Color>[
          Colors.black,
          Colors.transparent,
          Colors.transparent,
        ]
      )
    );
  }

  Widget _buildTextualInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          meizi.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          meizi.title,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70
          )
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (meizi.url == null || meizi.url == '') {
      return null;
    }

    return FadeInImage.assetNetwork(
      placeholder: _transparentImage,
      image: meizi.url,
      width: size?.width,
      height: size?.height,
      fadeInDuration: const Duration(milliseconds: 300),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildImage(),
          Container(
            decoration: _buildGradientBackground(),
            padding: const EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: _buildTextualInfo(),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTapped,
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }

}