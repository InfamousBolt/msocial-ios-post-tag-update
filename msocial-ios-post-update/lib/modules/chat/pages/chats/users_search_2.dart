import 'package:flutter/material.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';

import '../../../../imports.dart';
import '../../data/users.dart';

class UsersSearchPageTwo extends StatefulWidget {
  @override
  _UsersSearchPageTwoState createState() => _UsersSearchPageTwoState();
}

class _SearchResultItem extends StatelessWidget {
  final User user;

  const _SearchResultItem(
      this.user, {
        Key? key,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (user.isMe) return SizedBox();
    return ListTile(
      onTap: () => AuthRoutes.toProfile(user.id),
      dense: true,
      leading: AvatarWidget(
        user.photoURL,
        radius: 50,
      ),
      title: AppText(
        user.fullName,
        size: 16,
      ),
      subtitle: Text(user.username),
    );
  }
}

class _UsersSearchPageTwoState extends State<UsersSearchPageTwo> {
  List<User>? users;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await 0.1.delay();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              PaginatedSearchBar<User>(
              maxHeight: Get.height,
              inputStyle: TextStyle(
                fontSize: 20,
              ),
              autoFocus: true,
              inputDecoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 25),
                hintText: 'Search for users',
                border: InputBorder.none,
                prefixIcon: BackButton(),
              ),
              containerDecoration: BoxDecoration(),
              itemPadding: 0,
              padding: EdgeInsets.all(0),
              emptyBuilder: (_) => Padding(
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "Oops, no results found!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              itemBuilder: (_, {required item, required index}) =>
                  _SearchResultItem(item),
              onSearch: ({
                required pageIndex,
                required pageSize,
                required searchQuery,
              }) async {
                final res = await ChatUsersRepository.usersSearch(searchQuery);
                return res;
              },
            ),
            ],
          ),
        ),
      ),

    );
  }
}
