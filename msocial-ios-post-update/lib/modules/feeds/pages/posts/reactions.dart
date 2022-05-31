import 'package:flutter/material.dart';

import '../../../../components/user_list.dart';
import '../../../../imports.dart';

class ReactionsPage extends StatelessWidget {
  final List<String> likeIDs;

  const ReactionsPage(
    this.likeIDs, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: Appbar(
        title: Text(
          t.Likes,
          style: theme.textTheme.headline6,
        ),
      ),
      body: UsersList(usersId: likeIDs),
    );
  }
}
