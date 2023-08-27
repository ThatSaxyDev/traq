// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/features/projects/widgets/project_card.dart';
import 'package:traq/models/project_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';

class ProjectVersionsView extends ConsumerWidget {
  final String projectName;
  const ProjectVersionsView({
    super.key,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ProjectModel> projectStream =
        ref.watch(getProjectByNameProvider(Uri.decodeComponent(projectName)));
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Pallete.whiteColor,
          centerTitle: false,
          title: Uri.decodeComponent(projectName).txt(
            isheader: true,
            size: 24.sp,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              width: double.infinity,
              height: 40.h,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE5E7EB)),
                ),
              ),
              child: BottomLeft(
                child: 'VERSIONS LIST'.txt(
                  size: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: projectStream.when(
          data: (ProjectModel project) {
            return SingleChildScrollView(
              child: SeparatedColumn(
                separatorBuilder: () => 12.sbH,
                children: List.generate(
                  project.versions.length,
                  (index) => Column(
                    children: [
                      if (index == 0) 16.sbH,
                      ProjectVersionCardMobile(
                          projectName: Uri.decodeComponent(projectName),
                          versionId: project.versions[index],
                          index: index),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: 'An error occured'.txt(size: 20.sp),
            );
          },
          loading: () {
            return Loadinggg(
              height: 40.h,
            );
          },
        ),
      ),
    );
  }
}
