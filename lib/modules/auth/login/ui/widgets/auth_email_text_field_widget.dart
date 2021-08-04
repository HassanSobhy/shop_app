import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final String hintText, errorText;
  final TextInputType keyboardType;
  final bool obscureText, enabled, showBorder;
  final TextInputAction textInputAction;
  final void Function(String) onChange;
  final void Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextEditingController controller;

  const AuthTextFieldWidget({
    @required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    @required this.onChange,
    @required this.onSubmitted,
    this.controller,
    this.focusNode,
    this.errorText,
    this.textInputAction,
    this.enabled = true,
    this.showBorder = false,
  });

  @override
  _AuthTextFieldWidgetState createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  bool _shouldShowAsPasswordText;
  IconData _passwordIcon = Icons.visibility;

  @override
  void initState() {
    super.initState();
    // Initially password is obscure
    _shouldShowAsPasswordText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Center(
        child: TextField(
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          obscureText: _shouldShowAsPasswordText,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(_passwordIcon),
                    onPressed: _toggleVisibilityIcon,
                  )
                : null,
            border: OutlineInputBorder(
              borderSide:
                  widget.showBorder ? const BorderSide() : BorderSide.none,
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            hintText: widget.hintText,
            errorText: widget.errorText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
            fillColor: Colors.white,
            filled: true,
          ),
          onChanged: widget.onChange,
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }

  void _toggleVisibilityIcon() {
    setState(() {
      _shouldShowAsPasswordText = !_shouldShowAsPasswordText;
      if (_shouldShowAsPasswordText) {
        _passwordIcon = Icons.visibility;
      } else {
        _passwordIcon = Icons.visibility_off;
      }
    });
  }
}
