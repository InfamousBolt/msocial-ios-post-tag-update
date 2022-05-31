import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:paginated_search_bar/paginated_search_bar_state_property.dart';

import '../../../../imports.dart';
import '../../data/groups.dart';
import '../../models/group.dart';

class GroupsSearch extends StatefulWidget {
  @override
  _GroupsSearchState createState() => _GroupsSearchState();
}

class _GroupsSearchState extends State<GroupsSearch> {
  final textController = TextEditingController();

  List<Group>? groups;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await 0.1.delay();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: PaginatedSearchBar<Group>(
              headerBuilderState: PaginatedSearchBarBuilderStateProperty.resolveWith((context, states) {
                if (states.contains(PaginatedSearchBarState.empty) && !states.contains(PaginatedSearchBarState.done)) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 550,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Trending groups:"),
                          FutureBuilder(
                            future: GroupsRepository.trendingGroups(),
                            builder: (_, AsyncSnapshot<List<Group>> snapshot){
                              if(snapshot.connectionState == ConnectionState.done){
                                return Expanded(
                                  child: SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (_, index){
                                        return _SearchResultItem(snapshot.data![index]);
                                      },
                                    ),
                                  ),
                                );
                              }
                              else{
                                return Text("Loading...");
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }
                return null;
              }),
              inputStyle: TextStyle(
                fontSize: 20,
              ),
              inputDecoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 25),
                hintText: 'Search for groups',
                border: InputBorder.none,
                prefixIcon: BackButton(),
              ),
              autoFocus: true,
              maxHeight: Get.height,
              containerDecoration: BoxDecoration(),
              itemPadding: 0,
              padding: EdgeInsets.symmetric(vertical: 10),
              emptyBuilder: (_) => const Text("Oops, no results found!"),
              itemBuilder: (_, {required item, required index}) =>
                  _SearchResultItem(item),
              onSearch: ({
                required pageIndex,
                required pageSize,
                required searchQuery,
              }) async {
                final res = await GroupsRepository.groupsSearch(searchQuery);
                return res;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  final Group group;

  const _SearchResultItem(
    this.group, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListTile(
        onTap: () => ChatRoutes.toGroupInfo(group),
        leading: AvatarWidget(
          group.photoURL,
          radius: 50,
        ),
        title: Text(
          group.name,
          style: GoogleFonts.basic(
            textStyle: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        trailing: group.isAdmin()
            ? OutlinedButton(onPressed: () {}, child: Text(t.Admin))
            : group.isMember()
                ? OutlinedButton(onPressed: () {}, child: Text(t.Joined))
                : null,
      ),
    );
  }
}
