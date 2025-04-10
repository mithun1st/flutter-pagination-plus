import 'package:flutter/material.dart';

class FlutterPaginationPlus<T> extends StatefulWidget {
  final List<T> list;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future Function() onChangeNextPage;
  final Widget? scrollWidget;

  const FlutterPaginationPlus({
    required this.list,
    required this.itemBuilder,
    required this.onChangeNextPage,
    this.scrollWidget,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _FlutterPaginationPlusState();
  }
}

class _FlutterPaginationPlusState extends State<FlutterPaginationPlus> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;

  bool _isLastIndex(int index) => widget.list.length == (index + 1);

  void _onNextPageEvent() async {
    setState(() => _isLoading = true);
    await widget.onChangeNextPage.call();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onNextPageEvent();
      }
    });
    // WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
    //   setState(() {
    //     _hasNotEnoughDataToScroll =
    //         _scrollController.position.maxScrollExtent == 0;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemCount: widget.list.length,
      itemBuilder:
          (context, index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.itemBuilder(context, index),
              if (_isLastIndex(index)) _bottomWidget(_isLoading),
            ],
          ),
    );
  }

  Widget _bottomWidget(bool isLoadingActive) {
    return isLoadingActive
        ? widget.scrollWidget ?? const RefreshProgressIndicator()
        : SizedBox();
  }
}
