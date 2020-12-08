import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:onepic/services/auth.dart';
import 'package:onepic/services/providers.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(builder: (context, watch, child) {
        final currentUser = watch(currentUserProvider);
        return currentUser.when(
          data: (user) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                    child: Text(
                      'logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () async {
                      await FirebaseAuthHelper().logout();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(user.username ?? 'username',
                        style: TextStyle(
                            color: Colors.purpleAccent, fontSize: 30)),
                    Column(
                      children: [
                        Text(user.followers.length.toString() + ' follows',
                            style: Theme.of(context).textTheme.headline),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              CupertinoIcons.staroflife_fill,
                              color: Colors.amber,
                            ),
                            Text('230',
                                style: Theme.of(context).textTheme.headline),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          child: FutureBuilder(
                        future: _getImage(context, 'antoine.jpg'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: snapshot.data,
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: 330,
                              height: 330,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container();
                        },
                      ))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.flame_fill,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    Text('10',
                        style:
                            TextStyle(color: Colors.redAccent, fontSize: 40)),
                  ],
                ),
                IconButton(
                    icon: Icon(CupertinoIcons.refresh),
                    iconSize: 50,
                    color: Colors.purpleAccent,
                    onPressed: () {}),
              ],
            ),
          ),
          loading: () => CircularProgressIndicator(),
          error: (_, __) => Container(),
        );
      }),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    /* CachedNetwork */ Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      /* image = CachedNetworkImage(imageUrl: value.toString()); */
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return image;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance
        .ref('users_pics')
        .child(image)
        .getDownloadURL();
  }
}
