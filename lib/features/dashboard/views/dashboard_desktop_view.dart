import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/bug_card.dart';
import 'package:traq/utils/widgets/myicon.dart';

class DashBoardDesktopView extends ConsumerStatefulWidget {
  const DashBoardDesktopView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardDesktopViewState();
}

class _DashBoardDesktopViewState extends ConsumerState<DashBoardDesktopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ).copyWith(top: 40),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! dashboard
              'DashBoard'.txt(
                isheader: true,
                size: 32,
                fontWeight: FontWeight.w600,
              ),
              40.hSpace,

              //! overview
              'Overview'.toUpperCase().txt14(
                    fontWeight: FontWeight.w500,
                  ),
              16.hSpace, 

              //! active projects
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //! active projects card
                    Container(
                      width: 280,
                      height: 160,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            color: Color(0xFFF2F4F7),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFFFFBEB),
                            child: MyIcon(icon: 'active'),
                          ),
                          16.hSpace,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Active Projects'.txt14(),
                              4.hSpace,
                              '2'.txt24(
                                isheader: true,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    32.wSpace,

                    //! active bugs card
                    Container(
                      width: 280,
                      height: 160,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            color: Color(0xFFF2F4F7),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFF7F4FF),
                            child: MyIcon(icon: 'hourglass'),
                          ),
                          16.hSpace,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Active Bugs'.txt14(),
                              4.hSpace,
                              '2'.txt24(
                                isheader: true,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    32.wSpace,

                    //! resolved bugs card
                    Container(
                      width: 280,
                      height: 160,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            color: Color(0xFFF2F4F7),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFF0FDF4),
                            child: MyIcon(icon: 'resolved'),
                          ),
                          16.hSpace,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Resolved Bugs'.txt14(),
                              4.hSpace,
                              '2'.txt24(
                                isheader: true,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    32.wSpace,
                  ],
                ),
              ),

              40.hSpace,

              //! bugs assigned
              'BUGS ASSIGNED'
                  .txt14(fontWeight: FontWeight.w500)
                  .alignCenterLeft(),
              16.hSpace,

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //! unsolved bugs
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFF4A21C1),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! unsolved
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'UNSOLVED (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.wSpace,

                    //! in progress
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFFF59E0B),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! in progress
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'IN PROGRESS (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.wSpace,

                    //! in review
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFFEF4444),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! in progress
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'IN REVIEW (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    32.wSpace,

                    //! resolved
                    Container(
                      width: 280,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          16.hSpace,

                          //! resolved
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'RESOLVED (2)'
                                    .txt14(fontWeight: FontWeight.w600),
                                const MyIcon(icon: 'morehoriz'),
                              ],
                            ),
                          ),

                          16.hSpace,
                          SizedBox(
                            height: 700,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: Column(
                                children: List.generate(
                                  7,
                                  (index) => const BugCard(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
