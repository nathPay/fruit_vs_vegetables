import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// CharacterCard placeholder
// Displayed when receiving information from stream or future is not done yet
class LoadingCharacterCard extends StatelessWidget {
  const LoadingCharacterCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Stack(
        children: [
          Shimmer.fromColors(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 16.0,
              ),
              Shimmer.fromColors(
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                ),
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[200]!,
                enabled: true,
              ),
              Expanded(child: Container()),
              Shimmer.fromColors(
                child: Container(
                  height: 10.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                ),
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[200]!,
                enabled: true,
              ),
              Expanded(child: Container()),
              Shimmer.fromColors(
                child: Container(
                  height: 10.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                ),
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[200]!,
                enabled: true,
              ),
              SizedBox(
                width: 16.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
