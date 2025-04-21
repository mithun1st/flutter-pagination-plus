import 'package:flutter/material.dart';

class Helper {
  final ScrollController _scrollController;
  Helper(this._scrollController);

  bool hasDataToScroll() {
    return _scrollController.position.maxScrollExtent == 0;
  }

  bool isScrollDown() {
    return _scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels;
  }
}
