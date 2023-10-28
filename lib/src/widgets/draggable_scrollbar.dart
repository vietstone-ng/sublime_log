import 'package:flutter/material.dart';

class DraggableScrollbar extends StatefulWidget {
  const DraggableScrollbar({
    required this.child,
    required this.controller,
    super.key,
    this.scrollThumbSize = const Size(12.0, 36.0),
    this.scrollBarOffset = const Size(0.0, 0.0),
  });

  final Widget child;
  final ScrollController controller;
  final Size scrollThumbSize;
  final Size scrollBarOffset;

  @override
  State<DraggableScrollbar> createState() => _DraggableScrollbarState();
}

class _DraggableScrollbarState extends State<DraggableScrollbar> {
  // this counts offset for scroll thumb for Vertical axis
  late double _barOffset;

  // this counts offset for list in Vertical axis
  late double _viewOffset;

  //variable to track when scrollbar is dragged
  bool _isDragInProgress = false;

  @override
  void initState() {
    _barOffset = _barMinScrollExtent;
    _viewOffset = 0.0;
    super.initState();
  }

  /// if list takes 300.0 pixels of height on screen and scroll thumb height is
  /// 40.0 then max bar offset is 260.0
  double get _barMaxScrollExtent =>
      context.size!.height -
      widget.scrollThumbSize.height -
      widget.scrollBarOffset.width -
      widget.scrollBarOffset.height;

  double get _barMinScrollExtent => 0.0;

  /// this is usually length (in pixels) of list, if list has 1000 items of
  /// 100.0 pixels each, maxScrollExtent is 100,000.0 pixels
  double get _viewMaxScrollExtent => widget.controller.position.maxScrollExtent;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: onNotificationChange,
      child: Stack(
        children: [
          widget.child,
          Container(
            margin: EdgeInsets.only(
              top: widget.scrollBarOffset.width,
              bottom: widget.scrollBarOffset.height,
              right: 2.0,
            ),
            child: GestureDetector(
              onVerticalDragStart: _onVerticalDragStart,
              onVerticalDragEnd: _onVerticalDragEnd,
              onVerticalDragUpdate: _onVerticalDragUpdate,
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(
                  top: _barOffset,
                  right: 0.0,
                ),
                child: _buildScrollThumb(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildScrollThumb() {
    return Container(
      width: widget.scrollThumbSize.width,
      height: widget.scrollThumbSize.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey,
      ),
    );
  }

  double _getScrollViewDelta(
    double barDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) =>
      barDelta * viewMaxScrollExtent / barMaxScrollExtent;

  double _getBarDelta(
    double scrollViewDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) =>
      scrollViewDelta * barMaxScrollExtent / viewMaxScrollExtent;

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _barOffset += details.delta.dy;

      if (_barOffset < _barMinScrollExtent) {
        _barOffset = _barMinScrollExtent;
      }

      if (_barOffset > _barMaxScrollExtent) {
        _barOffset = _barMaxScrollExtent;
      }

      final viewData = _getScrollViewDelta(
        details.delta.dy,
        _barMaxScrollExtent,
        _viewMaxScrollExtent,
      );

      _viewOffset = widget.controller.position.pixels + viewData;
      if (_viewOffset < widget.controller.position.minScrollExtent) {
        _viewOffset = widget.controller.position.minScrollExtent;
      }
      if (_viewOffset > _viewMaxScrollExtent) {
        _viewOffset = _viewMaxScrollExtent;
      }
      widget.controller.jumpTo(_viewOffset);
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      _isDragInProgress = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _isDragInProgress = false;
    });
  }

  bool onNotificationChange(ScrollNotification notification) {
    if (_isDragInProgress) {
      return true;
    }

    setState(() {
      if (notification is ScrollUpdateNotification) {
        _barOffset += _getBarDelta(
          notification.scrollDelta ?? 0,
          _barMaxScrollExtent,
          _viewMaxScrollExtent,
        );

        if (_barOffset < _barMinScrollExtent) {
          _barOffset = _barMinScrollExtent;
        }

        if (_barOffset > _barMaxScrollExtent) {
          _barOffset = _barMaxScrollExtent;
        }

        _viewOffset += notification.scrollDelta ?? 0;
        if (_viewOffset < widget.controller.position.minScrollExtent) {
          _viewOffset = widget.controller.position.minScrollExtent;
        }
        if (_viewOffset > _viewMaxScrollExtent) {
          _viewOffset = _viewMaxScrollExtent;
        }
      }
    });

    return true;
  }
}
