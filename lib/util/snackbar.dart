import 'package:flutter/material.dart';

import '../theme.dart';

Icon sadIcon() {
  return const Icon(
    Icons.sentiment_dissatisfied,
    color: Color(0x15000000),
    size: 120,
  );
}

Icon happyIcon() {
  return const Icon(
    Icons.sentiment_very_satisfied,
    color: Color(0x15000000),
    size: 120,
  );
}

Icon infoIcon() {
  return const Icon(
    Icons.info,
    color: Color(0x15000000),
    size: 120,
  );
}

void showFailSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  var snackBar = SnackBar(
      elevation: 4,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 2200),
      content: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffff5252),
              Color.fromARGB(255, 181, 68, 60),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            marginV12(
              child: paddingH12(
                child: Text(
                  text,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: captionText(context,
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackBar(BuildContext context, String text) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(milliseconds: 2200),
    content: Container(
      constraints: const BoxConstraints(
        minHeight: 60,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff00E676),
            Color.fromARGB(255, 0, 150, 78),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          marginV12(
            child: paddingH12(
              child: Text(
                text,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: captionText(context,
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            top: -22,
            left: -18,
            child: SizedBox(
              height: 65,
              child: Transform.rotate(
                angle: -30 * 3.14 / 180,
                child: happyIcon(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showMessageSnackBar(BuildContext context, String text) {
  // ScaffoldMessenger.of(context).removeCurrentSnackBar();
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(milliseconds: 2200),
    content: Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 15, 130, 245),
            Color.fromARGB(255, 8, 90, 173),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          marginV12(
            child: paddingH12(
              child: Text(
                text,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: captionText(context,
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            top: -22,
            left: -18,
            child: SizedBox(
              height: 65,
              child: Transform.rotate(
                angle: -30 * 3.14 / 180,
                child: infoIcon(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
