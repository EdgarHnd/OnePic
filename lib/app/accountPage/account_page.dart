import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onepic/app/accountPage/image_capture_page.dart';
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
                        Text(user.nbFollowing.toString() + ' following',
                            style: Theme.of(context).textTheme.headline),
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      child: Consumer(
                        builder: (context, watch, child) {
                          final imgUrl =
                              watch(imgUrlProvider(user.one + '.jpg'));
                          return imgUrl.when(
                            data: (url) => Image.network(url),
                            loading: () => CircularProgressIndicator(),
                            error: (_, __) => Container(),
                          );
                        },
                      ),
                    ),
                  ),
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
                    onPressed: () {
                      _showPhotoDialog(context);
                    }),
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
              style: TextStyle(color: Colors.black),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Once you reset your photo it will be deleted forever ! Are you sure ?'),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Yes'),
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

  /* Future<Widget> _getImage(BuildContext context, String imageName) async {
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
} */
}
