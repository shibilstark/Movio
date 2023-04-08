import 'package:flutter/material.dart';
import 'package:movio/presentation/screens/search/widgets/idle.dart';
import 'package:movio/presentation/screens/search/widgets/search_appbar.dart';
import 'package:movio/presentation/screens/search/widgets/search_result.dart';
import 'package:movio/presentation/widgets/keyboard_dismisser.dart';
import 'package:movio/utils/date_time/debouncer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ValueNotifier<TextEditingController> searchController;
  late ValueNotifier<FocusNode> focusNotifier;
  late Debouncer debouncer;

  @override
  void initState() {
    searchController = ValueNotifier(TextEditingController());

    focusNotifier = ValueNotifier(FocusNode());
    debouncer = Debouncer(milliseconds: 700);
    super.initState();
  }

  @override
  void dispose() {
    focusNotifier.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SearchAppBarWidget(
          focusNotifier: focusNotifier,
          searchController: searchController,
          debouncer: debouncer,
        ),
      ),
      body: KeyBoardDismisser(
        focusNode: focusNotifier.value,
        child: ValueListenableBuilder(
            valueListenable: searchController,
            builder: (context, controller, _) {
              if (searchController.value.text.trim().isNotEmpty) {
                return SearchResultWidget(
                  scrollController: widget.scrollController,
                  searchController: searchController,
                  focusNode: focusNotifier,
                );
              }

              return SearchIdleWidget(
                scrollController: widget.scrollController,
              );
            }),
      ),
    );
  }
}
