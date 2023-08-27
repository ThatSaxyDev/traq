// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_notifier/simple_notifier.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';

import 'package:traq/features/reports/controllers/reports_controller.dart';
import 'package:traq/features/reports/widgets/bug_deets.dart';
import 'package:traq/models/bug_model.dart';
import 'package:traq/models/comment_model.dart';
import 'package:traq/models/user_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/keyboard_utils.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/image_loader.dart';
import 'package:traq/utils/widgets/myicon.dart';
import 'package:traq/utils/widgets/text_input.dart';

class BugDetailsBottomSheet extends ConsumerStatefulWidget {
  final BugModel bugg;
  const BugDetailsBottomSheet({
    super.key,
    required this.bugg,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BugDetailsBottomSheetState();
}

class _BugDetailsBottomSheetState extends ConsumerState<BugDetailsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  ValueNotifier<String> statusValue = ''.notifier;
  List<String> statuses = ['unsolved', 'in progress', 'in review', 'solved'];

  @override
  Widget build(BuildContext context) {
    AsyncValue<BugModel> bugStream =
        ref.watch(getBugByIdProvider(widget.bugg.id));
    UserModel? user = ref.watch(userProvider);
    return DefaultTabController(
      length: 3,
      child: Container(
        height: height(context) * 0.92,
        width: width(context),
        color: Pallete.whiteColor,
        child: bugStream.when(
          data: (BugModel bug) {
            return Column(
              children: [
                Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: switch (bug.priority) {
                      'Critical' => Pallete.criticalDarker,
                      'High' => Pallete.highDarker,
                      'Medium' => Pallete.mediumDarker,
                      _ => Pallete.lowDarker,
                    },
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          size: 30.sp,
                          color: Colors.white,
                        ),
                      ).tap(onTap: () {
                        Navigator.of(context).pop();
                      }),
                      'Report'.txt(
                        size: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                10.sbH,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: 20.padH,
                          child: Column(
                            children: [
                              //! TITLE
                              bug.bugName
                                  .txt(
                                    size: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    isheader: true,
                                  )
                                  .alignCenterLeft(),
                              16.sbH,
                              //! status
                              BugDeets(
                                height: 30.h,
                                icon: 'status',
                                title: 'Status',
                                content: PopupMenuButton<String>(
                                  surfaceTintColor: Colors.white,
                                  color: Colors.white,
                                  tooltip: '',
                                  position: PopupMenuPosition.under,
                                  padding: EdgeInsets.zero,
                                  onSelected: (value) {
                                    switch (value) {
                                      case 'in progress':
                                        ref
                                            .read(reportsControllerProvider
                                                .notifier)
                                            .updateBugStatusInProgress(
                                              context: context,
                                              bug: bug.copyWith(status: value),
                                              sideEffect: () {
                                                statusValue.value = value;
                                              },
                                            );
                                        break;
                                      case 'unsolved':
                                        ref
                                            .read(reportsControllerProvider
                                                .notifier)
                                            .updateBugStatusUbsolved(
                                              context: context,
                                              bug: bug.copyWith(status: value),
                                              sideEffect: () {
                                                statusValue.value = value;
                                              },
                                            );
                                        break;
                                      case 'in review':
                                        ref
                                            .read(reportsControllerProvider
                                                .notifier)
                                            .updateBugStatusInReview(
                                              context: context,
                                              bug: bug.copyWith(status: value),
                                              sideEffect: () {
                                                statusValue.value = value;
                                              },
                                            );
                                        break;
                                      case 'solved':
                                        ref
                                            .read(reportsControllerProvider
                                                .notifier)
                                            .updateBugStatusSolved(
                                              context: context,
                                              bug: bug.copyWith(status: value),
                                              sideEffect: () {
                                                statusValue.value = value;
                                              },
                                            );
                                        break;
                                      default:
                                    }
                                  },
                                  icon: TransparentButton(
                                    height: 30.h,
                                    width: 151.w,
                                    onTap: null,
                                    isText: false,
                                    item: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        statusValue.listen(
                                          builder: (context, value, child) =>
                                              switch (statusValue.value) {
                                            '' => bug.status.toTitleCase().txt(
                                                  size: 14.sp,
                                                  isheader: true,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            _ => statusValue.value
                                                .toTitleCase()
                                                .txt(
                                                  size: 14.sp,
                                                  isheader: true,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          },
                                        ),
                                        3.sbW,
                                        Icon(Icons.keyboard_arrow_down,
                                            color: Colors.black, size: 20.sp),
                                      ],
                                    ),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return statuses.map((choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        // 'Critical', 'High', 'Medium', 'Low'
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 5.h),
                                          decoration: BoxDecoration(
                                              // color: switch (choice) {
                                              //   'Critical' => Pallete.critical,
                                              //   'High' => Pallete.high,
                                              //   'Medium' => Pallete.medium,
                                              //   _ => Pallete.low,
                                              // },
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          child: Text(
                                            choice,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                                // TransparentButton(
                                //   height: 30.h,
                                //   width: 151.w,
                                //   onTap: () {},
                                //   isText: false,
                                //   item: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       bug.status.toTitleCase().txt(
                                //             size: 14.sp,
                                //             isheader: true,
                                //             fontWeight: FontWeight.w600,
                                //           ),
                                //       3.sbW,
                                //       Icon(Icons.keyboard_arrow_down,
                                //           color: Colors.black, size: 20.sp),
                                //     ],
                                //   ),
                                // ),
                              ),
                              16.sbH,

                              //! project
                              BugDeets(
                                icon: 'projunmob',
                                title: 'Project',
                                content: bug.projectName.txt(
                                  size: 14.sp,
                                  isheader: true,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              16.sbH,

                              //! version
                              BugDeets(
                                icon: 'version',
                                title: 'Version',
                                content: getVersion(bug.version).txt(
                                  size: 14.sp,
                                  isheader: true,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              16.sbH,

                              //! assignee
                              BugDeets(
                                height: 30.h,
                                icon: 'assignee',
                                title: 'Assignee',
                                content: TransparentButton(
                                  height: 30.h,
                                  width: 151.w,
                                  onTap: () {},
                                  isText: false,
                                  item: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      'Assign member'.txt(
                                        size: 14.sp,
                                        isheader: true,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      3.sbW,
                                      Icon(PhosphorIcons.plus,
                                          color: Colors.black, size: 20.sp),
                                    ],
                                  ),
                                ),
                              ),
                              16.sbH,

                              //! Priority
                              BugDeets(
                                height: 28.h,
                                icon: 'priority',
                                title: 'Priority',
                                content: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: ShapeDecoration(
                                    color: switch (bug.priority) {
                                      'Critical' => Pallete.critical,
                                      'High' => Pallete.high,
                                      'Medium' => Pallete.medium,
                                      _ => Pallete.low,
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                  ),
                                  child: bug.priority.txt(
                                    size: 12.sp,
                                    color: switch (bug.priority) {
                                      'Critical' => Pallete.criticalDarker,
                                      'High' => Pallete.highDarker,
                                      'Medium' => Pallete.mediumDarker,
                                      _ => Pallete.lowDarker,
                                    },
                                  ),
                                ),
                              ),
                              16.sbH,

                              //! date
                              BugDeets(
                                icon: 'date',
                                title: 'Date',
                                content: DateFormat.yMMMEd()
                                    .format(bug.createdAt!)
                                    .txt(
                                      size: 14.sp,
                                      isheader: true,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              30.sbH,
                            ],
                          ),
                        ),
                        Container(
                          height: 35.h,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                          ),
                          child: TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                width: 1.5,
                                color: switch (bug.priority) {
                                  'Critical' => Pallete.criticalDarker,
                                  'High' => Pallete.highDarker,
                                  'Medium' => Pallete.mediumDarker,
                                  _ => Pallete.lowDarker,
                                },
                              )),
                            ),
                            labelColor: Pallete.blackColor,
                            unselectedLabelColor: Pallete.blackColor,
                            labelStyle: TextStyle(
                              color: const Color(0xFF111827),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: TextStyle(
                              color: const Color(0xFF111827),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            tabs: const [
                              Tab(
                                text: 'DESCRIPTION',
                              ),
                              Tab(
                                text: 'PLATFORM/DEVICE',
                              ),
                              Tab(
                                text: 'SCREENSHOTS/ATTACHMENTS',
                              ),
                            ],
                          ),
                        ),
                        //! description , platform
                        SizedBox(
                          height: 228.h,
                          child: TabBarView(
                            children: [
                              //! description
                              SizedBox(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 16.h),
                                  child: bug.description.txt(size: 14.sp),
                                ),
                              ),

                              //! platform
                              SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 16.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyIcon(
                                        icon: 'device',
                                        height: 20.h,
                                      ),
                                      8.sbW,
                                      bug.platformDevice.txt(size: 14.sp),
                                    ],
                                  ),
                                ),
                              ),

                              //! attachments
                              SizedBox(
                                child: Center(
                                  child: ImageLoader(
                                    height: 210.h,
                                    width: 210.h,
                                    radius: 4.r,
                                    imageUrl: bug.imageUrl,
                                  ),
                                ),
                                //  SingleChildScrollView(
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: 20.w, vertical: 16.h),
                                //   child:
                                //    Wrap(
                                //     children: List.generate(
                                //       1,
                                //       (index) => Container(
                                //         height: 100.h,
                                //         width: 100.h,
                                //         decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(4.r),
                                //           image: DecorationImage(
                                //             image: NetworkImage(bug.imageUrl),
                                //             fit: BoxFit.cover,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: 20.padH,
                          height: 0.8,
                          color: const Color(0xFFE5E7EB),
                        ),
                        26.sbH,

                        //! comments
                        Row(
                          children: [
                            20.sbW,
                            'COMMENTS'.txt(
                              color: const Color(0xFF6B7280),
                              size: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            8.sbW,
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF2F4F7),
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: bug.comments.length.toString().txt(
                                    color: const Color(0xFF6B7280),
                                    size: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),

                        //! comment input
                        Padding(
                          padding: 20.padH,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextInputWidget(
                                width: 245.w,
                                maxLines: 1,
                                hintText: 'Add a comment',
                                inputTitle: '',
                                controller: _commentController,
                                onChanged: (value) {},
                              ),
                              ref.watch(reportsControllerProvider) == true
                                  ? SizedBox(
                                      height: 44.h,
                                      width: 74.w,
                                      child: Loadinggg(
                                        height: 40.h,
                                      ),
                                    )
                                  : TransparentButton(
                                      onTap: () {
                                        ref
                                            .read(reportsControllerProvider
                                                .notifier)
                                            .comment(
                                              context: context,
                                              bug: bug,
                                              content: _commentController.text,
                                              sideEffect: () {
                                                _commentController.clear();
                                              },
                                            );
                                      },
                                      height: 44.h,
                                      width: 74.w,
                                      text: 'Send',
                                    ),
                            ],
                          ),
                        ),
                        24.sbH,

                        ref.watch(getAllCommentsForaBugProvider(bug.id)).when(
                          data: (List<Comment> comments) {
                            return Column(
                              children: [
                                ...List.generate(
                                  comments.length,
                                  (index) => Container(
                                    padding: 20.padH,
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //! image
                                            ref
                                                .watch(getUserProvider(
                                                    comments[index].userId))
                                                .when(
                                                    data: (UserModel userData) =>
                                                        CircularImageLoader(
                                                            dimension: 32.h,
                                                            imageUrl: userData
                                                                .profilePic!),
                                                    error: (error, stackTrace) =>
                                                        CircularImageLoader(
                                                            dimension: 32.h,
                                                            imageUrl:
                                                                comments[index]
                                                                    .userImage),
                                                    loading: () =>
                                                        CircularImageLoader(
                                                            dimension: 32.h,
                                                            imageUrl:
                                                                comments[index]
                                                                    .userImage)),

                                            8.sbW,
                                            ref
                                                .watch(getUserProvider(
                                                    comments[index].userId))
                                                .when(
                                                    data:
                                                        (UserModel userData) =>
                                                            userData.name!.txt(
                                                              size: 14.sp,
                                                              isheader: true,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                    error: (error,
                                                            stackTrace) =>
                                                        comments[index]
                                                            .userName
                                                            .txt(
                                                              size: 14.sp,
                                                              isheader: true,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                    loading: () =>
                                                        comments[index]
                                                            .userName
                                                            .txt(
                                                              size: 14.sp,
                                                              isheader: true,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            )),

                                            const Spacer(),
                                            DateFormat.jm()
                                                .format(
                                                    comments[index].createdAt)
                                                .txt(
                                                  size: 12.sp,
                                                ),
                                            if (user!.uid ==
                                                comments[index].userId)
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Icon(
                                                  PhosphorIcons.trashSimpleFill,
                                                  color: Pallete.thickRed,
                                                  size: 16.sp,
                                                ),
                                              ).withHapticFeedback(
                                                onTap: () {
                                                  ref
                                                      .read(
                                                          reportsControllerProvider
                                                              .notifier)
                                                      .deleteComment(
                                                          context: context,
                                                          comment:
                                                              comments[index],
                                                          bug: bug);
                                                },
                                                feedbackType:
                                                    AppHapticFeedbackType
                                                        .mediumImpact,
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 42.w),
                                          child: comments[index]
                                              .content
                                              .txt(
                                                size: 14.sp,
                                                color: const Color(0xFF6B7280),
                                              )
                                              .alignCenterLeft(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          error: (error, stackTrace) {
                            error.toString().log();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                'Error loading comments'.txt(
                                  size: 14.sp,
                                  isheader: true,
                                ),
                              ],
                            );
                          },
                          loading: () {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Loadinggg(height: 30),
                              ],
                            );
                          },
                        ),

                        switch (bug.comments.length) {
                          0 || 1 || 2 => 400.sbH,
                          3 || 4 || 5 => 300.sbH,
                          _ => 45.sbH,
                        }
                        // 400.sbH,
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            error.toString().log();
            return Center(
              child: 'An error occurred'.txt(),
            );
          },
          loading: () {
            return const Loadinggg(height: 40);
          },
        ),
      ),
    );
  }
}
