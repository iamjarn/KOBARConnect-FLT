import 'package:flutter/material.dart';
import 'package:kobar/UI/Models/Place.dart';

class PlaceCard extends StatefulWidget {
  final Function onClick;
  final Place place;

  PlaceCard({Key? key, required this.onClick, required this.place});

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  double card_height = 180;
  double card_width = 150;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: card_width,
        height: card_height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.place.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: card_height * 50 / 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        end: Alignment.center,
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ])),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  widget.place.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
