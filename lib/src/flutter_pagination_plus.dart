import 'package:flutter/material.dart';
import 'package:flutter_pagination_plus/src/bottom_widget.dart';
import 'package:flutter_pagination_plus/utils/enum.dart';
import 'package:flutter_pagination_plus/utils/helper.dart';

class FlutterPaginationPlus<T> extends StatefulWidget {
  final List<T> list;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future Function() onChangeNextPage;
  final Widget? progressIndicator;
  final Widget? loadMoreButton;
  final PaginationType paginationType;

  final Axis scrollDirection;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const FlutterPaginationPlus({
    required this.list,
    required this.itemBuilder,
    required this.onChangeNextPage,
    this.progressIndicator,
    this.loadMoreButton,
    this.paginationType = PaginationType.infiniteScroll,

    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,

    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _FlutterPaginationPlusState<T>();
  }
}

class _FlutterPaginationPlusState<T> extends State<FlutterPaginationPlus> {
  late final Helper _helper;
  final ScrollController _controller = ScrollController();

  bool _isLoading = false;

  bool _isLastIndex(int index) => widget.list.length == (index + 1);

  bool get _shouldLoadMoreVisible =>
      _helper.hasDataToScroll() ||
      widget.paginationType == PaginationType.loadMore;

  void _scrollLisitener() {
    if (widget.paginationType == PaginationType.infiniteScroll &&
        _helper.isScrollDown()) {
      _onChangeNextPage();
    }
  }

  void _onChangeNextPage() async {
    setState(() => _isLoading = true);

    await widget.onChangeNextPage();

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _helper = Helper(_controller);

    _controller.addListener(_scrollLisitener);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,

      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,

      itemCount: widget.list.length,
      itemBuilder:
          (context, index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.itemBuilder(context, index),
              if (_isLastIndex(index))
                BottomWidget(
                  isLoadingVisible: _isLoading,
                  isLoadMoreButtonVisible: _shouldLoadMoreVisible,
                  onTapReloadButton: _onChangeNextPage,
                  progressIndicator: widget.progressIndicator,
                  loadMoreButton: widget.loadMoreButton,
                ),
            ],
          ),
    );
  }
}
