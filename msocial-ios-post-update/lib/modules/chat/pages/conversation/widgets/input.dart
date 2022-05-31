import 'dart:async';

import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../imports.dart';

class ChatInput extends StatefulWidget {
  final String? initialValue;
  final Future<void> Function(String) onSendText;
  final VoidFutureCallBack onAttachemntTap;
  final ValueChanged<bool> onTypingChange;

  const ChatInput({
    Key? key,
    this.initialValue,
    required this.onSendText,
    required this.onAttachemntTap,
    required this.onTypingChange,
  }) : super(key: key);
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> with WidgetsBindingObserver {
  final inputTextController = TextEditingController();
  final focusNode = FocusNode();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    inputTextController.text = widget.initialValue ?? '';
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    focusNode.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    if (_isTyping) {
      widget.onTypingChange(false);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _isTyping) {
      widget.onTypingChange(false);
    } else if (state == AppLifecycleState.resumed &&
        inputTextController.text.isNotEmpty) {
      widget.onTypingChange(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: 14, left: 6, right: 2),
      height: 180,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: inputTextController,
                    focusNode: focusNode,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      fillColor: theme.primaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.all(12),
                      hintText: t.Messaging,
                      prefixIcon: GestureDetector(
                        onTap: () async {
                          focusNode.unfocus();
                          focusNode.canRequestFocus = false;
                          widget.onAttachemntTap();
                          await 2.delay();
                          focusNode.canRequestFocus = true;
                        },
                        child: Icon(
                          Icons.attachment,
                          color: theme.iconTheme.color,
                        ),
                      ),
                    ),
                    onEditingComplete: _onSendText,
                    onChanged: (s) async {
                      if (s.trim().isEmpty) {
                        if (_isTyping) {
                          setState(() => _isTyping = false);
                          widget.onTypingChange(_isTyping);
                        }
                      } else if (!_isTyping) {
                        setState(() => _isTyping = true);
                        widget.onTypingChange(_isTyping);
                      }
                    },
                  ),
                ),
                SizedBox(width: 6),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _onSendText,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: theme.inversePrimaryColor,
                      child: Icon(
                        Icons.send,
                        size: 25,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSendText() {
    if (inputTextController.text.trim().isEmpty) return;
    widget.onSendText(inputTextController.text);
    setState(() => _isTyping = false);
    inputTextController.clear();
  }
}
