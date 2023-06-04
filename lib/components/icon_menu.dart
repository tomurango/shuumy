import 'package:flutter/material.dart';
import 'package:shuumy/auth_notifier.dart';
import 'package:provider/provider.dart';

class IconMenu extends StatelessWidget {
  const IconMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authNotifier, _) {
        final user = authNotifier.user;
        if(user!.photoURL != null){
            return PopupMenuButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                value: 'logout',
                child: Text('ログアウト'),
                ),
              ],
              onSelected: (value) {
                if (value == 'logout') {
                  Provider.of<AuthNotifier>(context, listen: false).signOut();
                }
              },
            );
        }else{
          return PopupMenuButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_avatar.png'),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text('ログアウト'),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                Provider.of<AuthNotifier>(context, listen: false).signOut();
              }
            },
          );
        }
      },
    );
  }
}
