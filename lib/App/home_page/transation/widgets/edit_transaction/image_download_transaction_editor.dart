import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/image_service.dart';


class ImageDownloadTransactionEditos extends ConsumerStatefulWidget {
  final String path;
  const ImageDownloadTransactionEditos({super.key, required this.path});

  @override
  ConsumerState<ImageDownloadTransactionEditos> createState() => _ImageDownloadTransactionEditosState();
}

class _ImageDownloadTransactionEditosState extends ConsumerState<ImageDownloadTransactionEditos> {

  @override
  Widget build(BuildContext context) {
    
    final imagedatabase = ref.watch(imageService);
    return FutureBuilder(
      future: imagedatabase.downloadImage(widget.path),
      builder: ((context, snapshot) {
        if(snapshot.hasError){
          return Icon(Icons.warning);
        }else if(snapshot.hasData){
          return Image.network(snapshot.data!);
        }else{
          return const CircularProgressIndicator();
        }
      })
    );
  }
}