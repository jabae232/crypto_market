import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../constants/app_assets.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_styles.dart';
import '../../data/bloc/search_bloc.dart';
import '../view_model/search_view_model.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
    required this.vm,
  });

  final SearchViewModel vm;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: vm.textController,
      onChanged: (value) {
        vm.controller = value;
        context.read<SearchBloc>().add(
          SearchForCryptoEvent(query: value),
        );
      },
      decoration: InputDecoration(
        suffixIcon: vm.isTyped()
            ? IconButton(
          onPressed: () {
            vm.textController.clear();
            vm.controller = '';
            context.read<SearchBloc>().add(
              SearchForCryptoEvent(query: ''),
            );
          },
          icon: SvgPicture.asset(
            AppAssets.svg.fieldClear,
          ),
        )
            : const SizedBox.shrink(),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        hintText: 'Тикер / Название',
        hintStyle: AppStyles.s16w400,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            AppAssets.svg.search,
            width: 18,
            height: 18,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.50,
            color: AppColors.defaultGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.50,
            color: AppColors.defaultGrey,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}