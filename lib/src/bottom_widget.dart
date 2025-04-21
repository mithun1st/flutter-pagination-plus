import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  final bool isLoadingVisible;
  final bool isLoadMoreButtonVisible;
  final Widget? progressIndicator;
  final Widget? loadMoreButton;
  final void Function() onTapReloadButton;

  const BottomWidget({
    required this.isLoadingVisible,
    required this.isLoadMoreButtonVisible,
    this.progressIndicator,
    this.loadMoreButton,
    required this.onTapReloadButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isLoadingVisible
        ? _progressWidget()
        : isLoadMoreButtonVisible
        ? _loadMoreButton()
        : const SizedBox();
  }

  Widget _loadMoreButton() =>
      loadMoreButton ??
      FilledButton(
        onPressed: onTapReloadButton,
        child: const Text('Load More'),
      );

  Widget _progressWidget() =>
      progressIndicator ?? const RefreshProgressIndicator();
}
