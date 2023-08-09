import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/keyboard_utils.dart';
import 'package:traq/utils/widgets/myicon.dart';

class SearchBarr extends ConsumerStatefulWidget {
  const SearchBarr({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarrState();
}

class _SearchBarrState extends ConsumerState<SearchBarr> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0xFFF2F4F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            16.wSpace,
            const MyIcon(
              icon: 'search',
              height: 16,
              color: Colors.black,
            ),
            11.wSpace,
            SizedBox(
              height: 41,
              width: 210,
              child: TextField(
                autofocus: true,
                controller: _searchController,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Pallete.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTapOutside: (event) {
                  dropKeyboard();
                },
                decoration: InputDecoration(
                  hintText: 'Search bugs fixes',
                  hintStyle: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
