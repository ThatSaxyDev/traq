import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:simple_notifier/simple_notifier.dart';
import 'package:traq/features/organisations/controllers/organisation_controller.dart';
import 'package:traq/features/projects/controllers/project_controller.dart';
import 'package:traq/features/projects/views/project_desktop_view_controller.dart';
import 'package:traq/models/organisation_model.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_constants.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/button.dart';
import 'package:traq/utils/widgets/myicon.dart';
import 'package:traq/utils/widgets/text_input.dart';

class CreateProjectPopup extends ConsumerStatefulWidget {
  const CreateProjectPopup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateProjectPopupState();
}

class _CreateProjectPopupState extends ConsumerState<CreateProjectPopup> {
  final TextEditingController _projectNameController = TextEditingController();
  ValueNotifier colorError = false.notifier;
  Color? targetColor;

  @override
  void dispose() {
    _projectNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProjectColor? projectColor = ref.watch(projectColorControllerProvider);
    OrganisationModel? orgFromProvider =
        ref.watch(orgModelStateControllerProvider);
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        height: height(context),
        width: width(context),
        child: Center(
          child: Container(
            height: height(context) * 0.45,
            width: width(context) * 0.39,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            decoration: BoxDecoration(
              color: Pallete.whiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Create new project'.txt(
                        isheader: true,
                        size: 32,
                        fontWeight: FontWeight.w600,
                      ),

                      //! close
                      MyIcon(
                        icon: 'x',
                        height: 24,
                        onTap: () {
                          _projectNameController.clear();
                          toggleOverlay(context: context, ref: ref);
                          removeProjectColor(context: context, ref: ref);
                        },
                      ),
                    ],
                  ),
                  24.hSpace,

                  //! project input
                  TextInputWidget(
                    autofocus: true,
                    hintText: 'e.g Bugzy',
                    inputTitle: 'Enter project name',
                    controller: _projectNameController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        colorError.value = false;
                      }
                    },
                  ),
                  16.hSpace,

                  //! pick color
                  Row(
                    children: [
                      'Project color'.txt14(),
                      10.wSpace,
                      colorError.listen(
                        builder: (context, value, child) => switch (value) {
                          true =>
                            'Please type the project name and pick a color'
                                .txt12(color: Pallete.thickRed),
                          false => ''.txt(),
                          _ => ''.txt(),
                        },
                      )
                    ],
                  ),
                  8.hSpace,

                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(
                      projectColors.length,
                      (index) => Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: projectColors[index].colorMaterial,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ).tap(
                        onTap: () {
                          selectProjectColor(
                            context: context,
                            projectColor: projectColors[index],
                            ref: ref,
                          );
                          colorError.value = false;
                        },
                      ),
                    ),
                  ).alignCenterLeft(),
                  30.hSpace,

                  //! buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! cancel
                      TransparentButton(
                        width: 255,
                        onTap: () {},
                        text: 'Cancel',
                      ),

                      //! create
                      BButton(
                        width: 255,
                        color: switch (projectColor == null) {
                          true => null,
                          false => projectColor!.colorMaterial
                        },
                        onTap: () {
                          if (projectColor == null ||
                              _projectNameController.text.isEmpty) {
                            colorError.value = true;
                          } else {
                            ref
                                .read(projectControllerProvider.notifier)
                                .createProject(
                                    organisation: orgFromProvider!,
                                    name: _projectNameController.text.trim(),
                                    context: context);
                          }
                        },
                        text: 'Create Project',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ).fadeInFromBottom(
            delay: 100.ms,
            animatiomDuration: 100.ms,
          ),
        ),
      ).fadeIn(delay: 0.ms, animatiomDuration: 100.ms),
    );
  }
}
