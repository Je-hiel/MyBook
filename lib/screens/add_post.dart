import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybook/models/user.dart';
import 'package:mybook/services/http_service.dart';
import 'package:mybook/widgets/bottom_nav_bar.dart';
import 'package:mybook/widgets/loading.dart';
import 'package:mybook/widgets/post_loading.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  HttpService hs = HttpService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  var posted = false; // Result from posting. Returned from http request.

  // Text field states
  String title = '';
  String body = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if (loading & posted == true) {
      return BottomNavBar();
    } else if (loading) {
      return Loading();
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  setState(() => loading = true);

                  dynamic result = await hs.addPost(user.uid, title, body);

                  setState(() {
                    if (result.runtimeType == String) {
                      error = result;
                      loading = false;
                    } else {
                      posted = result;
                    }
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'POST',
                  style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2),
                )),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // TODO Put button to pick which group to post to
                  SizedBox(height: 10.0),
                  TextFormField(
                    minLines: 1,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter a title.';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => title = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    maxLines: null,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Body',
                    ),
                    onChanged: (val) {
                      setState(() => body = val);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'camera',
                tooltip: 'Take a picture',
                child: Icon(Icons.add_a_photo),
                onPressed: () {},
              ),
              SizedBox(height: 10.0),
              FloatingActionButton(
                heroTag: 'gallery',
                tooltip: 'Add from gallery',
                child: Icon(Icons.add_photo_alternate),
                onPressed: () {},
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      );
    }
  }
}
