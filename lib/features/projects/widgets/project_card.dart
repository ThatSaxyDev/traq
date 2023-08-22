// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/models/version_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/loader.dart';
import 'package:traq/utils/widgets/myicon.dart';

class ProjectVersionCard extends ConsumerWidget {
  final String versionId;
  final int index;
  // final void Function()? goToVersion;
  const ProjectVersionCard({
    super.key,
    required this.versionId,
    required this.index,
    // this.goToVersion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<VersionModel> versionn =
        ref.watch(getVersionByIdProvider(versionId));
    return versionn.when(
      data: (VersionModel version) {
        return Container(
          width: 380,
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1,
              color: const Color(0xFFF2F4F7),
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFF6F4DCD),
                    child: (index + 1).toString().txt(
                          size: 22,
                          color: Pallete.whiteColor,
                        ),
                  ),
                  12.wSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      version.name.toTitleCase().txt16(
                            isheader: true,
                            fontWeight: FontWeight.w600,
                          ),
                      'Release Date: ${DateFormat('yyyy-MM-dd').format(version.createdAt!)}'
                          .txt14(
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const Spacer(),
                  MyIcon(
                    icon: 'arrowright',
                    onTap: () {
                      ref
                          .read(versionNavControllerProvider.notifier)
                          .jumpToPage(page: 1);
                    },
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  //! open bugs
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFEF2F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: 'Open Bugs - 10'.txt(
                      size: 10,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  8.wSpace,

                  //! resolved bugs
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF0FDF4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: 'Resolved Bugs - 5'.txt(
                      size: 10,
                      color: const Color(0xFF22C55E),
                    ),
                  ),
                  8.wSpace,

                  //! closed bugs
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF9FCFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: 'Closed Bugs - 0'.txt(
                      size: 10,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        error.toString().log();
        return const SizedBox.shrink();
      },
      loading: () {
        return const Loadinggg(
          height: 40,
        );
      },
    );
  }
}
