import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  /// The initial color to display in the color picker.
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;
  const ColorPickerWidget({
    super.key,
    required this.initialColor,
    required this.onColorSelected,
  });

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  /// The color currently displayed in the UI.
  Color currentColor = Color(0xff443a49);
  @override
  /// Initializes the state of the widget.
  ///
  /// This function is called when the widget is first created.
  /// It sets the initial color of the widget to the [initialColor] provided
  /// in the constructor.
  void initState() {
    // TODO: implement initState
    super.initState();
    currentColor = widget.initialColor;
  }

  /// Updates the [currentColor] to the given [color].
  ///
  /// This function is called when the user selects a new color.
  /// It updates the [currentColor] state, which triggers a rebuild
  /// of the widget tree and updates the displayed color in the UI.
  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: currentColor,
          onColorChanged: changeColor,
          pickerAreaHeightPercent: 0.8,
          enableAlpha: true,
          displayThumbColor: true,
          paletteType: PaletteType.hsv, // عجلة الألوان
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Got it'),
          onPressed: () {
            widget.onColorSelected(currentColor);
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}
