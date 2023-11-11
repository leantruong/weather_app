import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/styles/app_color.dart';

class SearchFromWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final Color focusBorderColor;
  final Color unFocusBorderColor;
  final String hint;
  final void Function()? cancelAction;

  const SearchFromWidget({
    required this.controller,
    this.focusNode,
    this.cancelAction,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.titleStyle,
    this.hintStyle,
    this.focusBorderColor = AppColors.bgCard2,
    this.unFocusBorderColor = AppColors.bgCard,
    this.hint = '',
    super.key,
  });

  @override
  State<SearchFromWidget> createState() => _SearchFromWidgetState();
}

class _SearchFromWidgetState extends State<SearchFromWidget> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  Color borderColor = AppColors.primaryColor;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (_) {
        setState(() {});
      },
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onTapOutside: (_) {
                  _focusNode.unfocus();
                },
                controller: _controller,
                focusNode: _focusNode,
                style: widget.titleStyle,
                maxLines: 1,
                keyboardType: widget.textInputType,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  prefixIconConstraints: const BoxConstraints(),
                  prefixIcon:const  Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                        left: 12,
                        right: 8,
                      ),
                      child: Icon(Icons.search)),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintStyle: widget.hintStyle,
                  hintText: widget.hint,
                  filled: !_focusNode.hasFocus,
                  fillColor:
                      !_focusNode.hasFocus ? Colors.white : Colors.transparent,
                  focusedBorder: OutlineInputBorder(
                    borderSide:const  BorderSide(color: AppColors.text, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:const BorderSide(color: AppColors.bgCard, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Visibility(
                visible: _focusNode.hasFocus,
                child: CupertinoButton(
                  onPressed: () {
                    _focusNode.unfocus();
                    widget.cancelAction?.call();
                  },
                  child: const Text('Close', style: TextStyle(fontSize: 12)),
                ))
          ],
        ),
      ),
    );
  }
}
