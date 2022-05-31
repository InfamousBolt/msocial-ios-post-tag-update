import 'package:flutter/material.dart';

import '../../../../imports.dart';
import '../../data/posts.dart';
import '../../models/post.dart';

class ReportPage extends StatelessWidget {
  final Post? post;

  const ReportPage(
    this.post, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.Report),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              t.ReportDesc,
              style: theme.textTheme.headline6,
            ),
            SizedBox(height: 30),
            Text(t.ReportReasons),
            Spacer(),
            Text(
              t.ReportNote,
              style: theme.textTheme.caption,
            ),
            SizedBox(height: 20),
            Center(
              child: AppButton(
                t.Report,
                onTap: () async {
                  Navigator.pop(context);
                  BotToast.showText(text: t.ReportThanks);
                  post!.reportedBy.add(authProvider.user!.id);
                  await PostsRepository.reportPost(post!);
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
