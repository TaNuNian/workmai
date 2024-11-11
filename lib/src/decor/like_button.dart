import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final int likecount;
  final VoidCallback onLikeToggle;
  const LikeButton({
    super.key,
    required this.isLiked,
    required this.likecount,
    required this.onLikeToggle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: onLikeToggle,
            icon: Icon(
              Icons.thumb_up,
              color: isLiked ? Colors.blue : Colors.grey,
            )
        ),
        Text('$likecount'),
      ],
    );
  }
}
