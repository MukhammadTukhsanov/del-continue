import 'package:flutter/material.dart';

class HeaderSliderMenu extends StatefulWidget {
  final ScrollController? scrollController;
  final List<Map<String, dynamic>> data;
  final int activeIndex;
  final Function(int) onItemSelected;

  const HeaderSliderMenu({
    super.key,
    this.scrollController,
    required this.data,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  State<HeaderSliderMenu> createState() => _HeaderSliderMenuState();
}

class _HeaderSliderMenuState extends State<HeaderSliderMenu> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.scrollController ?? ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: widget.data.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          bool isActive = index == widget.activeIndex;
          return GestureDetector(
            onTap: () => widget.onItemSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(0x303c486b)),
                borderRadius: BorderRadius.circular(24),
                color: isActive ? const Color(0xff3c486b) : Colors.transparent,
              ),
              child: Text(
                widget.data[index]["title"]!,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _scrollToActiveItem() {
    double offset = widget.activeIndex * (100.0 + 10.0); // Approximate width
    _controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
