import 'package:flutter/material.dart';

import '../../../../../imports.dart';

class CommentInput extends StatefulWidget {
  final Function(String)? onSubmit;
  final EdgeInsets? contentPadding;
  final String? initContent;
  final bool showAvatar;

  const CommentInput({
    Key? key,
    this.onSubmit,
    this.contentPadding,
    this.initContent,
    this.showAvatar = true,
  }) : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final controller = TextEditingController();
  final currentUser = authProvider.user;
  @override
  void initState() {
    controller.text = widget.initContent ?? '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: currentUser!.isBanned
          ? Text(t.NotAllowedToComment)
          : Row(
              children: <Widget>[
                if (widget.showAvatar)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AvatarWidget(
                      currentUser!.photoURL,
                      radius: 40,
                    ),
                  ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.all(12),
                      hintText: t.TypeComment,
                      suffixIcon: GestureDetector(
                        onTap: _onSend,
                        child: const Icon(Icons.send, color: Colors.lightBlueAccent),
                      ),
                    ),
                    onEditingComplete: _onSend,
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _onSend() async {
    final content = controller.text.trim();
    if (content.isEmpty) return;
    widget.onSubmit!(content);
    await Future.delayed(Duration(milliseconds: 50));
    controller.clear();
  }
}
