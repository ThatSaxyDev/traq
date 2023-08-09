import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/myicon.dart';

class BugCard extends ConsumerWidget {
  const BugCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFF2F4F7),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //! priority tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEF2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: 'High Priority'.txt(
                  size: 10,
                  color: const Color(0xFFEF4444),
                ),
              ),

              // date
              'Mon, August 7'.txt12(
                color: const Color(0xFF9CA3AF),
              ),
            ],
          ),
          8.hSpace,

          //! title
          'Android app crashing on home screen Android app crashing on home screen Android app crashing on home screen'
              .txt14(
            fontWeight: FontWeight.w600,
            isheader: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          4.hSpace,

          //! description
          'Android app crashing on home screen Android app crashing on home screen Android app crashing on home screen'
              .txt14(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          16.hSpace,
          //! images row

          Row(
            children: [
              //! images
              SizedBox(
                height: 24,
                width: 40,
                child: Stack(
                  children: List.generate(
                    2,
                    (index) => Positioned(
                      left: switch (index) {
                        0 => 0,
                        _ => (15 * index).toDouble(),
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Pallete.whiteColor,
                        child: CircleAvatar(
                          radius: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),

              //! comment
              const MyIcon(icon: 'comment', height: 16),
              4.wSpace,
              '3'.txt12(),
              12.wSpace,

              //! attachment
              const MyIcon(icon: 'attachment', height: 16),
              4.wSpace,
              '3'.txt12(),
            ],
          ),
        ],
      ),
    );
  }
}
