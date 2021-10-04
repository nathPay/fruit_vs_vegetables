import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// FightCard placeholder
// displayed when receiving information from stream or future is not done yet
class LoadingFightCard extends StatelessWidget {
  const LoadingFightCard({
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
              Column(
                children: [
                  Expanded(child: Container()),
                  Shimmer.fromColors(
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[200]!,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      height: 8.0,
                      width: 50.0,
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
                ],
              ),
              Expanded(child: Container()),
              Shimmer.fromColors(
                child: Container(
                  height: 16.0,
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
              Column(
                children: [
                  Expanded(child: Container()),
                  Shimmer.fromColors(
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[200]!,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      height: 8.0,
                      width: 50.0,
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
                ],
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
