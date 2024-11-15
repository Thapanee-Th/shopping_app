import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDropdown extends StatefulWidget {
  final dynamic textEditingController; // Can be TextEditingController or Map
  final List<dynamic> options; // Can be List<Map> or List<String>
  final String? optionValueKey; // Key for the value in case of List<Map>
  final String? optionDisplayKey; // Key for the display in case of List<Map>
  final double spaceGap;
  final String? hintText;
  final String? labelText;
  final IconData? expandedIcon;
  final IconData? collapsedIcon;
  final Function(dynamic)? onChanged; // Accepts dynamic value
  final Color? color;
  final Color? borderColor;
  final bool disable;

  const MyDropdown({
    super.key,
    required this.textEditingController,
    required this.options,
    this.optionValueKey, // Optional if List<Map> is used
    this.optionDisplayKey, // Optional if List<Map> is used
    this.spaceGap = 24,
    this.hintText,
    this.labelText,
    this.expandedIcon = Icons.keyboard_arrow_up, // Default expanded icon
    this.collapsedIcon = Icons.keyboard_arrow_down, // Default collapsed icon
    this.onChanged,
    this.color,
    this.borderColor,
    this.disable = false,
  });

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown>
    with SingleTickerProviderStateMixin {
  late List<dynamic> _options;
  dynamic _selectedOption;
  late String _hintText;
  bool _isDropdownOpen = false; // Track if dropdown is open
  late AnimationController _iconRotationController;

  Color get disableTextColor => const Color(0xFFA6AAAD);

  @override
  void initState() {
    super.initState();

    // Determine the appropriate hint text based on the locale
    _hintText = widget.hintText ?? 'Select an option';

    // Initialize options
    _options = widget.options;

    // Initialize the icon rotation controller for animation
    _iconRotationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Assign the initial value from the controller based on the value type
    if (widget.textEditingController is TextEditingController) {
      String controllerValue =
          (widget.textEditingController as TextEditingController).text;

      _selectedOption = _options.firstWhere(
        (option) {
          dynamic optionValue = _getOptionValue(option);

          // Ensure both values are compared with their correct types
          return _areValuesEqual(optionValue, controllerValue);
        },
        orElse: () => null,
      );

      // If _selectedOption is a Map, extract the value using widget.optionValueKey
      if (_selectedOption is Map && widget.optionValueKey != null) {
        _selectedOption = _selectedOption[widget.optionValueKey];
      }
    } else if (widget.textEditingController is Map) {
      dynamic controllerValue =
          (widget.textEditingController as Map)['selected'] ?? null;

      _selectedOption = _options.firstWhere(
        (option) {
          dynamic optionValue = _getOptionValue(option);
          return _areValuesEqual(optionValue, controllerValue);
        },
        orElse: () => null,
      );

      // If _selectedOption is a Map, extract the value using widget.optionValueKey
      if (_selectedOption is Map && widget.optionValueKey != null) {
        _selectedOption = _selectedOption[widget.optionValueKey];
      }
    }
  }

  bool _areValuesEqual(dynamic optionValue, dynamic controllerValue) {
    // Ensure both values are of the same type before comparing
    if (optionValue.runtimeType != controllerValue.runtimeType) {
      return optionValue.toString() == controllerValue.toString();
    }
    return optionValue == controllerValue;
  }

  dynamic _getOptionValue(dynamic option) {
    if (option is Map) {
      return widget.optionValueKey != null
          ? option[widget.optionValueKey]
          : option['id'];
    }
    return option; // If List<String>, just return the value
  }

  dynamic _getOptionDisplayText(dynamic option) {
    if (option is Map) {
      return widget.optionDisplayKey != null
          ? option[widget.optionDisplayKey]
          : option['name'];
    }
    return option.toString(); // If List<String>, just return the value
  }

  void onDropdownChanged(dynamic newValue) {
    setState(() {
      _selectedOption = newValue;
      _isDropdownOpen = false;
      _iconRotationController.reverse(); // Reset the icon when closed

      if (widget.textEditingController is TextEditingController) {
        (widget.textEditingController as TextEditingController).text =
            newValue.toString();
      } else if (widget.textEditingController is Map) {
        (widget.textEditingController as Map)['selected'] = newValue;
      }

      if (widget.onChanged != null) {
        widget.onChanged!(newValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: DropdownButtonFormField<dynamic>(
        value: _selectedOption,
        hint: Text(_hintText,
            style: Get.textTheme.titleMedium?.copyWith(color: Colors.grey)),
        onChanged: widget.disable ? null : onDropdownChanged,
        style: Get.textTheme.titleMedium
            ?.copyWith(color: widget.disable ? disableTextColor : Colors.black),
        icon: RotationTransition(
          turns: Tween(begin: 0.0, end: 0.5).animate(_iconRotationController),
          child: Icon(
            _isDropdownOpen ? widget.expandedIcon : widget.collapsedIcon,
            color: Colors.grey,
          ),
        ),
        onTap: () {
          setState(() {
            _isDropdownOpen = !_isDropdownOpen;
            if (_isDropdownOpen) {
              _iconRotationController.forward(); // Rotate icon on open
            } else {
              _iconRotationController.reverse(); // Rotate icon on close
            }
          });
        },
        items: _options.map((option) {
          return DropdownMenuItem<dynamic>(
            value:
                _getOptionValue(option), // Use only the unique key (e.g., 'id')
            child: Text(
              option is Map ? option[widget.optionDisplayKey] : option,
              style: Get.textTheme.titleMedium,
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: widget.labelText,
          filled: widget.color != null || widget.disable,
          fillColor: widget.disable ? Color(0xFFB7BABD) : widget.color,
          contentPadding: const EdgeInsets.all(12),
          hintText: widget.hintText,
          hintStyle: Get.textTheme.titleMedium?.copyWith(color: Colors.grey),
          errorStyle: const TextStyle(fontSize: 11, color: Colors.redAccent),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: widget.color != null
                ? BorderSide.none
                : BorderSide(color: widget.borderColor ?? Color(0xFFB7BABD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: widget.color != null
                ? BorderSide.none
                : BorderSide(color: widget.borderColor ?? Color(0xFFB7BABD)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: widget.color != null
                ? BorderSide.none
                : const BorderSide(color: Colors.grey),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _iconRotationController.dispose();
    super.dispose();
  }
}
