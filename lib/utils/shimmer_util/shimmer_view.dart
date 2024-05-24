import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  const ShimmerView({super.key, this.shimmerType});

  final dynamic shimmerType;

  @override
  Widget build(BuildContext context) {
    return shimmerType == "list"
        ? ListView.builder(
            itemCount: 10, // Replace with the actual number of items you expect
            itemBuilder: (context, index) {
              // Show shimmer while data is loading
              return const ShimmerGridItem(
                  width: double.infinity, height: 100.0); // Adjust width/height
            },
          )
        : shimmerType == "grid"
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust number of columns as needed
                  mainAxisSpacing: 10.0, // Adjust spacing between items
                  crossAxisSpacing: 10.0,
                ),
                itemCount:
                    10, // Replace with the actual number of items you expect
                itemBuilder: (context, index) {
                  // Show shimmer while data is loading
                  return ShimmerGridItem(
                      width: 150.0, height: 150.0); // Adjust width/height
                },
              )
            : const SizedBox.shrink();
  }
}

class ShimmerGridItem extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerGridItem({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Adjust base color as needed
      highlightColor: Colors.grey[100]!, // Adjust highlight color as needed
      child: Container(
        width: width,
        height: height,
        color: Colors.white, // Optional background color for clarity
      ),
    );
  }
}
