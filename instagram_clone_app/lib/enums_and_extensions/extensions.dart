import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/dialogs/generic_dialog.dart';
import 'package:instagram_clone_app/enums_and_extensions/enums.dart';

//Extension for the AlertDialogModel and all classes extending it
extension ShowAlertDialog<T> on AlertDialogModel<T>{
  Future<T?> showAlertDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title), content: Text(message),
        actions: buttons.entries.map((entry) => TextButton(
          onPressed: () => Navigator.of(context).pop(entry.value),          
          child: Text(entry.key)
        )).toList()
      )
    );
  }
}


extension GetImageAspectRatio on Image{
  Future<double> getImageAspectRatio() async{
    final completer = Completer<double>();
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((imageInfo, synchronousCall) {
        final aspectRatio = imageInfo.image.width / imageInfo.image.height;
        imageInfo.image.dispose();
        completer.complete(aspectRatio);
      })
    );
    return completer.future;
  }
}


extension GetImageDataAspectRatio on Uint8List{
  Future<double> getBytesASpectRatio(){
    final image = Image.memory(this);
    return image.getImageAspectRatio();
  }
}


extension CollectionNameFromFileType on FileType{
  String get collectionName {
    switch(this){
      case FileType.image: return 'images';
      case FileType.video: return 'videos';
    }
  }
}