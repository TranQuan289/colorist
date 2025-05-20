import 'package:flutter/material.dart';

class FormFieldScrollHelper {
  /// Scroll to first error field
  static void scrollToFirstError(BuildContext context) {
    final errorFields = <_ErrorFieldInfo>[];
    _collectErrorFormFields(context, errorFields);

    if (errorFields.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        errorFields.first.context,
        duration: const Duration(milliseconds: 300),
        alignment: 0.2,
      );
    });
  }

  /// Collect error form fields
  static void _collectErrorFormFields(
    BuildContext context,
    List<_ErrorFieldInfo> errorFields,
  ) {
    bool found = false;

    void visitor(Element element) {
      if (found) return;
      final formFieldState = element.findAncestorStateOfType<FormFieldState>();
      if (formFieldState != null && formFieldState.hasError) {
        final renderBox = element.renderObject as RenderBox?;
        if (renderBox != null) {
          errorFields.add(
            _ErrorFieldInfo(
              context: element,
              renderBox: renderBox,
              state: formFieldState,
            ),
          );
          found = true;
          return;
        }
      }
      element.visitChildren(visitor);
    }

    (context as Element).visitChildren(visitor);
  }
}

/// Class to store information about error fields
class _ErrorFieldInfo {
  final BuildContext context;
  final RenderBox renderBox;
  final FormFieldState state;

  _ErrorFieldInfo({
    required this.context,
    required this.renderBox,
    required this.state,
  });
}
