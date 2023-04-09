import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/presentation/widgets/cutom_switch.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';
import 'package:movio/presentation/widgets/theme_switch.dart';

import '../../../config/dimensions.dart';
import '../../bloc/settings/settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Widget> getWidgetsList(
    BuildContext context,
    SettingsSuccess state,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LimitedBox(
            child: Row(
              children: [
                Icon(
                  AppIconAssets.darkMode,
                  size: 20,
                  color: AppColors.orange,
                ),
                Gap(W: 10.w),
                Text(
                  AppString.darkMode,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
              ],
            ),
          ),
          const ThemeSwitch(
            size: 18,
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LimitedBox(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.orange,
                  child: Text(
                    AppString.nsfwContent,
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: AppFontSize.displayMedium,
                    ),
                  ),
                ),
                Gap(W: 10.w),
                Text(
                  AppString.nsfwContent,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
              ],
            ),
          ),
          CustomSwitchWidget(
            onTap: (value) {
              context.read<SettingsBloc>().add(ChangeNSFWStatus(value));
            },
            currentValue: state.nsfwStatus,
            size: 18,
          )
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsSuccess) {
              final widgets = getWidgetsList(context, state);
              return ListView.separated(
                itemBuilder: (context, index) => RoundedContainerWidget(
                    borderRadius: BorderRadius.circular(5),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: AppColors.orange.withOpacity(0.1),
                    ),
                    child: widgets[index]),
                separatorBuilder: (context, index) => Gap(H: 20.h),
                itemCount: widgets.length,
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class SettingsTileWidget extends StatelessWidget {
  const SettingsTileWidget({
    super.key,
    required this.title,
    required this.trailing,
  });
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Text(
        title,
      ),
      trailing: trailing,
    );
  }
}
