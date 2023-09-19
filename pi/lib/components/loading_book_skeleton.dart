import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class LoadingHomeBookSkeleton extends StatefulWidget {
  const LoadingHomeBookSkeleton({super.key});

  @override
  State<LoadingHomeBookSkeleton> createState() =>
      _LoadingHomeBookSkeletonState();
}

class _LoadingHomeBookSkeletonState extends State<LoadingHomeBookSkeleton> {
  @override
  Widget build(BuildContext context) {
    return MirrorAnimation(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutSine,
      tween: ColorTween(begin: Colors.black12, end: Colors.black87),
      builder: (context, child, value) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image place
              Container(
                decoration: BoxDecoration(
                  color: value,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(aspectRatio: 8 / 12, child: Row()),
              ),

              const SizedBox(height: 10),

              // Text Simulating
              Container(
                height: 13,
                decoration: BoxDecoration(
                  color: value,
                  borderRadius: BorderRadius.circular(5),
                ),
                constraints: const BoxConstraints(
                  maxWidth: 85,
                ),
              ),

              const SizedBox(height: 4.250),

              Container(
                height: 13,
                decoration: BoxDecoration(
                  color: value,
                  borderRadius: BorderRadius.circular(5),
                ),
                constraints: const BoxConstraints(
                  maxWidth: 135,
                ),
              ),

              const SizedBox(height: 4.250),

              Container(
                height: 13,
                decoration: BoxDecoration(
                  color: value,
                  borderRadius: BorderRadius.circular(5),
                ),
                constraints: const BoxConstraints(
                  maxWidth: 60,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
