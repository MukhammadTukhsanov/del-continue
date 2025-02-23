import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HeaderSliderMenu extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int activeIndex;
  final Function(int) onItemSelected;

  const HeaderSliderMenu({
    super.key,
    required this.data,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  State<HeaderSliderMenu> createState() => _HeaderSliderMenuState();
}

class _HeaderSliderMenuState extends State<HeaderSliderMenu> {
  late int _selectedChip;
  late final ScrollController _scrollController;
  final List<GlobalKey> _chipKeys = [];

  @override
  void initState() {
    super.initState();
    _selectedChip =
        (widget.activeIndex >= 0 && widget.activeIndex < widget.data.length)
            ? widget.activeIndex
            : 0;

    _scrollController = ScrollController();

    if (widget.data.isNotEmpty) {
      _chipKeys
          .addAll(List.generate(widget.data.length, (index) => GlobalKey()));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.data.isNotEmpty) {
        _scrollToSelectedChip();
      }
    });
  }

  @override
  void didUpdateWidget(covariant HeaderSliderMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.data.length != widget.data.length) {
      _chipKeys.clear();
      _chipKeys
          .addAll(List.generate(widget.data.length, (index) => GlobalKey()));
    }
  }

  void _scrollToSelectedChip() {
    if (_chipKeys.isNotEmpty &&
        _selectedChip >= 0 &&
        _selectedChip < _chipKeys.length &&
        _chipKeys[_selectedChip].currentContext != null) {
      Scrollable.ensureVisible(
        _chipKeys[_selectedChip].currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onChipSelected(int index) {
    setState(() {
      _selectedChip = index;
    });
    widget.onItemSelected(index);
    _scrollToSelectedChip();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const SizedBox();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          ...widget.data.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;

            return ChoiceChipWidget(
              key: _chipKeys.isNotEmpty ? _chipKeys[index] : GlobalKey(),
              label: '${item['title']}',
              isSelected: _selectedChip == index,
              onSelected: () => _onChipSelected(index),
            );
          }),
        ],
      ),
    );
  }
}

class ChoiceChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const ChoiceChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        showCheckmark: false,
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          onSelected();
        },
        selectedColor: const Color(0xff3C486B),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xff3c486b),
          fontSize: 14,
        ),
        shape: StadiumBorder(
          side: BorderSide(
            color: const Color(0xff3c486b).withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
