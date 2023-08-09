// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:traq/utils/app_extensions.dart';

class ReportsDesktopView extends ConsumerStatefulWidget {
  const ReportsDesktopView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReportsDesktopViewState();
}

class _ReportsDesktopViewState extends ConsumerState<ReportsDesktopView> {
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
              'Reports'.toTitleCase().txt(
                    isheader: true,
                    size: 32,
                    fontWeight: FontWeight.w600,
                  ),
              4.hSpace,

              //! overview
              'Created on August 7, 2023'.toUpperCase().txt14(
                    fontWeight: FontWeight.w500,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
