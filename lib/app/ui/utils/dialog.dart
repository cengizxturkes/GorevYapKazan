import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../../../core/init/theme/color_manager.dart';

class KaracaUtils {
  showGeneralDialog(
    BuildContext context, {
    String? title,
    bool? dismissible,
    required Widget body,
    Widget? icon,
  }) {
    return showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(barrierDismissible: dismissible ?? true),
      // barrierDismissible: dismissible ?? true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ), //this right here
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    title != null
                        ? Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: ColorManager.instance.darkGray,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                body
              ],
            ),
          ),
        );
      },
    );
  }
}
