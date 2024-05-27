
import 'package:flutter/material.dart';

import '../mixin/image_picker_mixin.dart';

class CustomImgPickerAvatar extends StatefulWidget {
  const CustomImgPickerAvatar({
    super.key,
  });

  @override
  State<CustomImgPickerAvatar> createState() => _CustomImgPickerAvatarState();
}

class _CustomImgPickerAvatarState extends State<CustomImgPickerAvatar> with ImagePickerStateHelper<CustomImgPickerAvatar> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            showPickerDialog((base64) => setBase64Image(base64));
          },
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: CircleAvatar(
                      backgroundImage: image.image,
                      minRadius: 0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0.0, 1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.black.withOpacity(
                            0.2,
                          ),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: ImageIcon(
                        AssetImage('assets/img/camera_tab.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
