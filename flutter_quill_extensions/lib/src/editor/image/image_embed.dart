import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../common/utils/element_utils/element_utils.dart';
import 'config/image_config.dart';
import 'image_menu.dart';
import 'widgets/image.dart';

class QuillEditorImageEmbedBuilder extends EmbedBuilder {
  QuillEditorImageEmbedBuilder({
    required this.config,
  });

  final QuillEditorImageEmbedConfig config;

  @override
  String get key => BlockEmbed.imageType;

  @override
  bool get expanded => false;

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    final imageSource = standardizeImageUrl(embedContext.node.value.data);
    final ((imageSize), margin, alignment) = getElementAttributes(
      embedContext.node,
      context,
    );

    final width = imageSize.width;
    final height = imageSize.height;

    final imageWidget = getImageWidgetByImageSource(
      context: context,
      imageSource,
      imageProviderBuilder: config.imageProviderBuilder,
      imageErrorWidgetBuilder: config.imageErrorWidgetBuilder,
      alignment: alignment,
      height: height,
      width: width,
    );

    return GestureDetector(
      onTap: () {
        // final onImageClicked = config.onImageClicked;
        // if (onImageClicked != null) {
        //   onImageClicked(imageSource);
        //   return;
        // }
        // showDialog(
        //   context: context,
        //   builder: (_) => ImageOptionsMenu(
        //     controller: embedContext.controller,
        //     config: config,
        //     imageSource: imageSource,
        //     imageSize: imageSize,
        //     readOnly: embedContext.readOnly,
        //     imageProvider: imageWidget.image,
        //   ),
        // );
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageWidget,
                ),
              );
            },
          ),
          // IconButton(
          //   onPressed: () async {
          //     // Call the remove check callback if set
          //     if (await config.shouldRemoveImageCallback?.call(imageSource) ==
          //         false) {
          //       return;
          //     }
          //
          //     final offset = getEmbedNode(
          //       embedContext.controller,
          //       embedContext.controller.selection.start,
          //     ).offset;
          //
          //     log("0908898989898989898  ${embedContext.controller}");
          //     log("0908898989898989898  ${offset}");
          //     // embedContext.controller.replaceText(
          //     //   offset,
          //     //   1,
          //     //   '',
          //     //   TextSelection.collapsed(offset: offset),
          //     // );
          //     // // Call the post remove callback if set
          //     // await config.onImageRemovedCallback.call(imageSource);
          //   },
          //   icon: const Icon(
          //     CupertinoIcons.clear_circled_solid,
          //     size: 30,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}
