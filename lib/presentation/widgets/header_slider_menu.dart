import 'package:flutter/material.dart';

class HeaderSliderMenu extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final int activeIndex;
  final ValueChanged<int> onItemSelected;
  ScrollController? scrollController;

  HeaderSliderMenu(
      {super.key,
      required this.data,
      required this.activeIndex,
      required this.onItemSelected,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveItem();
    });
    return SizedBox(
      height: 36,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: data.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          bool isActive = index == activeIndex;
          return GestureDetector(
              onTap: () => onItemSelected(index),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: const Color(0x303c486b)),
                    borderRadius: BorderRadius.circular(24),
                    color:
                        isActive ? const Color(0xff3c486b) : Colors.transparent,
                  ),
                  child: Text(data[index]["title"],
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.black,
                      ))));
        },
      ),
    );
  }

  void _scrollToActiveItem() {
    if (scrollController != null) {
      double offset =
          activeIndex * (100.0 + 10.0); // Item width + separator width
      scrollController!.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
