import 'package:flutter/material.dart';

import '../../modules/chat/pages/chats/users_search_2.dart';
import '../searchpage.dart';
class UserPostBusiness extends StatelessWidget {
  const UserPostBusiness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(130,212,246, 1),
        elevation: 0.0,
        title: Image.asset('assets/images/MSearch.png'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListView(
            children: [
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsersSearchPageTwo()),
                        );
                      },
                      child: Image.asset('assets/images/User_1.png'),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsersSearchPageTwo()),
                        );
                      },
                      child: Image.asset('assets/images/User_2.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchBar()),
                  );
                },
                child: Image.asset('assets/images/post_1.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
