import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/app/accountPage/image_capture_page.dart';
import 'package:onepic/services/auth.dart';
import 'package:onepic/services/providers.dart';
import 'package:onepic/services/global.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                    color: AppColors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () async {
                      await FirebaseAuthHelper().logout();
                    }),
                Container(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(user.username ?? 'username',
                        style: Theme.of(context).textTheme.headline1),
                    Column(
                      children: [
                        Text(user.nbFollowing.toString() + ' following',
                            style: Theme.of(context).textTheme.headline2),
                        Text(user.followers.length.toString() + ' follows',
                            style: Theme.of(context).textTheme.headline2),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  FontAwesomeIcons.crown,
                                  color: AppColors.orange,
                                  size: 20,
                                ),
                              ),
                              Text('230',
                                  style: Theme.of(context).textTheme.headline3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Consumer(builder: (context, watch, child) {
                  final currentUserOne = watch(currentUserOneProvider);
                  return currentUserOne.when(
                    data: (one) => Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: one.url,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                FontAwesomeIcons.hotjar,
                                color: AppColors.red,
                                size: 35,
                              ),
                            ),
                            Text(one.nbLikes.toString(),
                                style: Theme.of(context).textTheme.bodyText2)
                          ])
                    ]),
                    loading: () => CircularProgressIndicator(),
                    error: (_, __) => Container(),
                  );
                }),
                IconButton(
                    icon: Icon(FontAwesomeIcons.redo),
                    iconSize: 50,
                    color: AppColors.purple,
                    onPressed: () {
                      _showPhotoDialog(context);
                    }),
                Container(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
          loading: () => CircularProgressIndicator(),
          error: (_, __) => Container(),
        );
      }),
    );
  }

  _showPhotoDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Reset Photo',
              style: Theme.of(context).textTheme.headline1,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Once you reset your photo it will be deleted forever !\nAre you sure ?'),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: AppColors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageCapture()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
